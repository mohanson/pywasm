import io
import math
import struct
import typing

from . import leb128
from . import log
from . import opcode


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


class Val:
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
    # Result types classify the result of executing instructions or blocks, which is a sequence of values written with
    # brackets.

    def __init__(self, data: typing.List[ValType]) -> typing.Self:
        self.data = data

    def __repr__(self) -> str:
        return repr(self.data)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([ValType.from_reader(r) for _ in range(n)])


class FuncType:
    # Function types are encoded by the byte 0x60 followed by the respective vectors of parameter and result types.

    def __init__(self, args: ResultType, rets: ResultType) -> typing.Self:
        self.args = args
        self.rets = rets

    def __repr__(self) -> str:
        return f'{self.args} -> {self.rets}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        assert ord(r.read(1)) == 0x60
        return cls(ResultType.from_reader(r), ResultType.from_reader(r))


class Limits:
    # Limits are encoded with a preceding flag indicating whether a maximum is present.

    def __init__(self, n: int, m: int) -> typing.Self:
        self.n = n
        self.m = m

    def __repr__(self) -> str:
        return f'{self.n} {self.m}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        flag = ord(r.read(1))
        return cls(leb128.u.decode_reader(r)[0],  leb128.u.decode_reader(r)[0] if flag else 0x00)


class MemType:
    # Memory types classify linear memories and their size range.

    def __init__(self, limits: Limits) -> typing.Self:
        self.limits = limits

    def __repr__(self) -> str:
        return repr(self.limits)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(Limits.from_reader(r))


class Mem:
    # described by their memory type

    def __init__(self, type: MemType) -> typing.Self:
        self.type = type

    def __repr__(self) -> str:
        return repr(self.type)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(MemType.from_reader(r))


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


class TableType:
    # Table types classify tables over elements of element types within a size range.
    #
    # Like memories, tables are constrained by limits for their minimum and optionally maximum size. The limits are
    # given in numbers of entries. The element type funcref is the infinite union of all function types. A table of that
    # type thus contains references to functions of heterogeneous type.

    def __init__(self, type: ElemType, limits: Limits) -> typing.Self:
        self.type = type
        self.limits = limits

    def __repr__(self) -> str:
        return f'{self.type} {self.limits}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ElemType.from_reader(r), Limits.from_reader(r))


class Mut:
    # Mut hold a value and can either be mutable or immutable.

    def __init__(self, data: int) -> typing.Self:
        assert data in [0x00, 0x01]
        self.data = data

    def __eq__(self, value: typing.Self) -> bool:
        return self.data == value.data

    def __repr__(self) -> str:
        return {
            0x00: 'const',
            0x01: 'var',
        }[self.data]

    @classmethod
    def const(cls) -> typing.Self:
        return cls(0x00)

    @classmethod
    def var(cls) -> typing.Self:
        return cls(0x01)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ord(r.read(1)))


class GlobalType:
    # Global types are encoded by their value type and a flag for their mutability.

    def __init__(self, type: ValType, mut: Mut) -> typing.Self:
        self.type = type
        self.mut = mut

    def __repr__(self) -> str:
        return f'{self.mut} {self.type}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ValType.from_reader(r), Mut.from_reader(r))


class BlockType:
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
    def empty(cls) -> typing.Self:
        return cls(0x00, 0x40)

    @classmethod
    def val_type(cls, type: ValType) -> typing.Self:
        return cls(0x01, type.data)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = ord(r.read(1))
        if n == 0x40:
            return cls(0x00, 0x40)
        if n in [0x7f, 0x7e, 0x7d, 0x7c]:
            return cls(0x01, n)
        r.seek(1, -1)
        return cls(0x02, leb128.i.decode_reader(r)[0])


