import io
import typing

from . import convention
from . import leb128
from . import log
from . import num
from . import opcode

# ======================================================================================================================
# Binary Format Types
# ======================================================================================================================


class TypeVal:
    # Value types are encoded by a single byte.

    def __init__(self, data: int) -> typing.Self:
        assert data in [0x7f, 0x7e, 0x7d, 0x7c]
        self.data = data

    def __eq__(self, other: typing.Self) -> bool:
        return self.data == other.data

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


class TypeResult:
    # Result types classify the result of executing instructions or blocks, which is a sequence of values written with
    # brackets.

    def __init__(self, data: typing.List[TypeVal]) -> typing.Self:
        self.data = data

    def __eq__(self, other: typing.Self) -> bool:
        return self.data == other.data

    def __repr__(self) -> str:
        return self.data.__repr__()

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        n = leb128.u.decode_reader(r)[0]
        return cls([TypeVal.from_reader(r) for _ in range(n)])


class TypeFunc:
    # Function types are encoded by the byte 0x60 followed by the respective vectors of parameter and result types.

    def __init__(self, args: TypeResult, rets: TypeResult) -> typing.Self:
        self.args = args
        self.rets = rets

    def __eq__(self, other: typing.Self) -> bool:
        return self.args == other.args and self.rets == other.rets

    def __repr__(self) -> str:
        return f'{self.args} -> {self.rets}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        assert ord(r.read(1)) == 0x60
        return cls(TypeResult.from_reader(r), TypeResult.from_reader(r))


class Limits:
    # Limits are encoded with a preceding flag indicating whether a maximum is present.

    def __init__(self, n: int, m: int) -> typing.Self:
        self.n = n
        self.m = m

    def __repr__(self) -> str:
        return repr([self.n, self.m])

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        flag = ord(r.read(1))
        n = leb128.u.decode_reader(r)[0]
        m = leb128.u.decode_reader(r)[0] if flag else 0x00
        return cls(n, m)


class TypeMem:
    # Memory types classify linear memories and their size range.
    # The limits constrain the minimum and optionally the maximum size of a memory. The limits are given in units of
    # page size.

    def __init__(self, limits: Limits) -> typing.Self:
        self.limits = limits

    def __repr__(self) -> str:
        return repr(self.limits)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(Limits.from_reader(r))


class TypeElem:
    # The element type funcref is the infinite union of all function types. A table of that type thus contains
    # references to functions of heterogeneous type.
    # In future versions of WebAssembly, additional element types may be introduced.

    def __init__(self, data: int) -> typing.Self:
        assert data == 0x70
        self.data = data

    def __eq__(self, other: typing.Self) -> bool:
        return self.data == other.data

    def __hash__(self) -> int:
        return hash(self.data)

    def __repr__(self) -> str:
        return {
            0x70: 'func',
        }[self.data]

    @classmethod
    def func(cls) -> typing.Self:
        return cls(0x70)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(ord(r.read(1)))


class TypeTable:
    # Table types classify tables over elements of element types within a size range.
    # Like memories, tables are constrained by limits for their minimum and optionally maximum size. The limits are
    # given in numbers of entries. The element type funcref is the infinite union of all function types. A table of that
    # type thus contains references to functions of heterogeneous type.

    def __init__(self, type: TypeElem, limits: Limits) -> typing.Self:
        self.type = type
        self.limits = limits

    def __repr__(self) -> str:
        return repr([self.type, self.limits])

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(TypeElem.from_reader(r), Limits.from_reader(r))


class Mut:
    def __init__(self, data: int) -> typing.Self:
        assert data in [0x00, 0x01]
        self.data = data

    def __eq__(self, other: typing.Self) -> bool:
        return self.data == other.data

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


class TypeGlobal:
    # Global types are encoded by their value type and a flag for their
    # mutability.

    def __init__(self, type: TypeVal, mut: Mut) -> typing.Self:
        self.type = type
        self.mut = mut

    def __repr__(self) -> str:
        return f'{self.mut} {self.type}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO) -> typing.Self:
        return cls(TypeVal.from_reader(r), Mut.from_reader(r))

# ======================================================================================================================
# Binary Format Instructions
# ======================================================================================================================


