import io
import math
import struct
import typing

from . import leb128
from . import log
from . import opcode


class Bype:
    # Block types are encoded in special compressed form, by either the byte 0x40 indicating the empty type, as a
    # single value type, or as a type index encoded as a positive signed integer.

    def __init__(self, type: int, data: int) -> typing.Self:
        assert type in [0x00, 0x01, 0x02]
        self.type = type
        self.data = data

    def __eq__(self, value: typing.Self) -> bool:
        return self.type == value.type and self.data == value.data

    def __repr__(self) -> str:
        if self.type == 0x00:
            return 'empty'
        if self.type == 0x01:
            return repr(ValType(self.data))
        return repr(self.data)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = ord(r.read(1))
        if n == 0x40:
            return cls(0x00, 0x40)
        if n in [0x7f, 0x7e, 0x7d, 0x7c]:
            return cls(0x01, n)
        r.seek(1, -1)
        return cls(0x02, leb128.i.decode_reader(r)[0])


class Inst:
    # Instructions are encoded by opcodes. Each opcode is represented by a single byte, and is followed by the
    # instruction's immediate arguments, where present. The only exception are structured control instructions, which
    # consist of several opcodes bracketing their nested instruction sequences.

    def __init__(self, opcode: int, args: typing.List[typing.Any]) -> typing.Self:
        self.opcode = opcode
        self.args = args

    def __repr__(self) -> str:
        args = ' '.join([repr(e) for e in self.args])
        return f'{opcode.name[self.opcode]} {args}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        o = Inst(ord(r.read(1)), [])
        assert o.opcode in opcode.name
        if o.opcode in [
            opcode.block,
            opcode.loop,
            opcode.if_then,
        ]:
            o.args.append(Bype.from_reader(r))
            return o
        if o.opcode in [
            opcode.br,
            opcode.br_if,
        ]:
            o.args.append(leb128.u.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.br_table,
        ]:
            o.args.append([leb128.u.decode_reader(r)[0] for _ in range(leb128.u.decode_reader(r)[0])])
            o.args.append(leb128.u.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.call,
        ]:
            o.args.append(leb128.u.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.call_indirect,
        ]:
            o.args.append(leb128.u.decode_reader(r)[0])
            o.args.append(ord(r.read(1)))
            return o
        if o.opcode in [
            opcode.local_get,
            opcode.local_set,
            opcode.local_tee,
        ]:
            o.args.append(leb128.u.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.global_get,
            opcode.global_set,
        ]:
            o.args.append(leb128.u.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.i32_load,
            opcode.i64_load,
            opcode.f32_load,
            opcode.f64_load,
            opcode.i32_load8_s,
            opcode.i32_load8_u,
            opcode.i32_load16_s,
            opcode.i32_load16_u,
            opcode.i64_load8_s,
            opcode.i64_load8_u,
            opcode.i64_load16_s,
            opcode.i64_load16_u,
            opcode.i64_load32_s,
            opcode.i64_load32_u,
            opcode.i32_store,
            opcode.i64_store,
            opcode.f32_store,
            opcode.f64_store,
            opcode.i32_store8,
            opcode.i32_store16,
            opcode.i64_store8,
            opcode.i64_store16,
            opcode.i64_store32,
        ]:
            o.args.append(leb128.u.decode_reader(r)[0])
            o.args.append(leb128.u.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.memory_size,
            opcode.memory_grow
        ]:
            o.args.append(ord(r.read(1)))
            return o
        if o.opcode in [
            opcode.i32_const,
        ]:
            o.args.append(leb128.i.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.i64_const,
        ]:
            o.args.append(leb128.i.decode_reader(r)[0])
            return o
        if o.opcode in [
            opcode.f32_const,
        ]:
            # Python misinterpret 0x7fa00000 as 0x7fe00000, when encapsulate as built-in float type.
            # See: https://stackoverflow.com/questions/47961537/webassembly-f32-const-nan0x200000-means-0x7fa00000-or-0x7fe00000
            o.args.append(struct.unpack('<i', r.read(4))[0])
            return o
        if o.opcode in [
            opcode.f64_const,
        ]:
            o.args.append(struct.unpack('<q', r.read(8))[0])
            return o
        return o


