import ctypes
import io
import math
import pywasm.leb128
import pywasm.log
import pywasm.opcode
import struct
import typing


class ValType:
    # Value types are encoded by a single byte.

    def __init__(self, data: int) -> typing.Self:
        assert data in [0x7f, 0x7e, 0x7d, 0x7c, 0x7b, 0x70, 0x6f]
        self.data = data

    def __eq__(self, value: typing.Self) -> bool:
        return self.data == value.data

    def __hash__(self) -> int:
        return hash(self.data)

    def __repr__(self) -> str:
        return {
            0x7f: 'i32',
            0x7e: 'i64',
            0x7d: 'f32',
            0x7c: 'f64',
            0x70: 'ref.func',
            0x6f: 'ref.extern',
        }[self.data]

    @classmethod
    def i32(cls) -> typing.Self:
        return cls(0x7f)

    @classmethod
    def i64(cls) -> typing.Self:
        return cls(0x7e)

    @classmethod
    def f32(cls) -> typing.Self:
        return cls(0x7d)

    @classmethod
    def f64(cls) -> typing.Self:
        return cls(0x7c)

    @classmethod
    def ref_func(cls) -> typing.Self:
        return cls(0x70)

    @classmethod
    def ref_extern(cls) -> typing.Self:
        return cls(0x6f)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ord(r.read(1)))


class ValInst:
    # Values are represented by themselves.

    def __init__(self, type: ValType, data: bytearray) -> typing.Self:
        assert len(data) == 8
        self.type = type
        self.data = data

    def __eq__(self, value: typing.Self) -> bool:
        return self.type == value.type and self.data == value.data

    def __repr__(self) -> str:
        match self.type.data:
            case 0x7f:
                return f'{self.type} {self.into_i32()}'
            case 0x7e:
                return f'{self.type} {self.into_i64()}'
            case 0x7d:
                return f'{self.type} {self.into_f32()}'
            case 0x7c:
                return f'{self.type} {self.into_f64()}'
            case 0x70:
                return f'{self.type} {self.into_ref()}'
            case 0x6f:
                return f'{self.type} {self.into_ref()}'

    @classmethod
    def from_i32(cls, n: int) -> typing.Self:
        n = n & 0xffffffff
        n = n - ((n & 0x80000000) << 1)
        return cls(ValType.i32(), bytearray(struct.pack('<i', n)) + bytearray(4))

    @classmethod
    def from_i64(cls, n: int) -> typing.Self:
        n = n & 0xffffffffffffffff
        n = n - ((n & 0x8000000000000000) << 1)
        return cls(ValType.i64(), bytearray(struct.pack('<q', n)))

    @classmethod
    def from_u32(cls, n: int) -> typing.Self:
        n = n & 0xffffffff
        return cls(ValType.i32(), bytearray(struct.pack('<I', n)) + bytearray(4))

    @classmethod
    def from_u64(cls, n: int) -> typing.Self:
        n = n & 0xffffffffffffffff
        return cls(ValType.i64(), bytearray(struct.pack('<Q', n)))

    @classmethod
    def from_f32(cls, n: float) -> typing.Self:
        assert isinstance(n, float)
        n = ctypes.c_float(n).value
        return cls(ValType.f32(), bytearray(struct.pack('<f', n)) + bytearray(4))

    @classmethod
    def from_f32_u32(cls, n: int) -> typing.Self:
        o = cls.from_u32(n)
        o.type = ValType.f32()
        return o

    @classmethod
    def from_f64(cls, n: float) -> typing.Self:
        assert isinstance(n, float)
        return cls(ValType.f64(), bytearray(struct.pack('<d', n)))

    @classmethod
    def from_f64_u64(cls, n: int) -> typing.Self:
        o = cls.from_u64(n)
        o.type = ValType.f64()
        return o

    @classmethod
    def from_num(cls, type: ValType, n: typing.Union[int, float]) -> typing.Self:
        return {
            ValType.i32(): cls.from_i32,
            ValType.i64(): cls.from_i64,
            ValType.f32(): cls.from_f32,
            ValType.f64(): cls.from_f64,
        }[type](n)

    @classmethod
    def from_ref(cls, type: ValType, n: int) -> typing.Self:
        return cls(type, bytearray(struct.pack('<i', n)) + bytearray([0x01, 0x00, 0x00, 0x00]))

    def into_i32(self) -> int:
        return struct.unpack('<i', self.data[0:4])[0]

    def into_i64(self) -> int:
        return struct.unpack('<q', self.data[0:8])[0]

    def into_u32(self) -> int:
        return struct.unpack('<I', self.data[0:4])[0]

    def into_u64(self) -> int:
        return struct.unpack('<Q', self.data[0:8])[0]

    def into_f32(self) -> float:
        return struct.unpack('<f', self.data[0:4])[0]

    def into_f64(self) -> float:
        return struct.unpack('<d', self.data[0:8])[0]

    def into_num(self) -> typing.Union[int, float]:
        return {
            ValType.i32(): self.into_i32,
            ValType.i64(): self.into_i64,
            ValType.f32(): self.into_f32,
            ValType.f64(): self.into_f64,
        }[self.type]()

    def into_ref(self) -> int:
        assert self.data[4] == 0x01
        return self.into_i32()


class Bype:
    # Block types are encoded in special compressed form, by either the byte 0x40 indicating the empty type, as a
    # single value type, or as a type index encoded as a positive signed integer.

    def __init__(self, kind: int, data: int) -> typing.Self:
        assert kind in [0x00, 0x01, 0x02]
        self.kind = kind
        self.data = data

    def __eq__(self, value: typing.Self) -> bool:
        return self.kind == value.kind and self.data == value.data

    def __repr__(self) -> str:
        if self.kind == 0x00:
            return 'empty'
        if self.kind == 0x01:
            return repr(ValType(self.data))
        return repr(self.data)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = ord(r.read(1))
        if n == 0x40:
            return cls(0x00, 0x40)
        if n in [0x7f, 0x7e, 0x7d, 0x7c]:
            return cls(0x01, n)
        r.seek(-1, 1)
        return cls(0x02, pywasm.leb128.i.decode_reader(r)[0])


class Inst:
    # Instructions are encoded by opcodes. Each opcode is represented by a single byte, and is followed by the
    # instruction's immediate arguments, where present. The only exception are structured control instructions, which
    # consist of several opcodes bracketing their nested instruction sequences.

    def __init__(self, opcode: int, args: typing.List[typing.Any]) -> typing.Self:
        self.opcode = opcode
        self.args = args

    def __repr__(self) -> str:
        seps = [pywasm.opcode.name[self.opcode]]
        if self.opcode in [pywasm.opcode.block, pywasm.opcode.loop, pywasm.opcode.if_then]:
            seps.append(repr(self.args[0]))
            return ' '.join(seps)
        for e in self.args:
            seps.append(repr(e))
        return ' '.join(seps)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        o = Inst(ord(r.read(1)), [])
        match o.opcode:
            case pywasm.opcode.block:
                o.args.append(Bype.from_reader(r))
                o.args.append([])
                for _ in range(1 << 32):
                    i = Inst.from_reader(r)
                    if i.opcode == pywasm.opcode.end:
                        break
                    o.args[1].append(i)
            case pywasm.opcode.loop:
                o.args.append(Bype.from_reader(r))
                o.args.append([])
                for _ in range(1 << 32):
                    i = Inst.from_reader(r)
                    if i.opcode == pywasm.opcode.end:
                        break
                    o.args[1].append(i)
            case pywasm.opcode.if_then:
                o.args.append(Bype.from_reader(r))
                o.args.append([])
                o.args.append([])
                argidx = 1
                for _ in range(1 << 32):
                    i = Inst.from_reader(r)
                    if i.opcode == pywasm.opcode.end:
                        break
                    if i.opcode == pywasm.opcode.else_fi:
                        argidx = 2
                        continue
                    o.args[argidx].append(i)
            case pywasm.opcode.br:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.br_if:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.br_table:
                o.args.append([pywasm.leb128.u.decode_reader(r)[0] for _ in range(pywasm.leb128.u.decode_reader(r)[0])])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.call:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.call_indirect:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(ord(r.read(1)))
            case pywasm.opcode.select_type:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.local_get:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.local_set:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.local_tee:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.global_get:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.global_set:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.table_get:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.table_set:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_load:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_load:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.f32_load:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.f64_load:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_load8_s:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_load8_u:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_load16_s:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_load16_u:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_load8_s:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_load8_u:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_load16_s:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_load16_u:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_load32_s:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_load32_u:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_store:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_store:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.f32_store:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.f64_store:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_store8:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i32_store16:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_store8:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_store16:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.i64_store32:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case pywasm.opcode.memory_size:
                o.args.append(ord(r.read(1)))
            case pywasm.opcode.memory_grow:
                o.args.append(ord(r.read(1)))
            case pywasm.opcode.i32_const:
                o.args.append(pywasm.leb128.i.decode_reader(r)[0])
            case pywasm.opcode.i64_const:
                o.args.append(pywasm.leb128.i.decode_reader(r)[0])
            case pywasm.opcode.f32_const:
                # Python misinterpret 0x7fa00000 as 0x7fe00000, when encapsulate as built-in float type.
                # See: https://stackoverflow.com/questions/47961537/webassembly-f32-const-nan0x200000-means-0x7fa00000-or-0x7fe00000
                o.args.append(struct.unpack('<i', r.read(4))[0])
            case pywasm.opcode.f64_const:
                o.args.append(struct.unpack('<q', r.read(8))[0])
            case pywasm.opcode.ref_null:
                o.args.append(ord(r.read(1)))
            case pywasm.opcode.ref_func:
                o.args.append(pywasm.leb128.u.decode_reader(r)[0])
            case 0xfc:
                for e in pywasm.leb128.u.encode(pywasm.leb128.u.decode_reader(r)[0]):
                    o.opcode = (o.opcode << 8) + e
                match o.opcode:
                    case pywasm.opcode.memory_init:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                    case pywasm.opcode.data_drop:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                    case pywasm.opcode.table_init:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                    case pywasm.opcode.elem_drop:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                    case pywasm.opcode.table_copy:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                    case pywasm.opcode.table_grow:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                    case pywasm.opcode.table_size:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
                    case pywasm.opcode.table_fill:
                        o.args.append(pywasm.leb128.u.decode_reader(r)[0])
        return o