class Instruction:
    # Instructions are encoded by opcodes. Each opcode is represented by a single byte, and is followed by the
    # instruction's immediate arguments, where present. The only exception are structured control instructions, which
    # consist of several opcodes bracketing their nested instruction sequences.

    def __init__(self):
        self.opcode: int = 0x00
        self.args: typing.List[typing.Any] = []

    def __repr__(self):
        return f'{opcode.name[self.opcode]} {self.args}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Instruction()
        o.opcode = ord(r.read(1))
        o.args = []
        if o.opcode in [
            opcode.block,
            opcode.loop,
            opcode.if_then,
        ]:
            block_type = BlockType.from_reader(r)
            o.args = [block_type]
            return o
        if o.opcode in [
            opcode.br,
            opcode.br_if,
        ]:
            o.args = [leb128.u.decode_reader(r)[0]]
            return o
        if o.opcode == opcode.br_table:
            n = leb128.u.decode_reader(r)[0]
            a = [leb128.u.decode_reader(r)[0] for _ in range(n)]
            b = leb128.u.decode_reader(r)[0]
            o.args = [a, b]
            return o
        if o.opcode == opcode.call:
            o.args = [leb128.u.decode_reader(r)[0]]
            return o
        if o.opcode == opcode.call_indirect:
            i = leb128.u.decode_reader(r)[0]
            n = ord(r.read(1))
            o.args = [i, n]
            return o
        if o.opcode in [
            opcode.local_get,
            opcode.local_set,
            opcode.local_tee,
        ]:
            o.args = [leb128.u.decode_reader(r)[0]]
            return o
        if o.opcode in [
            opcode.global_get,
            opcode.global_set,
        ]:
            o.args = [leb128.u.decode_reader(r)[0]]
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
            o.args = [leb128.u.decode_reader(r)[0], leb128.u.decode_reader(r)[0]]
            return o
        if o.opcode in [
            opcode.memory_size,
            opcode.memory_grow
        ]:
            n = ord(r.read(1))
            o.args = [n]
            return o
        if o.opcode == opcode.i32_const:
            o.args = [Val.from_i32(leb128.i.decode_reader(r)[0])]
            return o
        if o.opcode == opcode.i64_const:
            o.args = [Val.from_i64(leb128.i.decode_reader(r)[0])]
            return o
        if o.opcode == opcode.f32_const:
            # https://stackoverflow.com/questions/47961537/webassembly-f32-const-nan0x200000-means-0x7fa00000-or-0x7fe00000
            # python misinterpret 0x7fa00000 as 0x7fe00000, when encapsulate as built-in float type.
            o.args = [Val(ValType.f32(), bytearray(r.read(4)) + bytearray(4))]
            return o
        if o.opcode == opcode.f64_const:
            o.args = [Val(ValType.f64(), bytearray(r.read(8)))]
            return o
        if o.opcode not in opcode.name:
            raise Exception("unsupported opcode", o.opcode)
        return o


class CustomSec:
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


