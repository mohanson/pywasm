import io
import typing

import leb128

from . import convention
from . import log


class ValueType:
    # Value types are encoded by a single byte.
    # valtype ::= {
    #     0x7f: i32,
    #     0x7e: i64,
    #     0x7d: f32,
    #     0x7c: f64,
    # }
    def __init__(self):
        self.byte: int = 0x00

    def __repr__(self):
        a = {
            convention.i32: 'i32',
            convention.i64: 'i64',
            convention.f32: 'f32',
            convention.f64: 'f64',
        }[self.byte]
        return f'ValueType({a})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ValueType()
        o.byte = ord(r.read(1))
        assert o.byte in convention.valtype
        return o


class ResultType:
    # Result types classify the result of executing instructions or blocks, which is a sequence of values written with
    # brackets.
    #
    # resulttype ::= [valtype?]
    def __init__(self):
        self.data: typing.List[ValueType] = []

    def __repr__(self):
        return f'ResultType({self.data.__repr__()})'

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
        return f'FunctionType({self.args}, {self.rets})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = FunctionType()
        assert ord(r.read(1)) == 0x60
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
        return f'Limits({self.n}, {self.m})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Limits()
        flag = ord(r.read(1))
        o.n = leb128.u.decode_reader(r)[0]
        o.m = leb128.u.decode_reader(r)[0] if flag else 0
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
        return f'MemoryType({self.limits.__repr__()})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = MemoryType()
        o.limits = Limits.from_reader(r)
        return o


class ElementType:
    # The element type funcref is the infinite union of all function types. A table of that type thus contains
    # references to functions of heterogeneous type.
    # In future versions of WebAssembly, additional element types may be introduced.
    def __init__(self):
        self.byte: int = 0x00

    def __repr__(self):
        a = {
            convention.funcref: 'funcref',
        }[self.byte]
        return f'ElementType({a})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ElementType()
        o.byte = ord(r.read(1))
        assert o.byte in convention.elemtype
        return o


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
        return f'TableType({self.element_type}, {self.limits})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TableType()
        o.element_type = ElementType.from_reader(r)
        o.limits = Limits.from_reader(r)
        return o


class GlobalType:
    # Global types are encoded by their value type and a flag for their
    # mutability.
    #
    # globaltype ::= t:valtype m:mut ⇒ m t
    # mut ::= 0x00 ⇒ const
    #       | 0x01 ⇒ var
    def __init__(self):
        self.value_type: ValueType = ValueType()
        self.mut: int = 0x00

    def __repr__(self):
        if self.mut:
            return f'GlobalType(var {self.value_type})'
        return f'GlobalType(const {self.value_type})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = GlobalType()
        o.value_type = ValueType.from_reader(r)
        o.mut = ord(r.read(1))
        assert o.mut in convention.mut
        return o


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
        self.type: int = 0x00
        self.module: str = ''
        self.name: str = ''
        self.desc: typing.Union[int, TableType, MemoryType, GlobalType] = 0x00

    def __repr__(self):
        return f'Import({self.module}.{self.name}, {self.desc})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Import()
        n = leb128.u.decode_reader(r)[0]
        o.module = r.read(n).decode()
        n = leb128.u.decode_reader(r)[0]
        o.name = r.read(n).decode()
        o.type = ord(r.read(1))
        o.desc = {
            convention.extern_function: lambda r: leb128.u.decode_reader(r)[0],
            convention.extern_table: TableType.from_reader,
            convention.extern_memory: MemoryType.from_reader,
            convention.extern_global: GlobalType.from_reader,
        }[o.type](r)
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
        self.name: str = ''
        self.data: bytearray = bytearray()

    def __repr__(self):
        return f'CustomSection({self.name})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = CustomSection()
        n = leb128.u.decode_reader(r)[0]
        o.name = r.read(n).decode()
        o.data = bytearray(r.read(-1))
        return o


class TypeSection:
    # The type section has the id 1. It decodes into a vector of function
    # types that represent the types component of a module.
    #
    # typesec ::= ft∗:section1(vec(functype)) ⇒ ft∗

    def __init__(self):
        self.data: typing.List[FunctionType] = []

    def __repr__(self):
        return f'TypeSection({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TypeSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [FunctionType.from_reader(r) for _ in range(n)]
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
        return f'ImportSection({self.data})'

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
        self.data: typing.List[int] = []

    def __repr__(self):
        return f'FunctionSection({self.data})'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = FunctionSection()
        n = leb128.u.decode_reader(r)[0]
        o.data = [leb128.u.decode_reader(r)[0] for _ in range(n)]
        return o


# class TableSection:
#     # The table section has the id 4. It decodes into a vector of tables that
#     # represent the tables component of a module.
#     #
#     # tablesec ::= tab∗:section4(vec(table)) ⇒ tab∗
#     # table ::= tt:tabletype ⇒ {type tt}

#     def __init__(self):
#         self.vec: typing.List[Table] = []

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = TableSection()
#         n = leb128.u.decode_reader(r)[0]
#         o.vec = [Table.from_reader(r) for _ in range(n)]
#         return o


# class MemorySection:
#     # The memory section has the id 5. It decodes into a vector of memories
#     # that represent the mems component of a module.
#     #
#     # memsec ::= mem∗:section5(vec(mem)) ⇒ mem∗
#     # mem ::= mt:memtype ⇒ {type mt}

