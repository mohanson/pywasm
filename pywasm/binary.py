import io
import typing

from . import convention
from . import instruction
from . import leb128
from . import log
from . import num

# ======================================================================================================================
# Binary Format Types
# ======================================================================================================================


class ValueType(int):
    # Value types are encoded by a single byte.
    # valtype ::= {
    #     0x7f: i32,
    #     0x7e: i64,
    #     0x7d: f32,
    #     0x7c: f64,
    # }
    def __repr__(self):
        return {
            convention.i32: 'i32',
            convention.i64: 'i64',
            convention.f32: 'f32',
            convention.f64: 'f64',
        }[self]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return ValueType(ord(r.read(1)))


class ResultType:
    # Result types classify the result of executing instructions or blocks, which is a sequence of values written with
    # brackets.
    #
    # resulttype ::= [valtype?]
    def __init__(self):
        self.data: typing.List[ValueType] = []

    def __repr__(self):
        return f'result_type({self.data.__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ResultType()
        n = leb128.u.decode_reader(r)[0]
        o.data = [ValueType.from_reader(r) for i in range(n)]
        return o


class FunctionType:
    # Function types are encoded by the byte 0x60 followed by the respective vectors of parameter and result types.
    #
    # functype ::= 0x60 t1∗:vec(valtype) t2∗:vec(valtype) ⇒ [t1∗] → [t2∗]
    def __init__(self):
        self.args: ResultType = ResultType()
        self.rets: ResultType = ResultType()

    def __repr__(self):
        return f'function_type({self.args}, {self.rets})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = FunctionType()
        i = r.read(1)
        assert ord(i) == convention.sign
        o.args = ResultType.from_reader(r)
        o.rets = ResultType.from_reader(r)
        return o


class Limits:
    # Limits are encoded with a preceding flag indicating whether a maximum is present.
    #
    # limits ::= 0x00  n:u32        ⇒ {min n,max ϵ}
    #          | 0x01  n:u32  m:u32 ⇒ {min n,max m}
    def __init__(self):
        self.n: int = 0
        self.m: int = 0

    def __repr__(self):
        return f'limits({self.n}, {self.m})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Limits()
        flag = ord(r.read(1))
        o.n = leb128.u.decode_reader(r)[0]
        o.m = leb128.u.decode_reader(r)[0] if flag else 0x00
        return o


class MemoryType:
    # Memory types classify linear memories and their size range.
    #
    # memtype ::= limits
    #
    # The limits constrain the minimum and optionally the maximum size of a memory. The limits are given in units of
    # page size.
    def __init__(self):
        self.limits: Limits = Limits()

    def __repr__(self):
        return f'memory_type({self.limits.__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = MemoryType()
        o.limits = Limits.from_reader(r)
        return o


class ElementType(int):
    # The element type funcref is the infinite union of all function types. A table of that type thus contains
    # references to functions of heterogeneous type.
    # In future versions of WebAssembly, additional element types may be introduced.
    def __repr__(self):
        return {
            convention.funcref: 'funcref',
        }[self]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return ElementType(ord(r.read(1)))


class TableType:
    # Table types classify tables over elements of element types within a size range.
    #
    # tabletype ::= limits elemtype
    # elemtype ::= funcref
    #
    # Like memories, tables are constrained by limits for their minimum and optionally maximum size. The limits are
    # given in numbers of entries. The element type funcref is the infinite union of all function types. A table of that
    # type thus contains references to functions of heterogeneous type.

    def __init__(self):
        self.element_type: ElementType = ElementType()
        self.limits: Limits = Limits()

    def __repr__(self):
        return f'table_type({self.element_type}, {self.limits})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TableType()
        o.element_type = ElementType.from_reader(r)
        o.limits = Limits.from_reader(r)
        return o


class Mut(int):
    # Mut const | var
    def __repr__(self):
        return {
            convention.const: 'const',
            convention.var: 'var',
        }[self]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return Mut(ord(r.read(1)))


class GlobalType:
    # Global types are encoded by their value type and a flag for their
    # mutability.
    #
    # globaltype ::= t:valtype m:mut ⇒ m t
    # mut ::= 0x00 ⇒ const
    #       | 0x01 ⇒ var
    def __init__(self):
        self.value_type: ValueType = ValueType()
        self.mut: Mut = Mut()

    def __repr__(self):
        return f'global_type({self.mut} {self.value_type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = GlobalType()
        o.value_type = ValueType.from_reader(r)
        o.mut = Mut.from_reader(r)
        return o