class Expr:
    # Function bodies, initialization values for globals, and offsets of element or data segments are given as
    # expressions, which are sequences of instructions terminated by an end marker.

    def __init__(self, data: typing.List[Inst]) -> typing.Self:
        self.data = data
        self.jump = self.mark(self.data)

    @classmethod
    def mark(cls, data: typing.List[Inst]) -> typing.Dict[int, typing.List[int]]:
        jump = {}
        vect = []
        for i, e in enumerate(data):
            if e.opcode in [opcode.block, opcode.loop, opcode.if_then]:
                vect.append([i])
                continue
            if e.opcode in [opcode.else_fi]:
                vect[-1].append(i)
                continue
            if e.opcode in [opcode.end]:
                if vect:
                    b = vect.pop()
                    b.insert(1, i)
                    for e in b:
                        jump[e] = b
                continue
        return jump

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        s = []
        d = 1
        for _ in range(1 << 32):
            i = Inst.from_reader(r)
            s.append(i)
            if i.opcode in [opcode.block, opcode.loop, opcode.if_then]:
                d += 1
            if i.opcode in [opcode.end]:
                d -= 1
                if d == 0:
                    break
        return cls(s)


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
        return cls(leb128.u.decode_reader(r)[0],  leb128.u.decode_reader(r)[0] if flag else 0x00)


class Custom:
    # Custom sections have the id 0. They are intended to be used for debugging information or third-party extensions,
    # and are ignored by the WebAssembly semantics. Their contents consist of a name further identifying the custom
    # section, followed by an uninterpreted sequence of bytes for custom use.

    def __init__(self, name: str, data: bytearray) -> typing.Self:
        self.name = name
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls(r.read(n).decode(), bytearray(r.read(-1)))


class Import:
    # The imports component of a module defines a set of imports that are required for instantiation.
    #
    # Each import is labeled by a two-level name space, consisting of a module name and a name for an entity within
    # that module. Importable definitions are functions, tables, memories, and globals. Each import is specified by a
    # descriptor with a respective type that a definition provided during instantiation is required to match. Every
    # import defines an index in the respective index space. In each index space, the indices of imports go before the
    # first index of any definition contained in the module itself.

    def __init__(self, module: str, name: str, type: int, desc: typing.Any) -> typing.Self:
        self.module = module
        self.name = name
        self.type = type
        self.desc = desc

    def __repr__(self) -> str:
        type_name = {
            0x00: 'func',
            0x01: 'table',
            0x02: 'mem',
            0x03: 'global'
        }[self.type]
        return f'{self.module}.{self.name} {type_name} {self.desc}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        module = r.read(n).decode()
        n = leb128.u.decode_reader(r)[0]
        name = r.read(n).decode()
        type = ord(r.read(1))
        desc = {
            0x00: lambda r: leb128.u.decode_reader(r)[0],
            0x01: TableType.from_reader,
            0x02: MemType.from_reader,
            0x03: GlobalType.from_reader,
        }[type](r)
        return cls(module, name, type, desc)


class Data:
    # The initial contents of a memory are zero-valued bytes. The data component of a module defines a vector of data
    # segments that initialize a range of memory, at a given offset, with a static vector of bytes.
    # The offset is given by a constant expression.

    def __init__(self, data: int, offset: Expr, init: bytearray) -> typing.Self:
        self.data = data
        self.offset = offset
        self.init = init

    def __repr__(self) -> str:
        return f'{self.data}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        data = leb128.u.decode_reader(r)[0]
        offset = Expr.from_reader(r)
        init = bytearray(r.read(leb128.u.decode_reader(r)[0]))
        return cls(data, offset, init)


class Extern:
    # An external value is the runtime representation of an entity that can be imported or exported. It is an address
    # denoting either a function instance, table instance, memory instance, or global instances in the shared store.

    def __init__(self, type: int, data: int) -> typing.Self:
        assert type in [0x00, 0x01, 0x02, 0x03]
        self.type = type
        self.data = data

    def __repr__(self) -> str:
        prefix = {
            0x00: 'func',
            0x01: 'table',
            0x02: 'mem',
            0x03: 'global',
        }[self.data]
        return f'{prefix} {self.data}'