class BlockType(int):
    # Block types are encoded in special compressed form, by either the byte 0x40 indicating the empty type, as a
    # single value type, or as a type index encoded as a positive signed integer.
    #
    # blocktype ::= 0x40
    #             | t: valtype
    #             | x: s33
    def __repr__(self):
        if self == convention.empty:
            return 'empty'
        return TypeVal(self).__repr__()

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return BlockType(ord(r.read(1)))


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
            o.args = [LabelIndex(leb128.u.decode_reader(r)[0])]
            return o
        if o.opcode == opcode.br_table:
            n = leb128.u.decode_reader(r)[0]
            a = [LabelIndex(leb128.u.decode_reader(r)[0]) for _ in range(n)]
            b = LabelIndex(leb128.u.decode_reader(r)[0])
            o.args = [a, b]
            return o
        if o.opcode == opcode.call:
            o.args = [FunctionIndex(leb128.u.decode_reader(r)[0])]
            return o
        if o.opcode == opcode.call_indirect:
            i = TypeIndex(leb128.u.decode_reader(r)[0])
            n = ord(r.read(1))
            o.args = [i, n]
            return o
        if o.opcode in [
            opcode.local_get,
            opcode.local_set,
            opcode.local_tee,
        ]:
            o.args = [LocalIndex(leb128.u.decode_reader(r)[0])]
            return o
        if o.opcode in [
            opcode.global_get,
            opcode.global_set,
        ]:
            o.args = [GlobalIndex(leb128.u.decode_reader(r)[0])]
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
            o.args = [leb128.i.decode_reader(r)[0]]
            return o
        if o.opcode == opcode.i64_const:
            o.args = [leb128.i.decode_reader(r)[0]]
            return o
        if o.opcode == opcode.f32_const:
            # https://stackoverflow.com/questions/47961537/webassembly-f32-const-nan0x200000-means-0x7fa00000-or-0x7fe00000
            # python misinterpret 0x7fa00000 as 0x7fe00000, when encapsulate as built-in float type.
            o.args = [num.LittleEndian.i32(r.read(4))]
            return o
        if o.opcode == opcode.f64_const:
            o.args = [num.LittleEndian.i64(r.read(8))]
            return o
        if o.opcode not in opcode.name:
            raise Exception("unsupported opcode", o.opcode)
        return o

# ======================================================================================================================
# Binary Format Modules
# ======================================================================================================================


class TypeIndex(int):
    def __repr__(self):
        return f'type_index({super().__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return TypeIndex(leb128.u.decode_reader(r)[0])


class FunctionIndex(int):
    def __repr__(self):
        return f'function_index({super().__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return FunctionIndex(leb128.u.decode_reader(r)[0])


class TableIndex(int):
    def __repr__(self):
        return f'table_index({super().__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return TableIndex(leb128.u.decode_reader(r)[0])


class MemoryIndex(int):
    def __repr__(self):
        return f'memory_index({super().__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return MemoryIndex(leb128.u.decode_reader(r)[0])


class GlobalIndex(int):
    def __repr__(self):
        return f'global_index({super().__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return GlobalIndex(leb128.u.decode_reader(r)[0])


class LocalIndex(int):
    def __repr__(self):
        return f'local_index({super().__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return LocalIndex(leb128.u.decode_reader(r)[0])


class LabelIndex(int):
    def __repr__(self):
        return f'label_index({super().__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return LabelIndex(leb128.u.decode_reader(r)[0])


class Custom:
    # custom ::= name byte∗
    def __init__(self):
        self.name: str = ''
        self.data: bytearray = bytearray()

    def __repr__(self):
        return f'custom({self.name})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Custom()
        n = leb128.u.decode_reader(r)[0]
        o.name = r.read(n).decode()
        o.data = bytearray(r.read(-1))
        return o


class CustomSection:
    # Custom sections have the id 0. They are intended to be used for debugging
    # information or third-party extensions, and are ignored by the WebAssembly
    # semantics. Their contents consist of a name further identifying the custom
    # section, followed by an uninterpreted sequence of bytes for custom use.
    #
    # customsec ::= section0(custom)
    # custom ::= name byte∗
    def __init__(self):
        self.custom: Custom = Custom()

    def __repr__(self):
        return f'custom_section({self.custom})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = CustomSection()
        o.custom = Custom.from_reader(r)
        return o


class TypeSection:
    # The type section has the id 1. It decodes into a vector of function
    # types that represent the types component of a module.
    #
    # typesec ::= ft∗:section1(vec(functype)) ⇒ ft∗

    def __init__(self):
        self.data: typing.List[TypeFunc] = []

    def __repr__(self):
        return f'type_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TypeSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [TypeFunc.from_reader(r) for _ in range(n)]
        return o