ExternalType = typing.Union[FunctionType, TableType, MemoryType, GlobalType]

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
        return ValueType(self).__repr__()

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
        return f'{instruction.opcode[self.opcode][0]} {self.args}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Instruction()
        o.opcode: int = ord(r.read(1))
        o.args = []
        if o.opcode in [
            instruction.block,
            instruction.loop,
            instruction.if_,
        ]:
            block_type = BlockType.from_reader(r)
            o.args = [block_type]
            return o
        if o.opcode in [
            instruction.br,
            instruction.br_if,
        ]:
            o.args = [LabelIndex(leb128.u.decode_reader(r)[0])]
            return o
        if o.opcode == instruction.br_table:
            n = leb128.u.decode_reader(r)[0]
            a = [LabelIndex(leb128.u.decode_reader(r)[0]) for _ in range(n)]
            b = LabelIndex(leb128.u.decode_reader(r)[0])
            o.args = [a, b]
            return o
        if o.opcode == instruction.call:
            o.args = [FunctionIndex(leb128.u.decode_reader(r)[0])]
            return o
        if o.opcode == instruction.call_indirect:
            i = TypeIndex(leb128.u.decode_reader(r)[0])
            n = ord(r.read(1))
            o.args = [i, n]
            return o
        if o.opcode in [
            instruction.get_local,
            instruction.set_local,
            instruction.tee_local,
        ]:
            o.args = [LocalIndex(leb128.u.decode_reader(r)[0])]
            return o
        if o.opcode in [
            instruction.get_global,
            instruction.set_global,
        ]:
            o.args = [GlobalIndex(leb128.u.decode_reader(r)[0])]
            return o
        if o.opcode in [
            instruction.i32_load,
            instruction.i64_load,
            instruction.f32_load,
            instruction.f64_load,
            instruction.i32_load8_s,
            instruction.i32_load8_u,
            instruction.i32_load16_s,
            instruction.i32_load16_u,
            instruction.i64_load8_s,
            instruction.i64_load8_u,
            instruction.i64_load16_s,
            instruction.i64_load16_u,
            instruction.i64_load32_s,
            instruction.i64_load32_u,
            instruction.i32_store,
            instruction.i64_store,
            instruction.f32_store,
            instruction.f64_store,
            instruction.i32_store8,
            instruction.i32_store16,
            instruction.i64_store8,
            instruction.i64_store16,
            instruction.i64_store32,
        ]:
            o.args = [leb128.u.decode_reader(r)[0], leb128.u.decode_reader(r)[0]]
            return o
        if o.opcode in [
            instruction.current_memory,
            instruction.grow_memory
        ]:
            n = ord(r.read(1))
            o.args = [n]
            return o
        if o.opcode == instruction.i32_const:
            o.args = [leb128.i.decode_reader(r)[0]]
            return o
        if o.opcode == instruction.i64_const:
            o.args = [leb128.i.decode_reader(r)[0]]
            return o
        if o.opcode == instruction.f32_const:
            # https://stackoverflow.com/questions/47961537/webassembly-f32-const-nan0x200000-means-0x7fa00000-or-0x7fe00000
            # python misinterpret 0x7fa00000 as 0x7fe00000, when encapsulate as built-in float type.
            o.args = [num.LittleEndian.i32(r.read(4))]
            return o
        if o.opcode == instruction.f64_const:
            o.args = [num.LittleEndian.i64(r.read(8))]
            return o
        if o.opcode not in instruction.opcode:
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
        self.data: typing.List[FunctionType] = []

    def __repr__(self):
        return f'type_section({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TypeSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [FunctionType.from_reader(r) for _ in range(n)]
        return o


ImportDesc = typing.Union[TypeIndex, TableType, MemoryType, GlobalType]


class Import:
    # The imports component of a module defines a set of imports that are required for instantiation.
    #
    # import ::= {module name, name name, desc importdesc}
    # importdesc ::= func typeidx | table tabletype | mem memtype | global globaltype
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
            convention.extern_table: TableType.from_reader,
            convention.extern_memory: MemoryType.from_reader,
            convention.extern_global: GlobalType.from_reader,
        }[n](r)
        return o


class ImportSection:
    # The import section has the id 2. It decodes into a vector of imports
    # that represent the imports component of a module.
    #
    # importsec ::= im∗:section2(vec(import)) ⇒ im∗
    # import ::= mod:name nm:name d:importdesc ⇒ {module mod, name nm, desc d}
    # importdesc ::= 0x00 x:typeidx ⇒ func x
    #              | 0x01 tt:tabletype ⇒ table tt
    #              | 0x02 mt:memtype ⇒ mem mt
    #              | 0x03 gt:globaltype ⇒ global gt

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
    # table ::= {type tabletype}
    def __init__(self):
        self.type: TableType = TableType()

    def __repr__(self):
        return f'table({self.type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Table()
        o.type = TableType.from_reader(r)
        return o


class TableSection:
    # The table section has the id 4. It decodes into a vector of tables that
    # represent the tables component of a module.
    #
    # tablesec ::= tab∗:section4(vec(table)) ⇒ tab∗
    # table ::= tt:tabletype ⇒ {type tt}

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
        self.type: MemoryType = MemoryType()

    def __repr__(self):
        return f'memory({self.type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Memory()
        o.type = MemoryType.from_reader(r)
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
            if e.opcode in [instruction.block, instruction.loop, instruction.if_]:
                stack.append([i])
                continue
            if e.opcode == instruction.else_:
                stack[-1].append(i)
                continue
            if e.opcode == instruction.end:
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
            if i.opcode in [instruction.block, instruction.loop, instruction.if_]:
                d += 1
            if i.opcode == instruction.end:
                d -= 1
            if d == 0:
                break
        if o.data[-1].opcode != instruction.end:
            raise Exception('pywasm: expression did not end with 0xb')
        o.position = cls.mark(o.data)
        return o


class Global:
    # The globals component of a module defines a vector of global variables (or globals for short):
    #
    # global ::= {type globaltype, init expr}
    def __init__(self):
        self.type: GlobalType = GlobalType()
        self.expr: Expression = Expression()

    def __repr__(self):
        return f'global({self.type}, {self.expr})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Global()
        o.type = GlobalType.from_reader(r)
        o.expr = Expression.from_reader(r)
        return o


class GlobalSection:
    # The global section has the id 6. It decodes into a vector of globals
    # that represent the globals component of a module.
    #
    # globalsec ::= glob*:section6(vec(global)) ⇒ glob∗
    # global ::= gt:globaltype e:expr ⇒ {type gt, init e}

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
        self.type: ValueType = ValueType()

    def __repr__(self):
        return f'locals({self.n}, {self.type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Locals()
        o.n = leb128.u.decode_reader(r)[0]
        if o.n > 0x10000000:
            raise Exception('pywasm: too many locals')
        o.type = ValueType.from_reader(r)
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
        self.local_list: typing.List[ValueType] = []
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

        self.type_list: typing.List[FunctionType] = []
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