#     def __init__(self):
#         self.vec: typing.List[Memory] = []

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = MemorySection()
#         n = leb128.u.decode_reader(r)[0]
#         o.vec = [Memory.from_reader(r) for _ in range(n)]
#         return o


# class GlobalSection:
#     # The global section has the id 6. It decodes into a vector of globals
#     # that represent the globals component of a module.
#     #
#     # globalsec ::= glob*:section6(vec(global)) ⇒ glob∗
#     # global ::= gt:globaltype e:expr ⇒ {type gt, init e}

#     def __init__(self):
#         self.vec: typing.List[Global] = []

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = GlobalSection()
#         n = leb128.u.decode_reader(r)[0]
#         o.vec = [Global.from_reader(r) for _ in range(n)]
#         return o


# class ExportSection:
#     # The export section has the id 7. It decodes into a vector of exports
#     # that represent the exports component of a module.
#     #
#     # exportsec ::= ex∗:section7(vec(export)) ⇒ ex∗
#     # export :: =nm:name d:exportdesc ⇒ {name nm, desc d}
#     # exportdesc ::= 0x00 x:funcidx ⇒ func x
#     #              | 0x01 x:tableidx ⇒ table x
#     #              | 0x02 x:memidx ⇒ mem x
#     #              | 0x03 x:globalidx⇒global x

#     def __init__(self):
#         self.vec: typing.List[Export] = []

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = ExportSection()
#         n = leb128.u.decode_reader(r)[0]
#         o.vec = [Export.from_reader(r) for _ in range(n)]
#         return o


# class StartSection:
#     # The start section has the id 8. It decodes into an optional start
#     # function that represents the start component of a module.
#     #
#     # startsec ::= st?:section8(start) ⇒ st?
#     # start ::= x:funcidx ⇒ {func x}

#     def __init__(self):
#         self.start_function: StartFunction

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = StartSection()
#         o.start_function = StartFunction.from_reader(r)
#         return o


# class ElementSection:
#     # The element section has the id 9. It decodes into a vector of element
#     # segments that represent the elem component of a module.
#     #
#     # elemsec ::= seg∗:section9(vec(elem)) ⇒ seg
#     # elem ::= x:tableidx e:expr y∗:vec(funcidx) ⇒ {table x, offset e, init y∗}
#     def __init__(self):
#         self.vec: typing.List[ElementSegment]

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = ElementSection()
#         n = leb128.u.decode_reader(r)[0]
#         o.vec = [ElementSegment.from_reader(r) for _ in range(n)]
#         return o


# class CodeSection:
#     # The code section has the id 10. It decodes into a vector of code
#     # entries that are pairs of value type vectors and expressions. They
#     # represent the locals and body field of the functions in the funcs
#     # component of a module. The type fields of the respective functions are
#     # encoded separately in the function section.
#     def __init__(self):
#         self.vec: typing.List[Code] = []

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = CodeSection()
#         n = leb128.u.decode_reader(r)[0]
#         o.vec = [Code.from_reader(r) for _ in range(n)]
#         return o


# class DataSection:
#     # The data section has the id 11. It decodes into a vector of data
#     # segments that represent the data component of a module.
#     #
#     # datasec ::= seg∗:section11(vec(data)) ⇒ seg
#     # data ::= x:memidx e:expr b∗:vec(byte) ⇒ {data x,offset e,init b∗}
#     def __init__(self):
#         self.vec: typing.List[DataSegment] = []

#     @classmethod
#     def from_reader(cls, r: typing.BinaryIO):
#         o = DataSection()
#         n = leb128.u.decode_reader(r)[0]
#         o.vec = [DataSegment.from_reader(r) for _ in range(n)]
#         return o


class Module:
    # The binary encoding of modules is organized into sections. Most sections correspond to one component of a module
    # record, except that function definitions are split into two sections, separating their type declarations in the
    # function section from their bodies in the code section.

    def __init__(self):
        self.section_list: typing.List[typing.Union[
            CustomSection,
            TypeSection,
            ImportSection,
            FunctionSection,
            # TableSection,
            # MemorySection,
            # GlobalSection,
            # ExportSection,
            # StartSection,
            # ElementSection,
            # CodeSection,
            # DataSection,
        ]] = []

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        if list(r.read(4)) != [0x00, 0x61, 0x73, 0x6d]:
            raise Exception('pywasm: invalid magic number')
        if list(r.read(4)) != [0x01, 0x00, 0x00, 0x00]:
            raise Exception('pywasm: invalid version')
        mod = Module()
        while True:
            section_id_byte = r.read(1)
            if not section_id_byte:
                break
            section_id = ord(section_id_byte)
            n = leb128.u.decode_reader(r)[0]
            data = bytearray(r.read(n))
            if len(data) != n:
                raise Exception('pywasm: invalid section size')
            s = {
                convention.custom_section: CustomSection.from_reader,
                convention.type_section: TypeSection.from_reader,
                convention.import_section: ImportSection.from_reader,
                convention.function_section: FunctionSection.from_reader,
            }[section_id](io.BytesIO(data))
            log.debugln(s)
            mod.section_list.append(s)

        # table_section = 0x04
        # memory_section = 0x05
        # global_section = 0x06
        # export_section = 0x07
        # start_section = 0x08
        # element_section = 0x09
        # code_section = 0x0a
        # data_section = 0x0b
