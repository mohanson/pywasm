import io
import typing

from pywasm import common
from pywasm import convention
from pywasm import log
from pywasm import num


class FunctionType:
    # Function types are encoded by the byte 0x60 followed by the respective vectors of parameter and result types.
    #
    # functype ::= 0x60 t1∗:vec(valtype) t2∗:vec(valtype) ⇒ [t1∗] → [t2∗]
    def __init__(self):
        self.args: typing.List[int]
        self.rets: typing.List[int]

    def __repr__(self):
        args = [convention.valtype[i][0] for i in self.args]
        rets = [convention.valtype[i][0] for i in self.rets]
        return f'FuncType<args={args} rets={rets}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = FunctionType()
        assert ord(r.read(1)) == 0x60
        o.args = common.read_bytes(r)
        o.rets = common.read_bytes(r)
        return o


class ResultType:
    # Result types classify the result of executing instructions or blocks, which is a sequence of values written with
    # brackets.
    #
    # resulttype ::= [valtype?]
    pass


class Limits:
    # Limits are encoded with a preceding flag indicating whether a maximum is present.
    #
    # limits ::= 0x00  n:u32        ⇒ {min n,max ϵ}
    #          | 0x01  n:u32  m:u32 ⇒ {min n,max m}
    def __init__(self):
        self.minimum: int
        self.maximum: int

    def __repr__(self):
        return f'Limits<minimum={self.minimum} maximum={self.maximum}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Limits()
        flag = ord(r.read(1))
        o.minimum = common.read_count(r)
        o.maximum = common.read_count(r) if flag else None
        return o


class MemoryType:
    # Memory types classify linear memories and their size range.
    #
    # memtype ::= limits
    #
    # The limits constrain the minimum and optionally the maximum size of a memory. The limits are given in units of
    # page size.
    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return Limits.from_reader(r)


class TableType:
    # Table types classify tables over elements of element types within a size range.
    #
    # tabletype :: =limits elemtype
    # elemtype ::= funcref
    #
    # Like memories, tables are constrained by limits for their minimum and optionally maximum size. The limits are
    # given in numbers of entries. The element type funcref is the infinite union of all function types. A table of that
    # type thus contains references to functions of heterogeneous type.

    def __init__(self):
        self.limits: Limits
        self.elemtype: int

    def __repr__(self):
        return f'TableType<limits={self.limits} elemtype={convention.elemtype[self.elemtype]}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TableType()
        o.elemtype = ord(r.read(1))
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
        self.valtype: int
        self.mut: bool

    def __repr__(self):
        return f'GlobalType<valtype={convention.valtype[self.valtype]} mut={self.mut}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = GlobalType()
        o.valtype = ord(r.read(1))
        o.mut = ord(r.read(1)) == 1
        return o


class ExternalType:
    # External types classify imports and external values with their respective types.
    #
    # externtype ::= func functype | table tabletype | mem memtype | global globaltype
    pass


class Expression:
    # Function bodies, initialization values for globals, and offsets of element or data segments are given as
    # expressions, which are sequences of instructions terminated by an end marker.
    #
    # expr ::= instr∗ end
    #
    # In some places, validation restricts expressions to be constant, which limits the set of allowable instructions.

    def __init__(self):
        self.data: bytearray

    def __repr__(self):
        return f'Expression<data={self.data.hex()}>'

    @classmethod
    def skip(cls, opcode: int, r: typing.BinaryIO):
        data = bytearray()
        for e in convention.opcodes[opcode][1]:
            if e == 'leb_1':
                data.extend(num.leb(r, 1)[2])
            elif e == 'leb_7':
                data.extend(num.leb(r, 7)[2])
            elif e == 'leb_32':
                data.extend(num.leb(r, 32)[2])
            elif e == 'leb_64':
                data.extend(num.leb(r, 64)[2])
            elif e == 'bit_32':
                data.extend(r.read(4))
            elif e == 'bit_64':
                data.extend(r.read(8))
            elif e == 'leb_32xleb_32':
                _, c, a = num.leb(r, 32)
                data.extend(a)
                for _ in range(c):
                    data.extend(num.leb(r, 32)[2])
            else:
                log.panicln('pywasm: invalid code size')
        return data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        data = bytearray()
        d = 1
        for _ in range(1 << 32):
            op = ord(r.read(1))
            data.append(op)
            if op in [convention.block, convention.loop, convention.if_]:
                d += 1
            elif op == convention.end:
                d -= 1
                if not d:
                    break
            else:
                continue
            data.extend(cls.skip(op, r))
        o = Expression()
        o.data = data
        return o