class Expr:
    # Function bodies, initialization values for globals, and offsets of element or data segments are given as
    # expressions, which are sequences of instructions terminated by an end marker.

    def __init__(self, data: typing.List[Inst]) -> typing.Self:
        self.data = data

    def __repr__(self) -> str:
        return repr(self.data)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        s = []
        for _ in range(1 << 32):
            i = Inst.from_reader(r)
            if i.opcode == pywasm.opcode.end:
                break
            s.append(i)
        return cls(s)


class LocalsDesc:
    # The locals declare a vector of mutable local variables and their types. These variables are referenced through
    # local indices in the function’s body. The index of the first local is the smallest index not referencing a
    # parameter.

    def __init__(self, n: int, type: ValType) -> typing.Self:
        self.n = n
        self.type = type

    def __repr__(self) -> str:
        return f'{self.n}x{self.type}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(pywasm.leb128.u.decode_reader(r)[0], ValType.from_reader(r))


class LocalsInst:
    # LocalsInst holds the values of function's locals (including arguments).

    def __init__(self, data: typing.List[ValInst]) -> typing.Self:
        self.data = data

    def __repr__(self) -> str:
        return repr(self.data)


class FuncType:
    # Function types are encoded by the byte 0x60 followed by the respective vectors of parameter and result types.
    # Function types classify the signature of functions, mapping a vector of parameters to a vector of results. They
    # are also used to classify the inputs and outputs of instructions.

    def __init__(self, args: typing.List[ValType], rets: typing.List[ValType]) -> typing.Self:
        self.args = args
        self.rets = rets

    def __eq__(self, value: typing.Self) -> bool:
        return self.args == value.args and self.rets == value.rets

    def __repr__(self) -> str:
        return f'{self.args} -> {self.rets}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        assert ord(r.read(1)) == 0x60
        n = pywasm.leb128.u.decode_reader(r)[0]
        args = [ValType.from_reader(r) for _ in range(n)]
        n = pywasm.leb128.u.decode_reader(r)[0]
        rets = [ValType.from_reader(r) for _ in range(n)]
        return cls(args, rets)