ImportDesc = typing.Union[TypeIndex, TypeTable, TypeMem, TypeGlobal]


class Import:
    # The imports component of a module defines a set of imports that are required for instantiation.
    #
    # import ::= {module name, name name, desc importdesc}
    # importdesc ::= func typeidx | table TypeTable | mem memtype | global TypeGlobal
    #
    # Each import is labeled by a two-level name space, consisting of a module name and a name for an entity within
    # that module. Importable definitions are functions, tables, memories, and globals. Each import is specified by a
    # descriptor with a respective type that a definition provided during instantiation is required to match. Every
    # import defines an index in the respective index space. In each index space, the indices of imports go before the
    # first index of any definition contained in the module itself.

    def __init__(self):
        self.module: str = ''
        self.name: str = ''
        self.desc: ImportDesc = 0x00

    def __repr__(self):
        return f'import({self.module}.{self.name}, {self.desc})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Import()
        n = leb128.u.decode_reader(r)[0]
        o.module = r.read(n).decode()
        n = leb128.u.decode_reader(r)[0]
        o.name = r.read(n).decode()
        n = ord(r.read(1))
        o.desc = {
            convention.extern_function: TypeIndex.from_reader,
            convention.extern_table: TypeTable.from_reader,
            convention.extern_memory: TypeMem.from_reader,
            convention.extern_global: TypeGlobal.from_reader,
        }[n](r)
        return o


class ImportSection:
    # The import section has the id 2. It decodes into a vector of imports
    # that represent the imports component of a module.
    #
    # importsec ::= im∗:section2(vec(import)) ⇒ im∗
    # import ::= mod:name nm:name d:importdesc ⇒ {module mod, name nm, desc d}
    # importdesc ::= 0x00 x:typeidx ⇒ func x
    #              | 0x01 tt:TypeTable ⇒ table tt
    #              | 0x02 mt:memtype ⇒ mem mt
    #              | 0x03 gt:TypeGlobal ⇒ global gt

    def __init__(self):
        self.data: typing.List[Import] = []

    def __repr__(self):
        return f'import_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ImportSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Import.from_reader(r) for _ in range(n)]
        return o


class FunctionSection:
    # The function section has the id 3. It decodes into a vector of type
    # indices that represent the type fields of the functions in the funcs
    # component of a module. The locals and body fields of the respective
    # functions are encoded separately in the code section.
    #
    # funcsec ::= x∗:section3(vec(typeidx)) ⇒ x∗

    def __init__(self):
        self.data: typing.List[TypeIndex] = []

    def __repr__(self):
        return f'function_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = FunctionSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [TypeIndex.from_reader(r) for _ in range(n)]
        return o


class Table:
    # The tables component of a module defines a vector of tables described by their table type:
    #
    # table ::= {type TypeTable}
    def __init__(self):
        self.type: TypeTable

    def __repr__(self):
        return f'table({self.type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Table()
        o.type = TypeTable.from_reader(r)
        return o


class TableSection:
    # The table section has the id 4. It decodes into a vector of tables that
    # represent the tables component of a module.
    #
    # tablesec ::= tab∗:section4(vec(table)) ⇒ tab∗
    # table ::= tt:TypeTable ⇒ {type tt}

    def __init__(self):
        self.data: typing.List[Table] = []

    def __repr__(self):
        return f'table_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TableSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Table.from_reader(r) for _ in range(n)]
        return o


class Memory:
    # The mems component of a module defines a vector of linear memories (or memories for short) as described by their
    # memory type:
    #
    # mem ::= {type memtype}
    def __init__(self):
        self.type: TypeMem

    def __repr__(self):
        return f'memory({self.type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Memory()
        o.type = TypeMem.from_reader(r)
        return o


class MemorySection:
    # The memory section has the id 5. It decodes into a vector of memories
    # that represent the mems component of a module.
    #
    # memsec ::= mem∗:section5(vec(mem)) ⇒ mem∗
    # mem ::= mt:memtype ⇒ {type mt}

    def __init__(self):
        self.data: typing.List[Memory] = []

    def __repr__(self):
        return f'memory_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = MemorySection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Memory.from_reader(r) for _ in range(n)]
        return o