class ValType:
    # Value types are encoded by a single byte.

    def __init__(self, data: int) -> typing.Self:
        assert data in [0x7f, 0x7e, 0x7d, 0x7c]
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
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ord(r.read(1)))


class ValInst:
    # Values are represented by themselves.

    def __init__(self, type: ValType, data: bytearray) -> typing.Self:
        assert len(data) == 8
        self.type = type
        self.data = data

    def __repr__(self) -> str:
        return f'{self.type} {self.into_auto()}'

    @classmethod
    def from_auto(cls, type: ValType, data: typing.Union[int, float]) -> typing.Self:
        return {
            ValType.i32(): cls.from_i32,
            ValType.i64(): cls.from_i64,
            ValType.f32(): cls.from_f32,
            ValType.f64(): cls.from_f64,
        }[type](data)

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
        if math.fabs(n) > 3.40282346638528859811704183484516925440e+38:
            n = math.copysign(math.inf, n)
        return cls(ValType.f32(), bytearray(struct.pack('<f', n)) + bytearray(4))

    @classmethod
    def from_f32_u32(cls, n: int) -> typing.Self:
        o = cls.from_u32(n)
        o.type = ValType.f32()
        return o

    @classmethod
    def from_f64(cls, n: float) -> typing.Self:
        assert isinstance(n, float)
        if math.fabs(n) > 1.797693134862315708145274237317043567981e+308:
            n = math.copysign(math.inf, n)
        return cls(ValType.f64(), bytearray(struct.pack('<d', n)))

    @classmethod
    def from_f64_u64(cls, n: int) -> typing.Self:
        o = cls.from_u64(n)
        o.type = ValType.f64()
        return o

    def into_auto(self) -> typing.Union[int, float]:
        return {
            ValType.i32(): self.into_i32,
            ValType.i64(): self.into_i64,
            ValType.f32(): self.into_f32,
            ValType.f64(): self.into_f64,
        }[self.type]()

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


class ResultType:
    # Result types are encoded by the respective vectors of value types. Result types classify the result of executing
    # instructions or blocks, which is a sequence of values written with brackets.

    def __init__(self, data: typing.List[ValType]) -> typing.Self:
        self.data = data

    def __repr__(self) -> str:
        return repr(self.data)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([ValType.from_reader(r) for _ in range(n)])


class ResultInst:
    # A result is the outcome of a computation. It is either a sequence of values or a trap.

    def __init__(self, data: typing.List[ValInst]) -> typing.Self:
        self.data = data

    def __repr__(self) -> str:
        return repr(self.data)


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
        return cls(leb128.u.decode_reader(r)[0], ValType.from_reader(r))


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

    def __init__(self, args: ResultType, rets: ResultType) -> typing.Self:
        self.args = args
        self.rets = rets

    def __repr__(self) -> str:
        return f'{self.args} -> {self.rets}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        assert ord(r.read(1)) == 0x60
        return cls(ResultType.from_reader(r), ResultType.from_reader(r))


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
        return cls(leb128.u.decode_reader(r)[0], [], Expr([]))

    @classmethod
    def from_reader_code(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(0, [LocalsDesc.from_reader(r) for _ in range(leb128.u.decode_reader(r)[0])], Expr.from_reader(r))


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


class ElemType:
    # The element type funcref is the infinite union of all function types. A table of that type thus contains
    # references to functions of heterogeneous type.
    # In future versions of WebAssembly, additional element types may be introduced.

    def __init__(self, data: int) -> typing.Self:
        assert data == 0x70
        self.data = data

    def __eq__(self, value: typing.Self) -> bool:
        return self.data == value.data

    def __repr__(self) -> str:
        return {
            0x70: 'funcref',
        }[self.data]

    @classmethod
    def funcref(cls) -> typing.Self:
        return cls(0x70)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ord(r.read(1)))


class ElemDesc:
    # The initial contents of a table is uninitialized. The elem component of a module defines a vector of element
    # segments that initialize a subrange of a table, at a given offset, from a static vector of elements.
    # The offset is given by a constant expression.

    def __init__(self, data: int, offset: Expr, init: typing.List[int]) -> typing.Self:
        self.data = data
        self.offset = offset
        self.init = init

    def __repr__(self) -> str:
        return f'{self.data}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        data = leb128.u.decode_reader(r)[0]
        offset = Expr.from_reader(r)
        init = [leb128.u.decode_reader(r)[0] for _ in range(leb128.u.decode_reader(r)[0])]
        return cls(data, offset, init)