class Function:
    # The funcs component of a module defines a vector of functions with the following structure:
    #
    # func ::= {type typeidx, locals vec(valtype), body expr}
    pass


class Table:
    # The tables component of a module defines a vector of tables described by their table type:
    #
    # table ::= {type tabletype}
    def __init__(self):
        self.tabletype: TableType

    def __repr__(self):
        return f'Table<tabletype={self.tabletype}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Table()
        o.tabletype = TableType.from_reader(r)
        return o


class Memory:
    # The mems component of a module defines a vector of linear memories (or memories for short) as described by their
    # memory type:
    #
    # mem ::= {type memtype}
    pass


class Global:
    # The globals component of a module defines a vector of global variables (or globals for short):
    #
    # global ::= {type globaltype, init expr}
    pass


class ElementSegment:
    # The initial contents of a table is uninitialized. The elem component of a module defines a vector of element
    # segments that initialize a subrange of a table, at a given offset, from a static vector of elements.
    #
    # elem ::= {table tableidx, offset expr, init vec(funcidx)}
    #
    # The offset is given by a constant expression.
    pass


class DataSegment:
    # The initial contents of a memory are zero-valued bytes. The data component of a module defines a vector of data
    # segments that initialize a range of memory, at a given offset, with a static vector of bytes.
    #
    # data::={data memidx,offset expr,init vec(byte)}
    #
    # The offset is given by a constant expression.
    pass


class StartFunction:
    # The start component of a module declares the function index of a start function that is automatically invoked
    # when the module is instantiated, after tables and memories have been initialized.
    #
    # start ::= {func funcidx}
    pass


class Export:
    # The exports component of a module defines a set of exports that become accessible to the host environment once
    # the module has been instantiated.
    #
    # export ::= {name name, desc exportdesc}
    # exportdesc ::= func funcidx | table tableidx | mem memidx | global globalidx
    #
    # Each export is labeled by a unique name. Exportable definitions are functions, tables, memories, and globals,
    # which are referenced through a respective descriptor.
    pass


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
        self.module: str
        self.name: str
        self.desc = None

    def __repr__(self):
        return f'Import<module={self.module} name={self.name} desc={self.desc}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Import()
        o.module = common.read_bytes(r, 32).decode()
        o.name = common.read_bytes(r, 32).decode()
        kind = ord(r.read(1))
        if kind == 0x00:
            o.desc = common.read_count(r, 32)
        elif kind == 0x01:
            o.desc = TableType.from_reader(r)
        elif kind == 0x02:
            o.desc = MemoryType.from_reader(r)
        elif kind == 0x03:
            o.desc = GlobalType.from_reader(r)
        else:
            log.panicln('pywasm: malformed')
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
        self.name: str = None
        self.data: bytearray = None

    def __repr__(self):
        return f'Custom<name={self.name} data={self.data}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = CustomSection()
        n = common.read_count(r, 32)
        o.name = r.read(n).decode()
        o.data = bytearray(r.read(-1))
        return o


class TypeSection:
    # The type section has the id 1. It decodes into a vector of function
    # types that represent the types component of a module.
    #
    # typesec ::= ft∗:section1(vec(functype)) ⇒ ft∗

    def __init__(self):
        self.vec: typing.List[FunctionType] = []

    def __repr__(self):
        return f'TypeSection<vec={self.vec}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TypeSection()
        n = common.read_count(r, 32)
        o.vec = [FunctionType.from_reader(r) for _ in range(n)]
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
        self.vec: typing.List[Import] = []

    def __repr__(self):
        return f'ImportSection<vec={self.vec}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ImportSection()
        n = common.read_count(r, 32)
        o.vec = [Import.from_reader(r) for _ in range(n)]
        return o


class FunctionSection:
    # The function section has the id 3. It decodes into a vector of type
    # indices that represent the type fields of the functions in the funcs
    # component of a module. The locals and body fields of the respective
    # functions are encoded separately in the code section.
    #
    # funcsec ::= x∗:section3(vec(typeidx)) ⇒ x∗

    def __init__(self):
        self.vec: typing.List[int] = []

    def __repr__(self):
        return f'FunctionSection<vec={self.vec}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = FunctionSection()
        n = common.read_count(r, 32)
        o.vec = [common.read_count(r, 32) for _ in range(n)]
        return o