class Expression:
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
        o = Expression()
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
    # The globals component of a module defines a vector of global variables (or globals for short):
    #
    # global ::= {type TypeGlobal, init expr}
    def __init__(self):
        self.type: TypeGlobal
        self.expr: Expression

    def __repr__(self):
        return f'global({self.type}, {self.expr})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Global()
        o.type = TypeGlobal.from_reader(r)
        o.expr = Expression.from_reader(r)
        return o


class GlobalSection:
    # The global section has the id 6. It decodes into a vector of globals
    # that represent the globals component of a module.
    #
    # globalsec ::= glob*:section6(vec(global)) ⇒ glob∗
    # global ::= gt:TypeGlobal e:expr ⇒ {type gt, init e}

    def __init__(self):
        self.data: typing.List[Global] = []

    def __repr__(self):
        return f'global_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = GlobalSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Global.from_reader(r) for _ in range(n)]
        return o


class Export:
    # The exports component of a module defines a set of exports that become accessible to the host environment once
    # the module has been instantiated.
    #
    # export ::= {name name, desc exportdesc}
    # exportdesc ::= func funcidx | table tableidx | mem memidx | global globalidx
    #
    # Each export is labeled by a unique name. Exportable definitions are functions, tables, memories, and globals,
    # which are referenced through a respective descriptor.
    def __init__(self):
        self.name: str = ''
        self.type: int = 0x00
        self.desc: typing.Union[FunctionIndex, TableIndex, MemoryIndex, GlobalIndex] = 0x00

    def __repr__(self):
        return f'export({self.name}, {self.desc})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Export()
        o.name = bytearray(r.read(leb128.u.decode_reader(r)[0])).decode()
        o.type = ord(r.read(1))
        o.desc = {
            convention.extern_function: FunctionIndex.from_reader,
            convention.extern_table: TableIndex.from_reader,
            convention.extern_memory: MemoryIndex.from_reader,
            convention.extern_global: GlobalIndex.from_reader,
        }[o.type](r)
        return o


class ExportSection:
    # The export section has the id 7. It decodes into a vector of exports
    # that represent the exports component of a module.
    #
    # exportsec ::= ex∗:section7(vec(export)) ⇒ ex∗
    # export :: =nm:name d:exportdesc ⇒ {name nm, desc d}
    # exportdesc ::= 0x00 x:funcidx ⇒ func x
    #              | 0x01 x:tableidx ⇒ table x
    #              | 0x02 x:memidx ⇒ mem x
    #              | 0x03 x:globalidx⇒global x

    def __init__(self):
        self.data: typing.List[Export] = []

    def __repr__(self):
        return f'export_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ExportSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Export.from_reader(r) for _ in range(n)]
        return o


class StartFunction:
    # The start component of a module declares the function index of a start function that is automatically invoked
    # when the module is instantiated, after tables and memories have been initialized.
    #
    # start ::= {func funcidx}
    def __init__(self):
        self.function_idx: FunctionIndex = FunctionIndex()

    def __repr__(self):
        return f'start_function({self.function_idx})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = StartFunction()
        o.function_idx = FunctionIndex.from_reader(r)
        return o


class StartSection:
    # The start section has the id 8. It decodes into an optional start
    # function that represents the start component of a module.
    #
    # startsec ::= st?:section8(start) ⇒ st?
    # start ::= x:funcidx ⇒ {func x}

    def __init__(self):
        self.start: StartFunction = StartFunction()

    def __repr__(self):
        return f'start_section({self.start})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = StartSection()
        o.start = StartFunction.from_reader(r)
        return o


class Element:
    # The initial contents of a table is uninitialized. The elem component of a module defines a vector of element
    # segments that initialize a subrange of a table, at a given offset, from a static vector of elements.
    #
    # elem ::= {table tableidx, offset expr, init vec(funcidx)}
    #
    # The offset is given by a constant expression.
    def __init__(self):
        self.table_index: TableIndex = 0x00
        self.offset: Expression = Expression()
        self.init: typing.List[FunctionIndex] = []

    def __repr__(self):
        return f'element({self.table_index}, {self.offset}, {self.init})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Element()
        o.table_index = TableIndex.from_reader(r)
        o.offset = Expression.from_reader(r)
        n = leb128.u.decode_reader(r)[0]
        o.init = [FunctionIndex.from_reader(r) for _ in range(n)]
        return o


class ElementSection:
    # The element section has the id 9. It decodes into a vector of element
    # segments that represent the elem component of a module.
    #
    # elemsec ::= seg∗:section9(vec(elem)) ⇒ seg
    # elem ::= x:tableidx e:expr y∗:vec(funcidx) ⇒ {table x, offset e, init y∗}
    def __init__(self):
        self.data: typing.List[Element] = []

    def __repr__(self):
        return f'element_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ElementSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Element.from_reader(r) for _ in range(n)]
        return o