class TypeSec:
    # The type section has the id 1. It decodes into a vector of function types that represent the types component of a
    # module.

    def __init__(self, data: typing.List[FuncType]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([FuncType.from_reader(r) for _ in range(n)])


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


class ImportSec:
    # The import section has the id 2. It decodes into a vector of imports that represent the imports component of a
    # module.

    def __init__(self, data: typing.List[Import]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([Import.from_reader(r) for _ in range(n)])


class FuncSec:
    # The function section has the id 3. It decodes into a vector of type indices that represent the type fields of the
    # functions in the funcs component of a module. The locals and body fields of the respective functions are encoded
    # separately in the code section.

    def __init__(self, data: typing.List[int]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([leb128.u.decode_reader(r)[0] for _ in range(n)])


class TableSec:
    # The table section has the id 4. It decodes into a vector of tables that represent the tables component of a
    # module.

    def __init__(self, data: typing.List[TableType]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([TableType.from_reader(r) for _ in range(n)])


class MemSec:
    # The memory section has the id 5. It decodes into a vector of memories that represent the mems component of a
    # module.

    def __init__(self, data: typing.List[Mem]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([Mem.from_reader(r) for _ in range(n)])


class Expr:
    # Function bodies, initialization values for globals, and offsets of element or data segments are given as
    # expressions, which are sequences of instructions terminated by an end marker.
    #
    # expr ::= instr∗ 0x0B
    #
    # In some places, validation restricts expressions to be constant, which limits the set of allowable instructions.
    def __init__(self):
        self.data: typing.List[Instruction] = []
        self.position: typing.Dict[int, typing.List[int]] = {}

    def __repr__(self):
        return f'expression({self.data})'

    @classmethod
    def mark(cls, data: typing.List[Instruction]) -> typing.Dict[int, typing.List[int]]:
        position = {}  # pc => { start, end, else }
        stack = []
        for i, e in enumerate(data):
            if e.opcode in [opcode.block, opcode.loop, opcode.if_then]:
                stack.append([i])
                continue
            if e.opcode == opcode.else_fi:
                stack[-1].append(i)
                continue
            if e.opcode == opcode.end:
                if stack:
                    b = stack.pop()
                    b.insert(1, i)
                    for e in b:
                        position[e] = b
                continue
        if stack:
            raise Exception('pywasm: expression ended in middle of body')
        return position

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Expr()
        d = 1
        while True:
            i = Instruction.from_reader(r)
            if not i:
                break
            o.data.append(i)
            if i.opcode in [opcode.block, opcode.loop, opcode.if_then]:
                d += 1
            if i.opcode == opcode.end:
                d -= 1
            if d == 0:
                break
        if o.data[-1].opcode != opcode.end:
            raise Exception('pywasm: expression did not end with 0xb')
        o.position = cls.mark(o.data)
        return o


class Global:
    # The globals component of a module defines a vector of global variables (or globals for short).

    def __init__(self, type: GlobalType, init: Expr) -> typing.Self:
        self.type = type
        self.init = init

    def __repr__(self) -> str:
        return repr(self.type)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(GlobalType.from_reader(r), Expr.from_reader(r))


class GlobalSec:
    # The global section has the id 6. It decodes into a vector of globals that represent the globals component of a
    # module.

    def __init__(self, data: typing.List[Global]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([Global.from_reader(r) for _ in range(n)])


class Export:
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


class ExportSec:
    # The export section has the id 7. It decodes into a vector of exports that represent the exports component of a
    # module.

    def __init__(self, data: typing.List[Export]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([Export.from_reader(r) for _ in range(n)])


class Start:
    # The start component of a module declares the function index of a start function that is automatically invoked
    # when the module is instantiated, after tables and memories have been initialized.

    def __init__(self, func: int) -> typing.Self:
        self.func = func

    def __repr__(self) -> str:
        return repr(self.func)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(leb128.u.decode_reader(r)[0])


class StartSec:
    # The start section has the id 8. It decodes into an optional start function that represents the start component of
    # a module.

    def __init__(self, start: Start) -> typing.Self:
        self.start = start

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(Start.from_reader(r))


class Elem:
    # The initial contents of a table is uninitialized. The elem component of a module defines a vector of element
    # segments that initialize a subrange of a table, at a given offset, from a static vector of elements.
    # The offset is given by a constant expression.

    def __init__(self, table: int, offset: Expr, init: typing.List[int]) -> typing.Self:
        self.table = table
        self.offset = offset
        self.init = init

    def __repr__(self) -> str:
        return f'{self.table}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        table = leb128.u.decode_reader(r)[0]
        offset = Expr.from_reader(r)
        init = [leb128.u.decode_reader(r)[0] for _ in range(leb128.u.decode_reader(r)[0])]
        return cls(table, offset, init)


class ElemSec:
    # The element section has the id 9. It decodes into a vector of element segments that represent the elem component
    # of a module.

    def __init__(self, data: typing.List[Elem]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls([Elem.from_reader(r) for _ in range(leb128.u.decode_reader(r)[0])])


class Locals:
    # The locals declare a vector of mutable local variables and their types. These variables are referenced through
    # local indices in the function’s body. The index of the first local is the smallest index not referencing a
    # parameter.

    def __init__(self, n: int, type: ValType) -> typing.Self:
        if n > 0x10000000:
            raise Exception('pywasm: too many locals')
        self.n = n
        self.type = type

    def __repr__(self) -> str:
        return f'{self.n}x{self.type}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(leb128.u.decode_reader(r)[0], ValType.from_reader(r))


class Func:
    def __init__(self, locals: typing.List[Locals], expr: Expr) -> typing.Self:
        self.locals = locals
        self.expr = expr

    def __repr__(self) -> str:
        return f'func'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls([Locals.from_reader(r) for _ in range(leb128.u.decode_reader(r)[0])], Expr.from_reader(r))


class Code:
    def __init__(self, size: int, func: Func) -> typing.Self:
        self.size = size
        self.func = func

    def __repr__(self) -> str:
        return 'code'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        size = leb128.u.decode_reader(r)[0]
        func = Func.from_reader(io.BytesIO(r.read(size)))
        return cls(size, func)


class CodeSec:
    # The code section has the id 10. It decodes into a vector of code entries that are pairs of value type vectors and
    # expressions. They represent the locals and body field of the functions in the funcs component of a module. The
    # type fields of the respective functions are encoded separately in the function section.

    def __init__(self, data: typing.List[Code]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls([Code.from_reader(r) for _ in range(leb128.u.decode_reader(r)[0])])


class Data:
    # The initial contents of a memory are zero-valued bytes. The data component of a module defines a vector of data
    # segments that initialize a range of memory, at a given offset, with a static vector of bytes.
    # The offset is given by a constant expression.

    def __init__(self, data: int, offset: Expr, init: bytearray) -> typing.Self:
        self.data = data
        self.offset = offset
        self.init = init

    def __repr__(self) -> str:
        return f'{self.data} {self.offset} {self.init.hex()}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        data = leb128.u.decode_reader(r)[0]
        offset = Expr.from_reader(r)
        init = bytearray(r.read(leb128.u.decode_reader(r)[0]))
        return cls(data, offset, init)


class DataSec:
    # The data section has the id 11. It decodes into a vector of data segments that represent the data component of a
    # module.

    def __init__(self, data: typing.List[Data]) -> typing.Self:
        self.data = data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls([Data.from_reader(r) for _ in range(leb128.u.decode_reader(r)[0])])


class Function:
    # The funcs component of a module defines a vector of functions with the following structure:
    #
    # func ::= {type typeidx, locals vec(valtype), body expr}
    #
    # The type of a function declares its signature by reference to a type defined in the module. The parameters of the
    # function are referenced through 0-based local indices in the function’s body; they are mutable.
    #
    # The locals declare a vector of mutable local variables and their types. These variables are referenced through
    # local indices in the function’s body. The index of the first local is the smallest index not referencing a
    # parameter.
    #
    # The body is an instruction sequence that upon termination must produce a stack matching the function type’s
    # result type.
    #
    # Functions are referenced through function indices, starting with the smallest index not referencing
    # a function import.
    def __init__(self):
        self.type_index: int = 0
        self.local_list: typing.List[ValType] = []
        self.expr: Expr = Expr()

    def __repr__(self):
        return f'function({self.type_index}, {self.local_list})'


class Module:
    # The binary encoding of modules is organized into sections. Most sections correspond to one component of a module
    # record, except that function definitions are split into two sections, separating their type declarations in the
    # function section from their bodies in the code section.

    def __init__(self):
        self.type_list: typing.List[FuncType] = []
        self.function_list: typing.List[Function] = []
        self.table_list: typing.List[TableType] = []
        self.memory_list: typing.List[Mem] = []
        self.global_list: typing.List[Global] = []
        self.element_list: typing.List[Elem] = []
        self.data_list: typing.List[Data] = []
        self.start: typing.Optional[Start] = None
        self.import_list: typing.List[Import] = []
        self.export_list: typing.List[Export] = []

    def __repr__(self):
        return f'module({self.section_list})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        if bytearray(r.read(4)) != bytearray([0x00, 0x61, 0x73, 0x6d]):
            raise Exception('pywasm: magic header not detected')
        if bytearray(r.read(4)) != bytearray([0x01, 0x00, 0x00, 0x00]):
            raise Exception('pywasm: unknown binary version')

        type_section = TypeSec([])
        import_section = ImportSec([])
        function_section = FuncSec([])
        table_section = TableSec([])
        memory_section = MemSec([])
        global_section = GlobalSec([])
        export_section = ExportSec([])
        start_section = None
        element_section = ElemSec([])
        code_section = CodeSec([])
        data_section = DataSec([])

        mod = Module()
        while True:
            section_id_byte = r.read(1)
            if not section_id_byte:
                break
            section_id = ord(section_id_byte)
            n = leb128.u.decode_reader(r)[0]
            section_data = bytearray(r.read(n))
            if len(section_data) != n:
                raise Exception('pywasm: unexpected end of section or function')
            section_reader = io.BytesIO(section_data)

            if section_id == 0x00:
                custom_section = CustomSec.from_reader(section_reader)
                log.debugln('section custom', custom_section.name)
            if section_id == 0x01:
                type_section = TypeSec.from_reader(section_reader)
                mod.type_list = type_section.data
                log.debugln('section type')
                for i, e in enumerate(type_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x02:
                import_section = ImportSec.from_reader(section_reader)
                mod.import_list = import_section.data
                log.debugln('section import')
                for i, e in enumerate(import_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x03:
                function_section = FuncSec.from_reader(section_reader)
                log.debugln('section func')
                for i, e in enumerate(function_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x04:
                table_section = TableSec.from_reader(section_reader)
                mod.table_list = table_section.data
                log.debugln('section table')
                for i, e in enumerate(table_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x05:
                memory_section = MemSec.from_reader(section_reader)
                mod.memory_list = memory_section.data
                log.debugln('section mem')
                for i, e in enumerate(memory_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x06:
                global_section = GlobalSec.from_reader(section_reader)
                mod.global_list = global_section.data
                log.debugln('section global')
                for i, e in enumerate(global_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x07:
                export_section = ExportSec.from_reader(section_reader)
                mod.export_list = export_section.data
                log.debugln('section export')
                for i, e in enumerate(export_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x08:
                if mod.start:
                    raise Exception('pywasm: junk after last section')
                start_section = StartSec.from_reader(section_reader)
                mod.start = start_section.start
                log.debugln('section start', start_section.start)
            if section_id == 0x09:
                element_section = ElemSec.from_reader(section_reader)
                mod.element_list = element_section.data
                log.debugln('section elem')
                for i, e in enumerate(element_section.data):
                    log.debugln(f'    {i:>3d} {e}')
            if section_id == 0x0a:
                code_section = CodeSec.from_reader(section_reader)
                if len(function_section.data) != len(code_section.data):
                    raise Exception('pywasm: function and code section have inconsistent lengths')
                log.debugln('section code')
                for i, e in enumerate(code_section.data):
                    log.debugln(f'    {i:>3d} {e}')
                    func = Function()
                    func.type_index = function_section.data[i]
                    func.local_list = []
                    for f in e.func.locals:
                        for _ in range(f.n):
                            func.local_list.append(f.type)
                    func.expr = e.func.expr
                    mod.function_list.append(func)
            if section_id == 0x0b:
                data_section = DataSec.from_reader(section_reader)
                mod.data_list = data_section.data
                log.debugln('section data')
                for i, e in enumerate(data_section.data):
                    log.debugln(f'    {i:>3d} {e}')

            if section_reader.read(1):
                raise Exception('pywasm: section size mismatch')

        if len(function_section.data) != len(code_section.data):
            raise Exception('pywasm: function and code section have inconsistent lengths')
        if r.read(1):
            raise Exception('pywasm: junk after last section')

        return mod