class TableSection:
    # The table section has the id 4. It decodes into a vector of tables that
    # represent the tables component of a module.
    #
    # tablesec ::= tab∗:section4(vec(table)) ⇒ tab∗
    # table ::= tt:tabletype ⇒ {type tt}

    def __init__(self):
        self.vec: typing.List[Table] = []

    def __repr__(self):
        return f'TableSection<vec={self.vec}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TableSection()
        n = common.read_count(r, 32)
        o.vec = [Table.from_reader(r) for _ in range(n)]
        return o


# class SectionMemory:
#     """The memory section has the id 5. It decodes into a vector of memories
#     that represent the mems component of a module.

#     memsec ::= mem∗:section5(vec(mem)) ⇒ mem∗
#     mem ::= mt:memtype ⇒ {type mt}
#     """

#     def __init__(self):
#         self.entries: typing.List[Memory] = []

#     def __repr__(self):
#         return f'SectionMemory<entries={self.entries}>'

#     @classmethod
#     def from_section(cls, f: Section):
#         sec = SectionMemory()
#         r = io.BytesIO(f.contents)
#         n = wasmi.common.read_leb(r, 32)[1]
#         for _ in range(n):
#             e = Memory.from_reader(r)
#             sec.entries.append(e)
#         return sec


# class SectionGlobal:
#     """The global section has the id 6. It decodes into a vector of globals
#     that represent the globals component of a module.

#     globalsec ::= glob*:section6(vec(global)) ⇒ glob∗
#     global ::= gt:globaltype e:expr ⇒ {type gt, init e}
#     """

#     def __init__(self):
#         self.entries: typing.List[Global] = []

#     def __repr__(self):
#         return f'SectionGlobal<entries={self.entries}>'

#     @classmethod
#     def from_section(cls, f: Section):
#         sec = SectionGlobal()
#         r = io.BytesIO(f.contents)
#         n = wasmi.common.read_leb(r, 32)[1]
#         for _ in range(n):
#             e = Global.from_reader(r)
#             sec.entries.append(e)
#         return sec


# class SectionExport:
#     """The export section has the id 7. It decodes into a vector of exports
#     that represent the exports component of a module.

#     exportsec ::= ex∗:section7(vec(export)) ⇒ ex∗
#     export :: =nm:name d:exportdesc ⇒ {name nm, desc d}
#     exportdesc ::= 0x00 x:funcidx ⇒ func x
#                  | 0x01 x:tableidx ⇒ table x
#                  | 0x02 x:memidx ⇒ mem x
#                  | 0x03 x:globalidx⇒global x
#     """

#     def __init__(self):
#         self.entries: typing.List[Export] = []

#     def __repr__(self):
#         return f'SectionExport<entries={self.entries}>'

#     @classmethod
#     def from_section(cls, f: Section):
#         sec = SectionExport()
#         r = io.BytesIO(f.contents)
#         n = wasmi.common.read_leb(r, 32)[1]
#         for _ in range(n):
#             n = wasmi.common.read_leb(r, 32)[1]
#             name = r.read(n).decode()
#             kind = ord(r.read(1))
#             n = wasmi.common.read_leb(r, 32)[1]
#             sec.entries.append(Export(kind, name, n))
#         return sec


# class SectionStart:
#     """The start section has the id 8. It decodes into an optional start
#     function that represents the start component of a module.

#     startsec ::= st?:section8(start) ⇒ st?
#     start ::= x:funcidx ⇒ {func x}
#     """

#     def __init__(self):
#         self.funcidx: int

#     def __repr__(self):
#         return f'SectionStart<funcidx={self.funcidx}>'

#     @classmethod
#     def from_section(cls, f: Section):
#         sec = SectionStart()
#         r = io.BytesIO(f.contents)
#         n = wasmi.common.read_leb(r, 32)[1]
#         sec.funcidx = n
#         return sec


# class SectionElement:
#     """The element section has the id 9. It decodes into a vector of element
#     segments that represent the elem component of a module.

#     elemsec ::= seg∗:section9(vec(elem)) ⇒ seg
#     elem ::= x:tableidx e:expr y∗:vec(funcidx) ⇒ {table x, offset e, init y∗}
#     """

#     def __init__(self):
#         self.entries: typing.List[Element] = []

#     def __repr__(self):
#         return f'SectionElement<entries={self.entries}>'

#     @classmethod
#     def from_section(cls, f: Section):
#         sec = SectionElement()
#         r = io.BytesIO(f.contents)
#         n = wasmi.common.read_leb(r, 32)[1]
#         for _ in range(n):
#             e = Element.from_reader(r)
#             sec.entries.append(e)
#         return sec