class Locals:
    # The locals declare a vector of mutable local variables and their types. These variables are referenced through
    # local indices in the function’s body. The index of the first local is the smallest index not referencing a
    # parameter.
    #
    # locals ::= n:u32 t:valtype ⇒ tn
    def __init__(self):
        self.n: int = 0x00
        self.type: TypeVal

    def __repr__(self):
        return f'locals({self.n}, {self.type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Locals()
        o.n = leb128.u.decode_reader(r)[0]
        if o.n > 0x10000000:
            raise Exception('pywasm: too many locals')
        o.type = TypeVal.from_reader(r)
        return o


class Func:
    def __init__(self):
        self.local_list: typing.List[Locals] = []
        self.expr: Expression = Expression()

    def __repr__(self):
        return f'func({self.local_list}, {self.expr})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Func()
        n = leb128.u.decode_reader(r)[0]
        o.local_list = [Locals.from_reader(r) for i in range(n)]
        o.expr = Expression.from_reader(r)
        return o


class Code:
    # The encoding of each code entry consists of
    #   - the u32 size of the function code in bytes
    #   - the actual function code, which in turn consists of
    #       - the declaration of locals
    #      -  the function body as an expression.
    #
    # Local declarations are compressed into a vector whose entries consist of
    #   - a u32 count
    #   - a value type.
    #
    # code ::= size:u32 code:func ⇒ code(ifsize=||func||)
    # func ::= (t∗)∗:vec(locals) e:expr ⇒ concat((t∗)∗), e∗(if|concat((t∗)∗)|<232)
    # locals ::= n:u32 t:valtype ⇒ tn
    def __init__(self):
        self.size: int = 0x00
        self.func: Func = Func()

    def __repr__(self):
        return f'code({self.size}, {self.func})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Code()
        o.size = leb128.u.decode_reader(r)[0]
        r = io.BytesIO(r.read(o.size))
        o.func = Func.from_reader(r)
        return o


class CodeSection:
    # The code section has the id 10. It decodes into a vector of code
    # entries that are pairs of value type vectors and expressions. They
    # represent the locals and body field of the functions in the funcs
    # component of a module. The type fields of the respective functions are
    # encoded separately in the function section.
    def __init__(self):
        self.data: typing.List[Code] = []

    def __repr__(self):
        return f'code_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = CodeSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Code.from_reader(r) for _ in range(n)]
        return o


class Data:
    # The initial contents of a memory are zero-valued bytes. The data component of a module defines a vector of data
    # segments that initialize a range of memory, at a given offset, with a static vector of bytes.
    #
    # data::={data memidx,offset expr,init vec(byte)}
    #
    # The offset is given by a constant expression.
    def __init__(self):
        self.memory_index: MemoryIndex = MemoryIndex()
        self.offset: Expression = Expression()
        self.init: bytearray = bytearray()

    def __repr__(self):
        return f'data({self.memory_index}, {self.offset}, {self.init})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Data()
        o.memory_index = MemoryIndex.from_reader(r)
        o.offset = Expression.from_reader(r)
        n = leb128.u.decode_reader(r)[0]
        o.init = bytearray(r.read(n))
        if len(o.init) != n:
            raise Exception('pywasm: unexpected end of section or function')
        return o


class DataSection:
    # The data section has the id 11. It decodes into a vector of data
    # segments that represent the data component of a module.
    #
    # datasec ::= seg∗:section11(vec(data)) ⇒ seg
    # data ::= x:memidx e:expr b∗:vec(byte) ⇒ {data x,offset e,init b∗}
    def __init__(self):
        self.data: typing.List[Data] = []

    def __repr__(self):
        return f'data_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = DataSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [Data.from_reader(r) for _ in range(n)]
        return o


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
        self.type_index: TypeIndex = TypeIndex()
        self.local_list: typing.List[TypeVal] = []
        self.expr: Expression = Expression()

    def __repr__(self):
        return f'function({self.type_index}, {self.local_list})'