class FuncDesc:
    # The funcs component of a module defines a vector of functions with the following structure.
    # The type of a function declares its signature by reference to a type defined in the module. The parameters of the
    # function are referenced through 0-based local indices in the function's body; they are mutable.
    # The locals declare a vector of mutable local variables and their types. These variables are referenced through
    # local indices in the function's body. The index of the first local is the smallest index not referencing a
    # parameter.
    # The body is an instruction sequence that upon termination must produce a stack matching the function type's
    # result type.
    # Functions are referenced through function indices, starting with the smallest index not referencing a function
    # import.

    def __init__(self, type: int, locals: typing.List[LocalsDesc], expr: Expr) -> typing.Self:
        self.type = type
        self.locals = locals
        self.expr = expr

    def __repr__(self) -> str:
        return f'{self.type} {self.locals}'

    @classmethod
    def from_reader_type(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(pywasm.leb128.u.decode_reader(r)[0], [], Expr([]))

    @classmethod
    def from_reader_code(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(0, [LocalsDesc.from_reader(r) for _ in range(pywasm.leb128.u.decode_reader(r)[0])], Expr.from_reader(r))


class Limits:
    # Limits are encoded with a preceding flag indicating whether a maximum is present.

    def __init__(self, n: int, m: int) -> typing.Self:
        self.n = n
        self.m = m

    def __repr__(self) -> str:
        m = 'inf' if self.m == 0 else repr(self.m)
        return f'[{self.n}, {m}]'

    def suit(self, value: typing.Self) -> bool:
        c1 = self.n >= value.n
        c2 = value.m == 0
        c3 = self.m != 0 and value.m != 0 and self.m <= value.m
        return c1 and (c2 or c3)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        flag = ord(r.read(1))
        return cls(pywasm.leb128.u.decode_reader(r)[0],  pywasm.leb128.u.decode_reader(r)[0] if flag else 0x00)


class MemType:
    # Memory types classify linear memories and their size range. The limits constrain the minimum and optionally the
    # maximum size of a memory. The limits are given in units of page size -- the constant 65536 – abbreviated 64k.

    def __init__(self, limits: Limits) -> typing.Self:
        self.limits = limits

    def __repr__(self) -> str:
        return repr(self.limits)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(Limits.from_reader(r))


class MemInst:
    # A memory instance is the runtime representation of a linear memory. It holds a vector of bytes and an optional
    # maximum size, if one was specified at the definition site of the memory.
    #
    # The length of the vector always is a multiple of the WebAssembly page size, which is defined to be the constant
    # 65536 – abbreviated 64Ki. Like in a memory type, the maximum size in a memory instance is given in units of this
    # page size.
    #
    # The bytes can be mutated through memory instructions, the execution of a data segment, or by external means
    # provided by the embedder.
    #
    # It is an invariant of the semantics that the length of the byte vector, divided by page size, never exceeds the
    # maximum size, if present.

    def __init__(self, type: MemType) -> typing.Self:
        self.type = type
        self.data = bytearray()
        self.size = 0
        self.grow(type.limits.n)

    def grow(self, n: int) -> None:
        if self.type.limits.m:
            assert self.size + n <= self.type.limits.m
        assert self.size + n <= 65536
        self.data.extend([0x00 for _ in range(n * 64 * 1024)])
        self.size += n


class TableType:
    # Table types classify tables over elements of element types within a size range. Like memories, tables are
    # constrained by limits for their minimum and optionally maximum size. The limits are given in numbers of entries.
    # The element type funcref is the infinite union of all function types. A table of that type thus contains
    # references to functions of heterogeneous type.

    def __init__(self, type: ValType, limits: Limits) -> typing.Self:
        assert type in [ValType.ref_func(), ValType.ref_extern()]
        self.type = type
        self.limits = limits

    def __repr__(self) -> str:
        return f'{self.type} {self.limits}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ValType.from_reader(r), Limits.from_reader(r))


class TableInst:
    # A table instance is the runtime representation of a table. It holds a vector of function elements and an optional
    # maximum size, if one was specified in the table type at the table’s definition site.
    #
    # Each function element is either empty, representing an uninitialized table entry, or a function address. Function
    # elements can be mutated through the execution of an element segment or by external means provided by the embedder.
    #
    # It is an invariant of the semantics that the length of the element vector never exceeds the maximum size, if
    # present.

    def __init__(self, type: TableType) -> typing.Self:
        self.type = type
        self.elem = [0 for _ in range(type.limits.n)]


class GlobalType:
    # Global types are encoded by their value type and a flag for their mutability.

    def __init__(self, type: ValType, mut: int) -> typing.Self:
        assert mut in [0x00, 0x01]
        self.type = type
        self.mut = mut

    def __repr__(self) -> str:
        prefix = ['const', 'var'][self.mut]
        return f'{prefix} {self.type}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ValType.from_reader(r), ord(r.read(1)))


class GlobalDesc:
    # The globals component of a module defines a vector of global variables (or globals for short).

    def __init__(self, type: GlobalType, init: Expr) -> typing.Self:
        self.type = type
        self.init = init

    def __repr__(self) -> str:
        return repr(self.type)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(GlobalType.from_reader(r), Expr.from_reader(r))


class GlobalInst:
    # A global instance is the runtime representation of a global variable. It holds an individual value and a flag
    # indicating whether it is mutable. The value of mutable globals can be mutated through variable instructions or by
    # external means provided by the embedder.
    def __init__(self, data: ValInst, mut: int) -> typing.Self:
        assert mut in [0x00, 0x01]
        self.data = data
        self.mut = mut

    def __repr__(self) -> str:
        return f'{self.data}'


class Custom:
    # Custom sections have the id 0. They are intended to be used for debugging information or third-party extensions,
    # and are ignored by the WebAssembly semantics. Their contents consist of a name further identifying the custom
    # section, followed by an uninterpreted sequence of bytes for custom use.

    def __init__(self, name: str, data: bytearray) -> typing.Self:
        self.name = name
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = pywasm.leb128.u.decode_reader(r)[0]
        return cls(r.read(n).decode(), bytearray(r.read(-1)))


class Import:
    # The imports component of a module defines a set of imports that are required for instantiation.
    #
    # Each import is labeled by a two-level name space, consisting of a module name and a name for an entity within
    # that module. Importable definitions are functions, tables, memories, and globals. Each import is specified by a
    # descriptor with a respective type that a definition provided during instantiation is required to match. Every
    # import defines an index in the respective index space. In each index space, the indices of imports go before the
    # first index of any definition contained in the module itself.

    def __init__(self, module: str, name: str, kind: int, desc: typing.Any) -> typing.Self:
        self.module = module
        self.name = name
        self.kind = kind
        self.desc = desc

    def __repr__(self) -> str:
        kind = {
            0x00: 'func',
            0x01: 'table',
            0x02: 'mem',
            0x03: 'global'
        }[self.kind]
        return f'{self.module}.{self.name} {kind} {self.desc}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = pywasm.leb128.u.decode_reader(r)[0]
        module = r.read(n).decode()
        n = pywasm.leb128.u.decode_reader(r)[0]
        name = r.read(n).decode()
        type = ord(r.read(1))
        desc = {
            0x00: lambda r: pywasm.leb128.u.decode_reader(r)[0],
            0x01: TableType.from_reader,
            0x02: MemType.from_reader,
            0x03: GlobalType.from_reader,
        }[type](r)
        return cls(module, name, type, desc)


class Extern:
    # An external value is the runtime representation of an entity that can be imported or exported. It is an address
    # denoting either a function instance, table instance, memory instance, or global instances in the shared store.

    def __init__(self, kind: int, data: int) -> typing.Self:
        assert kind in [0x00, 0x01, 0x02, 0x03]
        self.kind = kind
        self.data = data

    def __repr__(self) -> str:
        prefix = {
            0x00: 'func',
            0x01: 'table',
            0x02: 'mem',
            0x03: 'global',
        }[self.kind]
        return f'{prefix} {self.data}'


class ExportDesc:
    # The exports component of a module defines a set of exports that become accessible to the host environment once
    # the module has been instantiated.
    #
    # Each export is labeled by a unique name. Exportable definitions are functions, tables, memories, and globals,
    # which are referenced through a respective descriptor.

    def __init__(self, name: str, kind: int, desc: int) -> typing.Self:
        assert kind in [0x00, 0x01, 0x02, 0x03]
        self.name = name
        self.kind = kind
        self.desc = desc

    def __repr__(self) -> str:
        type_name = {
            0x00: 'func',
            0x01: 'table',
            0x02: 'mem',
            0x03: 'global'
        }[self.kind]
        return f'{self.name} {type_name} {self.desc}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        name = bytearray(r.read(pywasm.leb128.u.decode_reader(r)[0])).decode()
        kind = ord(r.read(1))
        desc = pywasm.leb128.u.decode_reader(r)[0]
        return cls(name, kind, desc)


class ExportInst:
    # An export instance is the runtime representation of an export. It defines the export's name and the associated
    # external value.

    def __init__(self, name: str, data: Extern) -> typing.Self:
        self.name = name
        self.data = data

    def __repr__(self):
        return f'{self.name} {self.data}'


class ElemDesc:
    # The initial contents of a table is uninitialized. The elem component of a module defines a vector of element
    # segments that initialize a subrange of a table, at a given offset, from a static vector of elements.
    # The offset is given by a constant expression.

    def __init__(self, kind: int, type: ValType, tidx: int, offset: Expr, init: typing.List[Expr]) -> typing.Self:
        assert kind >= 0x00
        assert kind <= 0x07
        assert type == ValType.ref_func()
        self.kind = kind
        self.type = type
        self.tidx = tidx
        self.offset = offset
        self.init = init

    def __repr__(self) -> str:
        return f'{self.tidx}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        kind = pywasm.leb128.u.decode_reader(r)[0]
        type = ValType.ref_func()
        tidx = 0
        offset = Expr([])
        init = []
        match kind:
            case 0x00:
                offset = Expr.from_reader(r)
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    fidx = pywasm.leb128.u.decode_reader(r)[0]
                    expr = Expr([Inst(pywasm.opcode.ref_func, [fidx])])
                    init.append(expr)
            case 0x01:
                assert ord(r.read(1)) == 0x00
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    fidx = pywasm.leb128.u.decode_reader(r)[0]
                    expr = Expr([Inst(pywasm.opcode.ref_func, [fidx])])
                    init.append(expr)
            case 0x02:
                tidx = pywasm.leb128.u.decode_reader(r)[0]
                offset = Expr.from_reader(r)
                assert ord(r.read(1)) == 0x00
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    fidx = pywasm.leb128.u.decode_reader(r)[0]
                    expr = Expr([Inst(pywasm.opcode.ref_func, [fidx])])
                    init.append(expr)
            case 0x03:
                assert ord(r.read(1)) == 0x00
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    fidx = pywasm.leb128.u.decode_reader(r)[0]
                    expr = Expr([Inst(pywasm.opcode.ref_func, [fidx])])
                    init.append(expr)
            case 0x04:
                offset = Expr.from_reader(r)
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    expr = Expr.from_reader(r)
                    init.append(expr)
            case 0x05:
                type = ValType.from_reader(r)
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    expr = Expr.from_reader(r)
                    init.append(expr)
            case 0x06:
                tidx = pywasm.leb128.u.decode_reader(r)[0]
                offset = Expr.from_reader(r)
                type = ValType.from_reader(r)
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    expr = Expr.from_reader(r)
                    init.append(expr)
            case 0x07:
                type = ValType.from_reader(r)
                for _ in range(pywasm.leb128.u.decode_reader(r)[0]):
                    expr = Expr.from_reader(r)
                    init.append(expr)
        return cls(kind, type, tidx, offset, init)


class ElemInst:
    # An element instance is the runtime representation of an element segment. It holds a vector of references and
    # their common type.

    def __init__(self, type: ValType, data: typing.List[ValType]) -> typing.Self:
        assert type in [ValType.ref_func(), ValType.ref_extern()]
        self.type = type
        self.data = data

    def __repr__(self) -> str:
        return f'{self.type}'


class DataDesc:
    # The initial contents of a memory are zero-valued bytes. The data component of a module defines a vector of data
    # segments that initialize a range of memory, at a given offset, with a static vector of bytes.
    # The offset is given by a constant expression.

    def __init__(self, kind: int, midx: int, offset: Expr, init: bytearray) -> typing.Self:
        # The initial integer can be interpreted as a bitfield. Bit 0 indicates a passive segment, bit 1 indicates the
        # presence of an explicit memory index for an active segment.
        # In the current version of WebAssembly, at most one memory may be defined or imported in a single module, so
        # all valid active data segments have a memory value of 0.
        assert kind in [0x00, 0x01, 0x02]
        assert midx == 0x00
        self.kind = kind
        self.midx = midx
        self.offset = offset
        self.init = init

    def __repr__(self) -> str:
        return f'{self.midx}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        kind = pywasm.leb128.u.decode_reader(r)[0]
        match kind:
            case 0x00:
                midx = 0
                offset = Expr.from_reader(r)
                init = bytearray(r.read(pywasm.leb128.u.decode_reader(r)[0]))
            case 0x01:
                midx = 0
                offset = Expr([])
                init = bytearray(r.read(pywasm.leb128.u.decode_reader(r)[0]))
            case 0x02:
                midx = pywasm.leb128.u.decode_reader(r)[0]
                offset = Expr.from_reader(r)
                init = bytearray(r.read(pywasm.leb128.u.decode_reader(r)[0]))
        return cls(kind, midx, offset, init)


class DataInst:
    # An data instance is the runtime representation of a data segment. It holds a vector of bytes.

    def __init__(self, data: bytearray) -> typing.Self:
        self.data = data

    def __repr__(self) -> str:
        return f'data'


class ModuleDesc:
    # The binary encoding of modules is organized into sections. Most sections correspond to one component of a module
    # record, except that function definitions are split into two sections, separating their type declarations in the
    # function section from their bodies in the code section.

    def __init__(
        self,
        type: typing.List[FuncType],
        func: typing.List[FuncDesc],
        tabl: typing.List[TableType],
        mems: typing.List[MemType],
        glob: typing.List[GlobalDesc],
        elem: typing.List[ElemDesc],
        data: typing.List[DataDesc],
        star: int,
        imps: typing.List[Import],
        exps: typing.List[ExportDesc]
    ):
        self.type = type
        self.func = func
        self.tabl = tabl
        self.mems = mems
        self.glob = glob
        self.elem = elem
        self.data = data
        self.star = star
        self.imps = imps
        self.exps = exps

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        assert bytearray(r.read(4)) == bytearray([0x00, 0x61, 0x73, 0x6d])
        assert bytearray(r.read(4)) == bytearray([0x01, 0x00, 0x00, 0x00])

        type: typing.List[FuncType] = []
        func: typing.List[FuncDesc] = []
        tabl: typing.List[TableType] = []
        mems: typing.List[MemType] = []
        glob: typing.List[GlobalDesc] = []
        elem: typing.List[ElemDesc] = []
        data: typing.List[DataDesc] = []
        star: int = -1
        imps: typing.List[Import] = []
        exps: typing.List[ExportDesc] = []

        for _ in range(32):
            section_id_byte = r.read(1)
            if not section_id_byte:
                break
            section_id = ord(section_id_byte)
            n = pywasm.leb128.u.decode_reader(r)[0]
            section_data = bytearray(r.read(n))
            assert len(section_data) == n
            section_reader = io.BytesIO(section_data)

            match section_id:
                case 0x00:
                    desc = Custom.from_reader(section_reader)
                    pywasm.log.debugln('section custom', desc.name)
                case 0x01:
                    pywasm.log.debugln('section type')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = FuncType.from_reader(section_reader)
                        type.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x02:
                    pywasm.log.debugln('section import')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = Import.from_reader(section_reader)
                        imps.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x03:
                    pywasm.log.debugln('section func')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = FuncDesc.from_reader_type(section_reader)
                        func.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc.type}')
                case 0x04:
                    pywasm.log.debugln('section table')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = TableType.from_reader(section_reader)
                        tabl.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x05:
                    pywasm.log.debugln('section mem')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = MemType.from_reader(section_reader)
                        mems.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x06:
                    pywasm.log.debugln('section global')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = GlobalDesc.from_reader(section_reader)
                        glob.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x07:
                    pywasm.log.debugln('section export')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = ExportDesc.from_reader(section_reader)
                        exps.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x08:
                    desc = pywasm.leb128.u.decode_reader(section_reader)[0]
                    star = desc
                    pywasm.log.debugln('section start', desc)
                case 0x09:
                    pywasm.log.debugln('section elem')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = ElemDesc.from_reader(section_reader)
                        elem.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x0a:
                    pywasm.log.debugln('section code')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        size = pywasm.leb128.u.decode_reader(section_reader)[0]
                        desc = FuncDesc.from_reader_code(io.BytesIO(section_reader.read(size)))
                        func[i].locals = desc.locals
                        func[i].expr = desc.expr
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x0b:
                    pywasm.log.debugln('section data')
                    for i in range(pywasm.leb128.u.decode_reader(section_reader)[0]):
                        desc = DataDesc.from_reader(section_reader)
                        data.append(desc)
                        pywasm.log.debugln(f'    {i:>3d} {desc}')
                case 0x0c:
                    n = pywasm.leb128.u.decode_reader(section_reader)[0]
                    pywasm.log.debugln('section data count', n)

        return cls(type, func, tabl, mems, glob, elem, data, star, imps, exps)


class ModuleInst:
    # A module instance is the runtime representation of a module. It is created by instantiating a module, and
    # collects runtime representations of all entities that are imported, defined, or exported by the module.

    def __init__(self) -> typing.Self:
        self.type: typing.List[FuncType] = []
        self.func: typing.List[int] = []
        self.tabl: typing.List[int] = []
        self.mems: typing.List[int] = []
        self.glob: typing.List[int] = []
        self.elem: typing.List[int] = []
        self.data: typing.List[int] = []
        self.exps: typing.List[ExportInst] = []


class FuncInst:
    # It effectively is a closure of the original function over the runtime module instance of its originating module.

    def __init__(self, type: FuncType, module: ModuleInst, code: FuncDesc) -> typing.Self:
        self.kind = 0x00
        self.type = type
        self.module = module
        self.code = code

    def __repr__(self) -> str:
        return f'{self.type}'


class FuncHost:
    # A host function is a function expressed outside WebAssembly but passed to a module as an import. The definition
    # and behavior of host functions are outside the scope of this specification. For the purpose of this
    # specification, it is assumed that when invoked, a host function behaves non-deterministically, but within certain
    # constraints that ensure the integrity of the runtime.

    def __init__(self, type: FuncType, hostcode: typing.Callable) -> typing.Self:
        self.kind = 0x01
        self.type = type
        self.hostcode = hostcode

    def __repr__(self) -> str:
        return self.hostcode.__name__


class Store:
    # The store represents all global state that can be manipulated by WebAssembly programs. It consists of the runtime
    # representation of all instances of functions, tables, memories, and globals that have been allocated during the
    # life time of the abstract machine

    def __init__(self):
        self.func: typing.List[FuncInst | FuncHost] = []
        self.tabl: typing.List[TableInst] = []
        self.mems: typing.List[MemInst] = []
        self.glob: typing.List[GlobalInst] = []
        self.elem: typing.List[ElemInst] = []
        self.data: typing.List[DataInst] = []

    def allocate_func_wasm(self, module: ModuleInst, func: FuncDesc) -> int:
        addr = len(self.func)
        type = module.type[func.type]
        inst = FuncInst(type, module, func)
        self.func.append(inst)
        return addr

    def allocate_func_host(self, func: FuncHost) -> int:
        addr = len(self.func)
        self.func.append(func)
        return addr

    def allocate_table(self, type: TableType) -> int:
        addr = len(self.tabl)
        inst = TableInst(type)
        self.tabl.append(inst)
        return addr

    def allocate_memory(self, type: MemType) -> int:
        addr = len(self.mems)
        inst = MemInst(type)
        self.mems.append(inst)
        return addr

    def allocate_global(self, type: GlobalType, data: ValInst) -> int:
        addr = len(self.glob)
        inst = GlobalInst(data, type.mut)
        self.glob.append(inst)
        return addr


class Label:
    # Labels carry an argument arity n and their associated branch target, which is expressed syntactically as an
    # instruction sequence.

    def __init__(self, arity: int, frame: int, value: int, carry: int, instr: typing.List[Inst], index: int) -> typing.Self:
        assert carry in [0x00, 0x01, 0x03]
        self.arity = arity
        self.frame = frame
        self.value = value
        self.carry = carry
        self.instr = instr
        self.index = index

    def __repr__(self) -> str:
        return f'{self.arity}'


class Frame:
    # Activation frames carry the return arity n of the respective function, hold the values of its locals
    # (including arguments) in the order corresponding to their static local indices, and a reference to the function's
    # own module instance.

    def __init__(self, module: ModuleInst, locals: LocalsInst, arity: int, label: int, value: int) -> typing.Self:
        self.module = module
        self.locals = locals
        self.arity = arity
        self.label = label
        self.value = value

    def __repr__(self) -> str:
        return f'{self.arity}'


class Stack:
    # Besides the store, most instructions interact with an implicit stack. The stack contains three kinds of entries:
    #
    # Values: the operands of instructions.
    # Labels: active structured control instructions that can be targeted by branches.
    # Activations: the call frames of active function calls.
    #
    # These entries can occur on the stack in any order during the execution of a program. Stack entries are described
    # by abstract syntax as follows.

    def __init__(self) -> typing.Self:
        self.value: typing.List[ValInst] = []
        self.label: typing.List[Label] = []
        self.frame: typing.List[Frame] = []


class Machine:
    # Execution behavior is defined in terms of an abstract machine that models the program state. It includes a stack,
    # which records operand values and control constructs, and an abstract store containing global state.

    def __init__(self) -> typing.Self:
        self.store = Store()
        self.stack = Stack()

    def allocate(
        self,
        module: ModuleDesc,
        extern: typing.List[Extern],
        globin: typing.List[ValInst],
        elemin: typing.List[typing.List[ValInst]]
    ) -> ModuleInst:
        inst = ModuleInst()
        inst.type = module.type
        for e in extern:
            match e.kind:
                case 0x00:
                    inst.func.append(e.data)
                case 0x01:
                    inst.tabl.append(e.data)
                case 0x02:
                    inst.mems.append(e.data)
                case 0x03:
                    inst.glob.append(e.data)
        for _, e in enumerate(module.func):
            addr = self.store.allocate_func_wasm(inst, e)
            inst.func.append(addr)
        for _, e in enumerate(module.tabl):
            addr = self.store.allocate_table(e)
            inst.tabl.append(addr)
        for _, e in enumerate(module.mems):
            addr = self.store.allocate_memory(e)
            inst.mems.append(addr)
        for i, e in enumerate(module.glob):
            addr = self.store.allocate_global(e.type, globin[i])
            inst.glob.append(addr)
        for _, e in enumerate(module.exps):
            expi = ExportInst(e.name, Extern(e.kind, 0))
            match e.kind:
                case 0x00:
                    expi.data.data = inst.func[e.desc]
                case 0x01:
                    expi.data.data = inst.tabl[e.desc]
                case 0x02:
                    expi.data.data = inst.mems[e.desc]
                case 0x03:
                    expi.data.data = inst.glob[e.desc]
            inst.exps.append(expi)
        return inst

    def instance(self, module: ModuleDesc, extern: typing.List[Extern]) -> ModuleInst:
        assert len(module.imps) == len(extern)
        for a, b in zip(module.imps, extern):
            assert a.kind == b.kind
            match a.kind:
                case 0x00:
                    assert self.store.func[b.data].type == module.type[a.desc]
                case 0x01:
                    assert self.store.tabl[b.data].type.type == a.desc.type
                    assert self.store.tabl[b.data].type.limits.suit(a.desc.limits)
                case 0x02:
                    assert self.store.mems[b.data].type.limits.suit(a.desc.limits)
                case 0x03:
                    assert self.store.glob[b.data].data.type == a.desc.type
                    assert self.store.glob[b.data].mut == a.desc.mut
        globin: typing.List[ValInst] = []
        elemin: typing.List[typing.List[ValInst]] = []
        auxmod = ModuleInst()
        auxmod.func.extend([e.data for e in extern if e.kind == 0x00])
        auxmod.func.extend([len(self.store.func) + i for i in range(len(module.func))])
        auxmod.glob.extend([e.data for e in extern if e.kind == 0x03])
        self.stack.frame.append(Frame(auxmod, LocalsInst([]), 1, 0, 0))
        pywasm.log.debugln(f'init global')
        for i, e in enumerate(module.glob):
            self.stack.label.append(Label(1, 1, 0, 1, e.init.data, 0))
            self.evaluate()
            assert len(self.stack.frame) == 1
            assert len(self.stack.label) == 0
            assert len(self.stack.value) == 1
            rets = self.stack.value.pop()
            pywasm.log.debugln(f'    {i:>3d} {rets}')
            globin.append(rets)
        pywasm.log.debugln('init elem')
        for i, e in enumerate(module.elem):
            l: typing.List[ValInst] = []
            for j, f in enumerate(e.init):
                self.stack.label.append(Label(1, 1, 0, 1, f.data, 0))
                self.evaluate()
                assert len(self.stack.frame) == 1
                assert len(self.stack.label) == 0
                assert len(self.stack.value) == 1
                rets = self.stack.value.pop()
                assert rets.type == ValType.ref_func()
                pywasm.log.debugln(f'    {i:>3d} {j:>3d} {rets}')
                l.append(rets)
            elemin.append(l)
        self.stack.frame.pop()
        newmod = self.allocate(module, extern, globin, elemin)
        assert newmod.func == auxmod.func
        self.stack.frame.append(Frame(newmod, LocalsInst([]), 0, 0, 0))
        pywasm.log.debugln('init elem')
        for i, e in enumerate(module.elem):
            self.stack.label.append(Label(1, 1, 0, 1, e.offset.data, 0))
            self.evaluate()
            assert len(self.stack.frame) == 1
            assert len(self.stack.label) == 0
            assert len(self.stack.value) == 1
            rets = self.stack.value.pop()
            assert rets.type == ValType.i32()
            pywasm.log.debugln(f'    {i:>3d} {rets}')
            tabl = self.store.tabl[newmod.tabl[e.tidx]]
            offs = rets.into_i32()
            for i, e in enumerate(e.init):
                self.stack.label.append(Label(1, 1, 0, 1, e.data, 0))
                self.evaluate()
                assert len(self.stack.frame) == 1
                assert len(self.stack.label) == 0
                assert len(self.stack.value) == 1
                rets = self.stack.value.pop()
                assert rets.type == ValType.ref_func()
                tabl.elem[offs + i] = rets.into_i32()
        pywasm.log.debugln('init data')
        for i, e in enumerate(module.data):
            self.stack.label.append(Label(1, 1, 0, 1, e.offset.data, 0))
            self.evaluate()
            assert len(self.stack.frame) == 1
            assert len(self.stack.label) == 0
            assert len(self.stack.value) == 1
            rets = self.stack.value.pop()
            assert rets.type == ValType.i32()
            pywasm.log.debugln(f'    {i:>3d} {rets}')
            mems = self.store.mems[newmod.mems[e.midx]]
            offs = rets.into_i32()
            for i, e in enumerate(e.init):
                mems.data[offs + i] = e
        self.stack.frame.pop()
        if module.star >= 0:
            addr = newmod.func[module.star]
            func = self.store.func[addr]
            assert len(func.type.args) == 0
            assert len(func.type.rets) == 0
            self.evaluate_call(addr)
            self.evaluate()
            assert len(self.stack.frame) == 0
            assert len(self.stack.label) == 0
            assert len(self.stack.value) == 0
        return newmod

    def invocate(self, addr: int, args: typing.List[ValInst]) -> typing.List[ValInst]:
        func = self.store.func[addr]
        assert func.kind == 0x00
        for a, b in zip(func.type.args, args):
            assert a == b.type
        self.stack.frame.append(Frame(ModuleInst(), LocalsInst([]), 0, 0, 0))
        pywasm.log.debugln(f'call {func} {args}')
        locals = LocalsInst(args)
        for e in func.code.locals:
            locals.data.extend([ValInst(e.type, bytearray(8)) for _ in range(e.n)])
        self.stack.frame.append(Frame(func.module, locals, len(func.type.rets), 0, 0))
        self.stack.label.append(Label(len(func.type.rets), 1, 0, 3, func.code.expr.data, 0))
        self.evaluate()
        rets = [self.stack.value.pop() for _ in range(len(func.type.rets))][::-1]
        for a, b in zip(func.type.rets, rets):
            assert a == b.type
        self.stack.frame.pop()
        assert len(self.stack.frame) == 0
        assert len(self.stack.label) == 0
        assert len(self.stack.value) == 0
        return rets

    def evaluate_br(self, l: int) -> None:
        assert len(self.stack.label) >= l + 1
        label = self.stack.label[-1 - l]
        assert len(self.stack.value) >= label.value + label.arity
        rets = [self.stack.value.pop() for _ in range(label.arity)][::-1]
        self.stack.frame = self.stack.frame[:label.frame]
        self.stack.label = self.stack.label[:len(self.stack.label)-l]
        match label.carry & 1:
            case 0x00:
                label.index = 0
            case 0x01:
                self.stack.label.pop()
        self.stack.value = self.stack.value[:label.value]
        self.stack.value.extend(rets)

    def evaluate_bype(self, bype: Bype) -> FuncType:
        match bype.kind:
            case 0x00:
                return FuncType([], [])
            case 0x01:
                return FuncType([], [ValType(bype.data)])
            case 0x02:
                return self.stack.frame[-1].module.type[bype.data]

    def evaluate_call(self, addr: int) -> None:
        func = self.store.func[addr]
        args = [self.stack.value.pop() for _ in range(len(func.type.args))][::-1]
        nret = len(func.type.rets)
        pywasm.log.debugln(f'call {func} {args}')
        match func.kind:
            case 0x00:
                locals = LocalsInst(args)
                for e in func.code.locals:
                    locals.data.extend([ValInst(e.type, bytearray(8)) for _ in range(e.n)])
                self.stack.frame.append(Frame(
                    func.module,
                    locals,
                    nret,
                    len(self.stack.label),
                    len(self.stack.value),
                ))
                self.stack.label.append(Label(
                    nret,
                    len(self.stack.frame),
                    len(self.stack.value),
                    3,
                    func.code.expr.data,
                    0,
                ))
            case 0x01:
                match nret:
                    case 0x00:
                        rets = func.hostcode(self, *[e.into_num() for e in args])
                        assert rets is None
                    case 0x01:
                        rets = func.hostcode(self, *[e.into_num() for e in args])
                        self.stack.value.append(ValInst.from_num(func.type.rets[0], rets))
                    case _:
                        rets = func.hostcode(self, *[e.into_num() for e in args])
                        rets = [ValInst.from_num(a, b) for a, b in zip(func.type.rets, rets)]
                        self.stack.value.extend(rets)
            case _:
                assert 0

    def evaluate_mem_load(self, offset: int, size: int) -> bytearray:
        inst = self.store.mems[self.stack.frame[-1].module.mems[0]]
        addr = self.stack.value.pop().into_i32()
        addr = addr + offset
        assert addr >= 0 and addr + size <= len(inst.data)
        return inst.data[addr:addr+size]

    def evaluate_mem_save(self, offset: int, size: int) -> bytearray:
        inst = self.store.mems[self.stack.frame[-1].module.mems[0]]
        data = self.stack.value.pop().data
        addr = self.stack.value.pop().into_i32()
        addr = addr + offset
        assert addr >= 0 and addr + size <= len(inst.data)
        inst.data[addr:addr+size] = data[:size]

    def evaluate(self) -> None:
        for _ in range(1 << 32):
            if not self.stack.label:
                break
            label = self.stack.label[-1]
            frame = self.stack.frame[-1]
            if label.index == len(label.instr):
                self.stack.label.pop()
                if label.carry & 2:
                    assert len(self.stack.value) == frame.value + frame.arity
                    self.stack.frame.pop()
                continue
            instr = label.instr[label.index]
            label.index += 1
            pywasm.log.debugln(f'    {instr}')
            match instr.opcode:
                case pywasm.opcode.unreachable:
                    assert 0
                case pywasm.opcode.nop:
                    assert 1
                case pywasm.opcode.block:
                    bype = self.evaluate_bype(instr.args[0])
                    assert len(self.stack.value) >= label.value + len(bype.args)
                    self.stack.label.append(Label(
                        len(bype.rets),
                        len(self.stack.frame),
                        len(self.stack.value) - len(bype.args),
                        1,
                        instr.args[1],
                        0,
                    ))
                case pywasm.opcode.loop:
                    bype = self.evaluate_bype(instr.args[0])
                    assert len(self.stack.value) >= label.value + len(bype.args)
                    self.stack.label.append(Label(
                        len(bype.args),
                        len(self.stack.frame),
                        len(self.stack.value) - len(bype.args),
                        0,
                        instr.args[1],
                        0,
                    ))
                case pywasm.opcode.if_then:
                    bype = self.evaluate_bype(instr.args[0])
                    cond = self.stack.value.pop().into_i32()
                    assert len(self.stack.value) >= label.value + len(bype.args)
                    aidx = 1 if cond != 0 else 2
                    self.stack.label.append(Label(
                        len(bype.rets),
                        len(self.stack.frame),
                        len(self.stack.value) - len(bype.args),
                        1,
                        instr.args[aidx],
                        0,
                    ))
                case pywasm.opcode.else_fi:
                    assert 0
                case pywasm.opcode.end:
                    assert 0
                case pywasm.opcode.br:
                    self.evaluate_br(instr.args[0])
                case pywasm.opcode.br_if:
                    if self.stack.value.pop().into_i32() != 0:
                        self.evaluate_br(instr.args[0])
                case pywasm.opcode.br_table:
                    a = self.stack.value.pop().into_u32()
                    b = instr.args[1]
                    if a < len(instr.args[0]):
                        b = instr.args[0][a]
                    self.evaluate_br(b)
                case pywasm.opcode.return_call:
                    assert len(self.stack.value) >= frame.value + frame.arity
                    rets = [self.stack.value.pop() for _ in range(frame.arity)][::-1]
                    self.stack.frame.pop()
                    self.stack.label = self.stack.label[:frame.label]
                    self.stack.value = self.stack.value[:frame.value]
                    self.stack.value.extend(rets)
                case pywasm.opcode.call:
                    addr = frame.module.func[instr.args[0]]
                    self.evaluate_call(addr)
                case pywasm.opcode.call_indirect:
                    tabl = self.store.tabl[frame.module.tabl[instr.args[1]]]
                    type = frame.module.type[instr.args[0]]
                    addr = tabl.elem[self.stack.value.pop().into_i32()]
                    assert self.store.func[addr].type == type
                    self.evaluate_call(addr)
                case pywasm.opcode.drop:
                    self.stack.value.pop()
                case pywasm.opcode.select:
                    c = self.stack.value.pop().into_i32()
                    b = self.stack.value.pop()
                    a = self.stack.value.pop()
                    d = a if c != 0 else b
                    self.stack.value.append(d)
                case pywasm.opcode.select_type:
                    c = self.stack.value.pop().into_i32()
                    b = self.stack.value.pop()
                    a = self.stack.value.pop()
                    d = a if c != 0 else b
                    self.stack.value.append(d)
                case pywasm.opcode.local_get:
                    a = self.stack.frame[-1].locals.data[instr.args[0]]
                    self.stack.value.append(a)
                case pywasm.opcode.local_set:
                    a = self.stack.value.pop()
                    self.stack.frame[-1].locals.data[instr.args[0]] = a
                case pywasm.opcode.local_tee:
                    a = self.stack.value[-1]
                    self.stack.frame[-1].locals.data[instr.args[0]] = a
                case pywasm.opcode.global_get:
                    glob = self.store.glob[frame.module.glob[instr.args[0]]]
                    self.stack.value.append(glob.data)
                case pywasm.opcode.global_set:
                    glob = self.store.glob[frame.module.glob[instr.args[0]]]
                    assert glob.mut == 0x01
                    glob.data = self.stack.value.pop()
                case pywasm.opcode.table_get:
                    assert 0
                case pywasm.opcode.table_set:
                    assert 0
                case pywasm.opcode.i32_load:
                    a = ValInst.from_i32(struct.unpack('<i', self.evaluate_mem_load(instr.args[1], 4))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_load:
                    a = ValInst.from_i64(struct.unpack('<q', self.evaluate_mem_load(instr.args[1], 8))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.f32_load:
                    a = ValInst.from_f32(struct.unpack('<f', self.evaluate_mem_load(instr.args[1], 4))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.f64_load:
                    a = ValInst.from_f64(struct.unpack('<d', self.evaluate_mem_load(instr.args[1], 8))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i32_load8_s:
                    a = ValInst.from_i32(struct.unpack('<b', self.evaluate_mem_load(instr.args[1], 1))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i32_load8_u:
                    a = ValInst.from_i32(struct.unpack('<B', self.evaluate_mem_load(instr.args[1], 1))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i32_load16_s:
                    a = ValInst.from_i32(struct.unpack('<h', self.evaluate_mem_load(instr.args[1], 2))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i32_load16_u:
                    a = ValInst.from_i32(struct.unpack('<H', self.evaluate_mem_load(instr.args[1], 2))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_load8_s:
                    a = ValInst.from_i64(struct.unpack('<b', self.evaluate_mem_load(instr.args[1], 1))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_load8_u:
                    a = ValInst.from_i64(struct.unpack('<B', self.evaluate_mem_load(instr.args[1], 1))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_load16_s:
                    a = ValInst.from_i64(struct.unpack('<h', self.evaluate_mem_load(instr.args[1], 2))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_load16_u:
                    a = ValInst.from_i64(struct.unpack('<H', self.evaluate_mem_load(instr.args[1], 2))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_load32_s:
                    a = ValInst.from_i64(struct.unpack('<i', self.evaluate_mem_load(instr.args[1], 4))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_load32_u:
                    a = ValInst.from_i64(struct.unpack('<I', self.evaluate_mem_load(instr.args[1], 4))[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i32_store:
                    self.evaluate_mem_save(instr.args[1], 4)
                case pywasm.opcode.i64_store:
                    self.evaluate_mem_save(instr.args[1], 8)
                case pywasm.opcode.f32_store:
                    self.evaluate_mem_save(instr.args[1], 4)
                case pywasm.opcode.f64_store:
                    self.evaluate_mem_save(instr.args[1], 8)
                case pywasm.opcode.i32_store8:
                    self.evaluate_mem_save(instr.args[1], 1)
                case pywasm.opcode.i32_store16:
                    self.evaluate_mem_save(instr.args[1], 2)
                case pywasm.opcode.i64_store8:
                    self.evaluate_mem_save(instr.args[1], 1)
                case pywasm.opcode.i64_store16:
                    self.evaluate_mem_save(instr.args[1], 2)
                case pywasm.opcode.i64_store32:
                    self.evaluate_mem_save(instr.args[1], 4)
                case pywasm.opcode.memory_size:
                    mems = self.store.mems[frame.module.mems[0]]
                    size = mems.size
                    self.stack.value.append(ValInst.from_i32(size))
                case pywasm.opcode.memory_grow:
                    mems = self.store.mems[frame.module.mems[0]]
                    size = mems.size
                    incr = self.stack.value.pop().into_i32()
                    rets = -1
                    # Limit memory size to 64m.
                    cnda = size + incr <= 1024
                    cndb = mems.type.limits.m == 0 or size + incr <= mems.type.limits.m
                    if cnda and cndb:
                        rets = size
                        mems.grow(incr)
                    self.stack.value.append(ValInst.from_i32(rets))
                case pywasm.opcode.i32_const:
                    a = ValInst.from_i32(instr.args[0])
                    self.stack.value.append(a)
                case pywasm.opcode.i64_const:
                    a = ValInst.from_i64(instr.args[0])
                    self.stack.value.append(a)
                case pywasm.opcode.f32_const:
                    a = ValInst.from_i32(instr.args[0])
                    a.type = ValType.f32()
                    self.stack.value.append(a)
                case pywasm.opcode.f64_const:
                    a = ValInst.from_i64(instr.args[0])
                    a.type = ValType.f64()
                    self.stack.value.append(a)
                case pywasm.opcode.i32_eqz:
                    a = self.stack.value.pop().into_i32()
                    b = ValInst.from_i32(a == 0)
                    self.stack.value.append(b)
                case pywasm.opcode.i32_eq:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a == b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_ne:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a != b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_lt_s:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a < b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_lt_u:
                    b = self.stack.value.pop().into_u32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(a < b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_gt_s:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a > b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_gt_u:
                    b = self.stack.value.pop().into_u32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(a > b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_le_s:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a <= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_le_u:
                    b = self.stack.value.pop().into_u32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(a <= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_ge_s:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a >= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_ge_u:
                    b = self.stack.value.pop().into_u32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(a >= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_eqz:
                    a = self.stack.value.pop().into_i64()
                    b = ValInst.from_i32(a == 0)
                    self.stack.value.append(b)
                case pywasm.opcode.i64_eq:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i32(a == b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_ne:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i32(a != b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_lt_s:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i32(a < b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_lt_u:
                    b = self.stack.value.pop().into_u64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i32(a < b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_gt_s:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i32(a > b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_gt_u:
                    b = self.stack.value.pop().into_u64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i32(a > b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_le_s:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i32(a <= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_le_u:
                    b = self.stack.value.pop().into_u64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i32(a <= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_ge_s:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i32(a >= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_ge_u:
                    b = self.stack.value.pop().into_u64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i32(a >= b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_eq:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_i32(a == b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_ne:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_i32(a != b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_lt:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_i32(a < b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_gt:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_i32(a > b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_le:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_i32(a <= b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_ge:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_i32(a >= b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_eq:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_i32(a == b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_ne:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_i32(a != b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_lt:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_i32(a < b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_gt:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_i32(a > b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_le:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_i32(a <= b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_ge:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_i32(a >= b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_clz:
                    a = self.stack.value.pop().into_u32()
                    b = 0
                    for _ in range(32):
                        if a & 0x80000000 != 0:
                            break
                        b += 1
                        a = a << 1
                    c = ValInst.from_i32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_ctz:
                    a = self.stack.value.pop().into_u32()
                    b = 0
                    for _ in range(32):
                        if a & 0x00000001 != 0:
                            break
                        b += 1
                        a = a >> 1
                    c = ValInst.from_i32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_popcnt:
                    a = self.stack.value.pop().into_u32()
                    b = 0
                    for _ in range(32):
                        if a & 0x00000001 != 0:
                            b += 1
                        a = a >> 1
                    c = ValInst.from_i32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_add:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a + b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_sub:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a - b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_mul:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a * b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_div_s:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    # Python's default division of integers is return the floor (towards negative infinity) with no
                    # ability to change that. You can read the BDFL's reason why.
                    # See: https://python-history.blogspot.com/2010/08/why-pythons-integer-division-floors.html
                    # But in webassembly, it requires do truncation towards zero.
                    c = a // b if a * b > 0 else (a + (-a % b)) // b
                    d = ValInst.from_i32(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i32_div_u:
                    b = self.stack.value.pop().into_u32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(a // b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_rem_s:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = a % b if a * b > 0 else -(-a % b)
                    d = ValInst.from_i32(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i32_rem_u:
                    b = self.stack.value.pop().into_u32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(a % b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_and:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a & b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_or:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a | b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_xor:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a ^ b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_shl:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a << (b % 0x20))
                    self.stack.value.append(c)
                case pywasm.opcode.i32_shr_s:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_i32()
                    c = ValInst.from_i32(a >> (b % 0x20))
                    self.stack.value.append(c)
                case pywasm.opcode.i32_shr_u:
                    b = self.stack.value.pop().into_u32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(a >> (b % 0x20))
                    self.stack.value.append(c)
                case pywasm.opcode.i32_rotl:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32((((a << (b % 0x20)) & 0xffffffff) | (a >> (0x20 - (b % 0x20)))))
                    self.stack.value.append(c)
                case pywasm.opcode.i32_rotr:
                    b = self.stack.value.pop().into_i32()
                    a = self.stack.value.pop().into_u32()
                    c = ValInst.from_i32(((a >> (b % 0x20)) | ((a << (0x20 - (b % 0x20))) & 0xffffffff)))
                    self.stack.value.append(c)
                case pywasm.opcode.i64_clz:
                    a = self.stack.value.pop().into_u64()
                    b = 0
                    for _ in range(64):
                        if a & 0x8000000000000000 != 0:
                            break
                        b += 1
                        a = a << 1
                    c = ValInst.from_i64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_ctz:
                    a = self.stack.value.pop().into_u64()
                    b = 0
                    for _ in range(64):
                        if a & 0x0000000000000001 != 0:
                            break
                        b += 1
                        a = a >> 1
                    c = ValInst.from_i64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_popcnt:
                    a = self.stack.value.pop().into_u64()
                    b = 0
                    for _ in range(64):
                        if a & 0x0000000000000001 != 0:
                            b += 1
                        a = a >> 1
                    c = ValInst.from_i64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_add:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a + b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_sub:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a - b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_mul:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a * b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_div_s:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = a // b if a * b > 0 else (a + (-a % b)) // b
                    d = ValInst.from_i64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i64_div_u:
                    b = self.stack.value.pop().into_u64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i64(a // b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_rem_s:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = a % b if a * b > 0 else -(-a % b)
                    d = ValInst.from_i64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i64_rem_u:
                    b = self.stack.value.pop().into_u64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i64(a % b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_and:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a & b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_or:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a | b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_xor:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a ^ b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_shl:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a << (b % 0x40))
                    self.stack.value.append(c)
                case pywasm.opcode.i64_shr_s:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_i64()
                    c = ValInst.from_i64(a >> (b % 0x40))
                    self.stack.value.append(c)
                case pywasm.opcode.i64_shr_u:
                    b = self.stack.value.pop().into_u64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i64(a >> (b % 0x40))
                    self.stack.value.append(c)
                case pywasm.opcode.i64_rotl:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i64((((a << (b % 0x40)) & 0xffffffffffffffff) | (a >> (0x40 - (b % 0x40)))))
                    self.stack.value.append(c)
                case pywasm.opcode.i64_rotr:
                    b = self.stack.value.pop().into_i64()
                    a = self.stack.value.pop().into_u64()
                    c = ValInst.from_i64(((a >> (b % 0x40)) | ((a << (0x40 - (b % 0x40))) & 0xffffffffffffffff)))
                    self.stack.value.append(c)
                case pywasm.opcode.f32_abs:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.f32(), a.data.copy())
                    b.data[3] = b.data[3] & 0x7f
                    self.stack.value.append(b)
                case pywasm.opcode.f32_neg:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.f32(), a.data.copy())
                    b.data[3] = b.data[3] ^ 0x80
                    self.stack.value.append(b)
                case pywasm.opcode.f32_ceil:
                    a = self.stack.value.pop().into_f32()
                    b = a if math.isnan(a) or math.isinf(a) else float(math.ceil(a))
                    c = ValInst.from_f32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_floor:
                    a = self.stack.value.pop().into_f32()
                    b = a if math.isnan(a) or math.isinf(a) else float(math.floor(a))
                    c = ValInst.from_f32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_trunc:
                    a = self.stack.value.pop().into_f32()
                    b = a if math.isnan(a) or math.isinf(a) else float(math.trunc(a))
                    c = ValInst.from_f32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_nearest:
                    a = self.stack.value.pop().into_f32()
                    b = a if math.isnan(a) or math.isinf(a) else float(round(a))
                    c = ValInst.from_f32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_sqrt:
                    a = self.stack.value.pop().into_f32()
                    b = math.sqrt(a) if a >= 0 else math.nan
                    c = ValInst.from_f32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_add:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_f32(a + b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_sub:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_f32(a - b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_mul:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_f32(a * b)
                    self.stack.value.append(c)
                case pywasm.opcode.f32_div:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    match b:
                        case 0:
                            s = +1 if math.copysign(1, a) == math.copysign(1, b) else -1
                            c = math.copysign(math.inf, s)
                            if a == 0 or math.isnan(a):
                                c = math.copysign(math.nan, s)
                        case _:
                            c = a / b
                    d = ValInst.from_f32(c)
                    self.stack.value.append(d)
                case pywasm.opcode.f32_min:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = min(a, b)
                    if math.isnan(a):
                        c = a
                    if math.isnan(b):
                        c = b
                    d = ValInst.from_f32(c)
                    self.stack.value.append(d)
                case pywasm.opcode.f32_max:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = max(a, b)
                    if math.isnan(a):
                        c = a
                    if math.isnan(b):
                        c = b
                    d = ValInst.from_f32(c)
                    self.stack.value.append(d)
                case pywasm.opcode.f32_copysign:
                    b = self.stack.value.pop().into_f32()
                    a = self.stack.value.pop().into_f32()
                    c = ValInst.from_f32(math.copysign(a, b))
                    self.stack.value.append(c)
                case pywasm.opcode.f64_abs:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.f64(), a.data.copy())
                    b.data[7] = b.data[7] & 0x7f
                    self.stack.value.append(b)
                case pywasm.opcode.f64_neg:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.f64(), a.data.copy())
                    b.data[7] = b.data[7] ^ 0x80
                    self.stack.value.append(b)
                case pywasm.opcode.f64_ceil:
                    a = self.stack.value.pop().into_f64()
                    b = a if math.isnan(a) or math.isinf(a) else float(math.ceil(a))
                    c = ValInst.from_f64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_floor:
                    a = self.stack.value.pop().into_f64()
                    b = a if math.isnan(a) or math.isinf(a) else float(math.floor(a))
                    c = ValInst.from_f64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_trunc:
                    a = self.stack.value.pop().into_f64()
                    b = a if math.isnan(a) or math.isinf(a) else float(math.trunc(a))
                    c = ValInst.from_f64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_nearest:
                    a = self.stack.value.pop().into_f64()
                    b = a if math.isnan(a) or math.isinf(a) else float(round(a))
                    c = ValInst.from_f64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_sqrt:
                    a = self.stack.value.pop().into_f64()
                    b = math.sqrt(a) if a >= 0 else math.nan
                    c = ValInst.from_f64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_add:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_f64(a + b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_sub:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_f64(a - b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_mul:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_f64(a * b)
                    self.stack.value.append(c)
                case pywasm.opcode.f64_div:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    match b:
                        case 0:
                            s = +1 if math.copysign(1, a) == math.copysign(1, b) else -1
                            c = math.copysign(math.inf, s)
                            if a == 0 or math.isnan(a):
                                c = math.copysign(math.nan, s)
                        case _:
                            c = a / b
                    d = ValInst.from_f64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.f64_min:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = min(a, b)
                    if math.isnan(a):
                        c = a
                    if math.isnan(b):
                        c = b
                    d = ValInst.from_f64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.f64_max:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = max(a, b)
                    if math.isnan(a):
                        c = a
                    if math.isnan(b):
                        c = b
                    d = ValInst.from_f64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.f64_copysign:
                    b = self.stack.value.pop().into_f64()
                    a = self.stack.value.pop().into_f64()
                    c = ValInst.from_f64(math.copysign(a, b))
                    self.stack.value.append(c)
                case pywasm.opcode.i32_wrap_i64:
                    a = self.stack.value.pop().into_i64()
                    b = ValInst.from_i32(a)
                    self.stack.value.append(b)
                case pywasm.opcode.i32_trunc_f32_s:
                    a = self.stack.value.pop().into_f32()
                    b = ValInst.from_i32(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.i32_trunc_f32_u:
                    a = self.stack.value.pop().into_f32()
                    b = ValInst.from_u32(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.i32_trunc_f64_s:
                    a = self.stack.value.pop().into_f64()
                    b = ValInst.from_i32(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.i32_trunc_f64_u:
                    a = self.stack.value.pop().into_f64()
                    b = ValInst.from_u32(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.i64_extend_i32_s:
                    a = self.stack.value.pop().into_i32()
                    b = ValInst.from_i64(a)
                    self.stack.value.append(b)
                case pywasm.opcode.i64_extend_i32_u:
                    a = self.stack.value.pop().into_u32()
                    b = ValInst.from_i64(a)
                    self.stack.value.append(b)
                case pywasm.opcode.i64_trunc_f32_s:
                    a = self.stack.value.pop().into_f32()
                    b = ValInst.from_i64(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.i64_trunc_f32_u:
                    a = self.stack.value.pop().into_f32()
                    b = ValInst.from_u64(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.i64_trunc_f64_s:
                    a = self.stack.value.pop().into_f64()
                    b = ValInst.from_i64(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.i64_trunc_f64_u:
                    a = self.stack.value.pop().into_f64()
                    b = ValInst.from_u64(int(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f32_convert_i32_s:
                    a = self.stack.value.pop().into_i32()
                    b = ValInst.from_f32(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f32_convert_i32_u:
                    a = self.stack.value.pop().into_u32()
                    b = ValInst.from_f32(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f32_convert_i64_s:
                    a = self.stack.value.pop().into_i64()
                    b = ValInst.from_f32(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f32_convert_i64_u:
                    a = self.stack.value.pop().into_u64()
                    b = ValInst.from_f32(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f32_demote_f64:
                    a = self.stack.value.pop().into_f64()
                    b = ValInst.from_f32(a)
                    self.stack.value.append(b)
                case pywasm.opcode.f64_convert_i32_s:
                    a = self.stack.value.pop().into_i32()
                    b = ValInst.from_f64(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f64_convert_i32_u:
                    a = self.stack.value.pop().into_u32()
                    b = ValInst.from_f64(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f64_convert_i64_s:
                    a = self.stack.value.pop().into_i64()
                    b = ValInst.from_f64(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f64_convert_i64_u:
                    a = self.stack.value.pop().into_u64()
                    b = ValInst.from_f64(float(a))
                    self.stack.value.append(b)
                case pywasm.opcode.f64_promote_f32:
                    a = self.stack.value.pop().into_f32()
                    b = ValInst.from_f64(a)
                    self.stack.value.append(b)
                case pywasm.opcode.i32_reinterpret_f32:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.i32(), a.data.copy())
                    self.stack.value.append(b)
                case pywasm.opcode.i64_reinterpret_f64:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.i64(), a.data.copy())
                    self.stack.value.append(b)
                case pywasm.opcode.f32_reinterpret_i32:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.f32(), a.data.copy())
                    self.stack.value.append(b)
                case pywasm.opcode.f64_reinterpret_i64:
                    a = self.stack.value.pop()
                    b = ValInst(ValType.f64(), a.data.copy())
                    self.stack.value.append(b)
                case pywasm.opcode.i32_extend8_s:
                    a = self.stack.value.pop().into_i32()
                    b = a & 0xff
                    c = b - ((b & 0x80) << 1)
                    d = ValInst.from_i32(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i32_extend16_s:
                    a = self.stack.value.pop().into_i32()
                    b = a & 0xffff
                    c = b - ((b & 0x8000) << 1)
                    d = ValInst.from_i32(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i64_extend8_s:
                    a = self.stack.value.pop().into_i64()
                    b = a & 0xff
                    c = b - ((b & 0x80) << 1)
                    d = ValInst.from_i64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i64_extend16_s:
                    a = self.stack.value.pop().into_i64()
                    b = a & 0xffff
                    c = b - ((b & 0x8000) << 1)
                    d = ValInst.from_i64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.i64_extend32_s:
                    a = self.stack.value.pop().into_i64()
                    b = a & 0xffffffff
                    c = b - ((b & 0x80000000) << 1)
                    d = ValInst.from_i64(c)
                    self.stack.value.append(d)
                case pywasm.opcode.ref_null:
                    a = ValInst(ValType(instr.args[0]), bytearray(8))
                    self.stack.value.append(a)
                case pywasm.opcode.ref_is_null:
                    a = self.stack.value.pop()
                    assert a.type in [ValType.ref_func(), ValType.ref_extern()]
                    b = 0x01 if a.data[4] == 0x00 else 0x00
                    c = ValInst.from_i32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.ref_func:
                    a = frame.module.func[instr.args[0]]
                    b = ValInst.from_ref(ValType.ref_func(), a)
                    self.stack.value.append(b)
                case pywasm.opcode.i32_trunc_sat_f32_s:
                    a = self.stack.value.pop().into_f32()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(-0x80000000, min(a, +0x7fffffff)))
                    c = ValInst.from_i32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_trunc_sat_f32_u:
                    a = self.stack.value.pop().into_f32()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(+0x00000000, min(a, +0xffffffff)))
                    c = ValInst.from_u32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_trunc_sat_f64_s:
                    a = self.stack.value.pop().into_f64()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(-0x80000000, min(a, +0x7fffffff)))
                    c = ValInst.from_i32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i32_trunc_sat_f64_u:
                    a = self.stack.value.pop().into_f64()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(+0x00000000, min(a, +0xffffffff)))
                    c = ValInst.from_u32(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_trunc_sat_f32_s:
                    a = self.stack.value.pop().into_f32()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(-0x8000000000000000, min(a, +0x7fffffffffffffff)))
                    c = ValInst.from_i64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_trunc_sat_f32_u:
                    a = self.stack.value.pop().into_f32()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(+0x0000000000000000, min(a, +0xffffffffffffffff)))
                    c = ValInst.from_u64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_trunc_sat_f64_s:
                    a = self.stack.value.pop().into_f64()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(-0x8000000000000000, min(a, +0x7fffffffffffffff)))
                    c = ValInst.from_i64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.i64_trunc_sat_f64_u:
                    a = self.stack.value.pop().into_f64()
                    if math.isnan(a):
                        a = 0.0
                    b = int(max(+0x0000000000000000, min(a, +0xffffffffffffffff)))
                    c = ValInst.from_u64(b)
                    self.stack.value.append(c)
                case pywasm.opcode.memory_init:
                    assert 0
                case pywasm.opcode.data_drop:
                    assert 0
                case pywasm.opcode.memory_copy:
                    assert 0
                case pywasm.opcode.memory_fill:
                    assert 0
                case pywasm.opcode.table_init:
                    assert 0
                case pywasm.opcode.elem_drop:
                    assert 0
                case pywasm.opcode.table_copy:
                    assert 0
                case pywasm.opcode.table_grow:
                    assert 0
                case pywasm.opcode.table_size:
                    assert 0
                case pywasm.opcode.table_fill:
                    assert 0
                case _:
                    assert 0


class Runtime:
    # A webassembly runtime manages Store, stack, and other runtime structure. They forming the WebAssembly abstract.

    def __init__(self) -> typing.Self:
        self.machine = Machine()

    def exported_mem(self, module: ModuleInst, name: str) -> MemInst:
        addr = [e for e in module.exps if e.name == name][0].data.data
        return self.machine.store.mems[addr]

    def exported_global(self, module: ModuleInst, name: str) -> GlobalInst:
        addr = [e for e in module.exps if e.name == name][0].data.data
        return self.machine.store.glob[addr]

    def instance(self, module: ModuleDesc, imps: typing.Dict[str, typing.Any]) -> ModuleInst:
        extern: typing.List[Extern] = []
        for e in module.imps:
            assert e.module in imps
            assert e.name in imps[e.module]
            match e.kind:
                case 0x00:
                    match imps[e.module][e.name]:
                        case x if callable(x):
                            func = FuncHost(module.type[e.desc], imps[e.module][e.name])
                            addr = self.machine.store.allocate_func_host(func)
                            extern.append(Extern(0x00, addr))
                        case _:
                            addr = len(self.machine.store.func)
                            func = imps[e.module][e.name]
                            self.machine.store.func.append(func)
                            extern.append(Extern(0x00, addr))
                case 0x01:
                    addr = len(self.machine.store.tabl)
                    tabl = imps[e.module][e.name]
                    self.machine.store.tabl.append(tabl)
                    extern.append(Extern(0x01, addr))
                case 0x02:
                    addr = len(self.machine.store.mems)
                    mems = imps[e.module][e.name]
                    self.machine.store.mems.append(mems)
                    extern.append(Extern(0x02, addr))
                case 0x03:
                    match imps[e.module][e.name]:
                        case x if isinstance(x, (int, float)):
                            glob = ValInst.from_num(e.desc.type, imps[e.module][e.name])
                            addr = self.machine.store.allocate_global(e.desc, glob)
                            extern.append(Extern(0x03, addr))
                        case _:
                            addr = len(self.machine.store.glob)
                            glob = imps[e.module][e.name]
                            self.machine.store.glob.append(glob)
                            extern.append(Extern(0x03, addr))
        return self.machine.instance(module, extern)

    def instance_from_file(self, path: str, imps: typing.Dict[str, typing.Any]) -> ModuleInst:
        with open(path, 'rb') as f:
            return self.instance(ModuleDesc.from_reader(f), imps)

    def invocate(self, module: ModuleInst, func: str, args: typing.List[int | float]) -> typing.List[int | float]:
        addr = [e for e in module.exps if e.name == func][0].data.data
        func = self.machine.store.func[addr]
        args = [ValInst.from_num(a, b) for a, b in zip(func.type.args, args)]
        rets = self.machine.invocate(addr, args)
        return [e.into_num() for e in rets]