# class SectionCode:
#     """The code section has the id 10. It decodes into a vector of code
#     entries that are pairs of value type vectors and expressions. They
#     represent the locals and body field of the functions in the funcs
#     component of a module. The type fields of the respective functions are
#     encoded separately in the function section.

#     The encoding of each code entry consists of
#         1. the u32 size of the function code in bytes,
#         2. the actual function code, which in turn consists of
#             1. the declaration of locals,
#             2. the function body as an expression.

#     Local declarations are compressed into a vector whose entries consist of
#         1. a u32 count,
#         2. a value type,

#     denoting count locals of the same value type.

#     codesec ::= code∗:section10(vec(code)) ⇒ code∗
#     code ::= size:u32 code:func ⇒ code(ifsize=||func||)
#     func ::= (t∗)∗:vec(locals) e:expr ⇒ concat((t∗)∗), e∗(if|concat((t∗)∗)|<232)
#     locals ::= n:u32 t:valtype⇒tn
#     """

#     def __init__(self):
#         self.entries: typing.List[Code] = []

#     def __repr__(self):
#         return f'SectionCode<entries={self.entries}>'

#     @classmethod
#     def from_section(cls, f: Section):
#         sec = SectionCode()
#         r = io.BytesIO(f.contents)
#         n = wasmi.common.read_leb(r, 32)[1]
#         for _ in range(n):
#             e = Code.from_reader(r)
#             sec.entries.append(e)
#         return sec


# class SectionData:
#     """The data section has the id 11. It decodes into a vector of data
#     segments that represent the data component of a module.

#     datasec ::= seg∗:section11(vec(data)) ⇒ seg
#     data ::= x:memidx e:expr b∗:vec(byte) ⇒ {data x,offset e,init b∗}
#     """

#     def __init__(self):
#         self.entries: typing.List[Data] = []

#     def __repr__(self):
#         return f'SectionData<entries={self.entries}>'

#     @classmethod
#     def from_section(cls, f: Section):
#         sec = SectionData()
#         r = io.BytesIO(f.contents)
#         n = wasmi.common.read_leb(r, 32)[1]
#         for _ in range(n):
#             e = Data.from_reader(r)
#             sec.entries.append(e)
#         return sec


class Module:
    def __init__(self):
        self.custom_section: CustomSection = None
        self.type_section: TypeSection = None
        self.import_section: ImportSection = None
        self.function_section: FunctionSection = None
        self.table_section: TableSection = None

    def __repr__(self):
        pass

    @classmethod
    def open(cls, file: str):
        with open(file, 'rb') as f:
            return cls.from_reader(f)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        if list(r.read(4)) != [0x00, 0x61, 0x73, 0x6d]:
            log.panicln('pywasm: invalid magic number')
        if list(r.read(4)) != [0x01, 0x00, 0x00, 0x00]:
            log.panicln('pywasm: invalid version')
        mod = Module()
        log.debugln('Sections:')
        while True:
            section_id_byte = r.read(1)
            if not section_id_byte:
                break
            section_id = ord(section_id_byte)
            n = common.read_count(r, 32)
            data = r.read(n)
            if len(data) != n:
                log.panicln('pywasm: invalid section size')
            if section_id == convention.custom_section:
                mod.custom_section = CustomSection.from_reader(io.BytesIO(data))
                log.debugln(mod.custom_section)
            elif section_id == convention.type_section:
                mod.type_section = TypeSection.from_reader(io.BytesIO(data))
                log.debugln(mod.type_section)
            elif section_id == convention.import_section:
                mod.import_section = ImportSection.from_reader(io.BytesIO(data))
                log.debugln(mod.import_section)
            elif section_id == convention.function_section:
                mod.function_section = FunctionSection.from_reader(io.BytesIO(data))
                log.debugln(mod.function_section)
            elif section_id == convention.table_section:
                mod.table_section = TableSection.from_reader(io.BytesIO(data))
                log.debugln(mod.table_section)
            elif section_id == convention.memory_section:
                pass
            elif section_id == convention.global_section:
                pass
            elif section_id == convention.export_section:
                pass
            elif section_id == convention.start_section:
                pass
            elif section_id == convention.element_section:
                pass
            elif section_id == convention.code_section:
                pass
            elif section_id == convention.data_section:
                pass
            else:
                log.panicln('pywasm: invalid section id')