class TableType:
    # Table types classify tables over elements of element types within a size range. Like memories, tables are
    # constrained by limits for their minimum and optionally maximum size. The limits are given in numbers of entries.
    # The element type funcref is the infinite union of all function types. A table of that type thus contains
    # references to functions of heterogeneous type.

    def __init__(self, type: ElemType, limits: Limits) -> typing.Self:
        self.type = type
        self.limits = limits

    def __repr__(self) -> str:
        return f'{self.type} {self.limits}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ElemType.from_reader(r), Limits.from_reader(r))


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


class ExportDesc:
    # The exports component of a module defines a set of exports that become accessible to the host environment once
    # the module has been instantiated.
    #
    # Each export is labeled by a unique name. Exportable definitions are functions, tables, memories, and globals,
    # which are referenced through a respective descriptor.

    def __init__(self, name: str, type: int, desc: int) -> typing.Self:
        assert type in [0x00, 0x01, 0x02, 0x03]
        self.name = name
        self.type = type
        self.desc = desc

    def __repr__(self) -> str:
        type_name = {
            0x00: 'func',
            0x01: 'table',
            0x02: 'mem',
            0x03: 'global'
        }[self.type]
        return f'{self.name} {type_name} {self.desc}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        name = bytearray(r.read(leb128.u.decode_reader(r)[0])).decode()
        type = ord(r.read(1))
        desc = leb128.u.decode_reader(r)[0]
        return cls(name, type, desc)


class ExportInst:
    # An export instance is the runtime representation of an export. It defines the export's name and the associated
    # external value.

    def __init__(self, name: str, data: Extern) -> typing.Self:
        self.name = name
        self.data = data

    def __repr__(self):
        return f'{self.name} {self.data}'


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
        data: typing.List[Data],
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
        data: typing.List[Data] = []
        star: int = -1
        imps: typing.List[Import] = []
        exps: typing.List[ExportDesc] = []

        for _ in range(32):
            section_id_byte = r.read(1)
            if not section_id_byte:
                break
            section_id = ord(section_id_byte)
            n = leb128.u.decode_reader(r)[0]
            section_data = bytearray(r.read(n))
            assert len(section_data) == n
            section_reader = io.BytesIO(section_data)

            match section_id:
                case 0x00:
                    desc = Custom.from_reader(section_reader)
                    log.debugln('section custom', desc.name)
                case 0x01:
                    log.debugln('section type')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = FuncType.from_reader(section_reader)
                        type.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x02:
                    log.debugln('section import')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = Import.from_reader(section_reader)
                        imps.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x03:
                    log.debugln('section func')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = FuncDesc.from_reader_type(section_reader)
                        func.append(desc)
                        log.debugln(f'    {i:>3d} {desc.type}')
                case 0x04:
                    log.debugln('section table')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = TableType.from_reader(section_reader)
                        tabl.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x05:
                    log.debugln('section mem')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = MemType.from_reader(section_reader)
                        mems.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x06:
                    log.debugln('section global')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = GlobalDesc.from_reader(section_reader)
                        glob.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x07:
                    log.debugln('section export')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = ExportDesc.from_reader(section_reader)
                        exps.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x08:
                    desc = leb128.u.decode_reader(section_reader)[0]
                    star = desc
                    log.debugln('section start', desc)
                case 0x09:
                    log.debugln('section elem')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = ElemDesc.from_reader(section_reader)
                        elem.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x0a:
                    log.debugln('section code')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        size = leb128.u.decode_reader(section_reader)[0]
                        desc = FuncDesc.from_reader_code(io.BytesIO(section_reader.read(size)))
                        func[i].locals = desc.locals
                        func[i].expr = desc.expr
                        log.debugln(f'    {i:>3d} {desc}')
                case 0x0b:
                    log.debugln('section data')
                    for i in range(leb128.u.decode_reader(section_reader)[0]):
                        desc = Data.from_reader(section_reader)
                        data.append(desc)
                        log.debugln(f'    {i:>3d} {desc}')

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
        self.exps: typing.List[ExportInst] = []