class Module:
    # The binary encoding of modules is organized into sections. Most sections correspond to one component of a module
    # record, except that function definitions are split into two sections, separating their type declarations in the
    # function section from their bodies in the code section.

    def __init__(self):
        self.section_list: typing.Union[
            CustomSection,
            TypeSection,
            ImportSection,
            FunctionSection,
            TableSection,
            MemorySection,
            GlobalSection,
            ExportSection,
            ExportSection,
            StartSection,
            ElementSection,
            CodeSection,
            DataSection,
        ] = []

        self.type_list: typing.List[TypeFunc] = []
        self.function_list: typing.List[Function] = []
        self.table_list: typing.List[Table] = []
        self.memory_list: typing.List[Memory] = []
        self.global_list: typing.List[Global] = []
        self.element_list: typing.List[Element] = []
        self.data_list: typing.List[Data] = []
        self.start: typing.Optional[StartFunction] = None
        self.import_list: typing.List[Import] = []
        self.export_list: typing.List[Export] = []

    def __repr__(self):
        return f'module({self.section_list})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        if list(r.read(4)) != [0x00, 0x61, 0x73, 0x6d]:
            raise Exception('pywasm: magic header not detected')
        if list(r.read(4)) != [0x01, 0x00, 0x00, 0x00]:
            raise Exception('pywasm: unknown binary version')

        type_section = TypeSection()
        import_section = ImportSection()
        function_section = FunctionSection()
        table_section = TableSection()
        memory_section = MemorySection()
        global_section = GlobalSection()
        export_section = ExportSection()
        start_section = None
        element_section = ElementSection()
        code_section = CodeSection()
        data_section = DataSection()

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

            if section_id == convention.custom_section:
                custom_section = CustomSection.from_reader(section_reader)
                mod.section_list.append(custom_section)
                log.debugln(custom_section)
            if section_id == convention.type_section:
                type_section = TypeSection.from_reader(section_reader)
                mod.section_list.append(type_section)
                log.debugln(type_section)
                mod.type_list = type_section.data
            if section_id == convention.import_section:
                import_section = ImportSection.from_reader(section_reader)
                mod.section_list.append(import_section)
                log.debugln(import_section)
                mod.import_list = import_section.data
            if section_id == convention.function_section:
                function_section = FunctionSection.from_reader(section_reader)
                mod.section_list.append(function_section)
                log.debugln(function_section)
            if section_id == convention.table_section:
                table_section = TableSection.from_reader(section_reader)
                mod.section_list.append(table_section)
                log.debugln(table_section)
                mod.table_list = table_section.data
            if section_id == convention.memory_section:
                memory_section = MemorySection.from_reader(section_reader)
                mod.section_list.append(memory_section)
                log.debugln(memory_section)
                mod.memory_list = memory_section.data
            if section_id == convention.global_section:
                global_section = GlobalSection.from_reader(section_reader)
                mod.section_list.append(global_section)
                log.debugln(global_section)
                mod.global_list = global_section.data
            if section_id == convention.export_section:
                export_section = ExportSection.from_reader(section_reader)
                mod.section_list.append(export_section)
                log.debugln(export_section)
                mod.export_list = export_section.data
            if section_id == convention.start_section:
                if mod.start:
                    raise Exception('pywasm: junk after last section')
                start_section = StartSection.from_reader(section_reader)
                mod.section_list.append(start_section)
                log.debugln(start_section)
                mod.start = start_section.start
            if section_id == convention.element_section:
                element_section = ElementSection.from_reader(section_reader)
                mod.section_list.append(element_section)
                log.debugln(element_section)
                mod.element_list = element_section.data
            if section_id == convention.code_section:
                code_section = CodeSection.from_reader(section_reader)
                if len(function_section.data) != len(code_section.data):
                    raise Exception('pywasm: function and code section have inconsistent lengths')
                mod.section_list.append(code_section)
                log.debugln(code_section)
                for i, e in enumerate(code_section.data):
                    func = Function()
                    func.type_index = function_section.data[i]
                    func.local_list = []
                    for f in e.func.local_list:
                        for _ in range(f.n):
                            func.local_list.append(f.type)
                    func.expr = e.func.expr
                    mod.function_list.append(func)
            if section_id == convention.data_section:
                data_section = DataSection.from_reader(section_reader)
                mod.section_list.append(data_section)
                log.debugln(data_section)
                mod.data_list = data_section.data

            if section_reader.read(1):
                raise Exception('pywasm: section size mismatch')

        if len(function_section.data) != len(code_section.data):
            raise Exception('pywasm: function and code section have inconsistent lengths')
        if r.read(1):
            raise Exception('pywasm: junk after last section')

        return mod
