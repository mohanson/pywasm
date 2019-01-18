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
        a = ', '.join(args)
        b = rets[0]
        return f'({a}) -> {b}'

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
        if self.maximum:
            return f'minimum={self.minimum} maximum={self.maximum}'
        return f'minimum={self.minimum}'

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
        if self.mut:
            return f'var {convention.valtype[self.valtype]}'
        return f'const {convention.valtype[self.valtype]}'

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


class Instruction:
    # Instructions are encoded by opcodes. Each opcode is represented by a single byte, and is followed by the
    # instruction’s immediate arguments, where present. The only exception are structured control instructions,
    # which consist of several opcodes bracketing their nested instruction sequences.
    def __init__(self):
        self.code: int
        self.immediate_arguments = None

    def __repr__(self):
        if self.immediate_arguments is None:
            return f'{convention.opcodes[self.code][0]}'
        return f'{convention.opcodes[self.code][0]} {self.immediate_arguments}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        code_byte = r.read(1)
        if not code_byte:
            return None
        code = ord(code_byte)
        code_size = convention.opcodes[code][1]
        o = Instruction()
        o.code = code
        if code_size == '':
            pass
        elif code_size == 'u8':
            o.immediate_arguments = common.read_count(r, 8)
        elif code_size == 'u32':
            o.immediate_arguments = common.read_count(r, 32)
        elif code_size == 'i32':
            o.immediate_arguments = common.read_count(r, 32, signed=True)
        elif code_size == 'i64':
            o.immediate_arguments = common.read_count(r, 64, signed=True)
        elif code_size == 'f32':
            o.immediate_arguments = num.LittleEndian.f32(r.read(4))
        elif code_size == 'f64':
            o.immediate_arguments = num.LittleEndian.f64(r.read(8))
        elif code_size == 'u32,u32':
            o.immediate_arguments = [common.read_count(r, 32) for _ in range(2)]
        elif code_size == 'complex':
            if code in [convention.block, convention.loop, convention.if_]:
                rt = ord(r.read(1))
                instar = []
                if code == convention.if_:
                    instar_else = []
                    while True:
                        i = Instruction.from_reader(r)
                        instar.append(i)
                        if i.code in [convention.else_, convention.end]:
                            break
                    if instar[-1].code == convention.else_:
                        while True:
                            i = Instruction.from_reader(r)
                            instar_else.append(i)
                            if i.code == convention.end:
                                break
                    o.immediate_arguments = [rt, instar, instar_else]
                else:
                    while True:
                        i = Instruction.from_reader(r)
                        instar.append(i)
                        if i.code == convention.end:
                            break
                    o.immediate_arguments = [rt, instar]
            elif code in [convention.br, convention.br_if]:
                # seems unnecessary to be handled separately
                pass
            elif code == convention.br_table:
                n = common.read_count(r, 32)
                a = [common.read_count(r, 32) for _ in range(n)]
                b = common.read_count(r, 32)
                o.immediate_arguments = [a, b]
            elif code == convention.call:
                funcidx = common.read_count(r, 32)
                o.immediate_arguments = funcidx
            elif code == convention.call_indirect:
                typeidx = common.read_count(r, 32)
                # In future versions of WebAssembly, the zero byte occurring in the encoding of the call_indirect
                # instruction may be used to index additional tables.
                if r.read(1) != 0x00:
                    log.println("pywasm: zero byte malformed in call_indirect")
                o.immediate_arguments = typeidx
            else:
                log.panicln('pywasm: invalid code size')
        else:
            log.panicln('pywasm: invalid code size')
        return o


class Expression:
    # Function bodies, initialization values for globals, and offsets of element or data segments are given as
    # expressions, which are sequences of instructions terminated by an end marker.
    #
    # expr ::= instr∗ end
    #
    # In some places, validation restricts expressions to be constant, which limits the set of allowable instructions.
    def __init__(self):
        self.data: typing.List[Instruction] = []

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Expression()
        while True:
            i = Instruction.from_reader(r)
            if not i:
                break
            o.data.append(i)
        return o


class Locals:
    # The locals declare a vector of mutable local variables and their types. These variables are referenced through
    # local indices in the function’s body. The index of the first local is the smallest index not referencing a
    # parameter.
    #
    # locals ::= n:u32 t:valtype ⇒ tn
    def __init__(self):
        self.n: int
        self.valtype: int

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Locals()
        o.n = common.read_count(r, 32)
        o.valtype = ord(r.read(1))
        return o


# code ::= size:u32 code:func ⇒ code(ifsize=||func||)
# func ::= (t∗)∗:vec(locals) e:expr ⇒ concat((t∗)∗), e∗(if|concat((t∗)∗)|<232)
# locals ::= n:u32 t:valtype⇒tn

class Function:
    # The funcs component of a module defines a vector of functions with the following structure:
    #
    # func ::= {type typeidx, locals vec(valtype), body expr}
    def __init__(self):
        self.locals: typing.List[int] = []
        self.expr: Expression

    def __repr__(self):
        return f'locals={self.locals}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Function()
        n = common.read_count(r, 32)
        n = common.read_count(r, 32)
        for _ in range(n):
            n = common.read_count(r, 32)
            valtype = ord(r.read(1))
            o.locals.extend([valtype for _ in range(n)])
        o.expr = Expression.from_reader(r)
        return o


class Table:
    # The tables component of a module defines a vector of tables described by their table type:
    #
    # table ::= {type tabletype}
    def __init__(self):
        self.tabletype: TableType

    def __repr__(self):
        return f'{convention.elemtype[self.tabletype.elemtype][0]} {self.tabletype.limits}'

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
    def __init__(self):
        self.memtype: MemoryType

    def __repr__(self):
        return f'{self.memtype}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Memory()
        o.memtype = MemoryType.from_reader(r)
        return o


class Global:
    # The globals component of a module defines a vector of global variables (or globals for short):
    #
    # global ::= {type globaltype, init expr}
    def __init__(self):
        self.globaltype: GlobalType
        self.expr: Expression

    def __repr__(self):
        return f'{self.globaltype} expr={self.expr}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Global()
        o.globaltype = GlobalType.from_reader(r)
        o.expr = Expression.from_reader(r)
        return o


class ElementSegment:
    # The initial contents of a table is uninitialized. The elem component of a module defines a vector of element
    # segments that initialize a subrange of a table, at a given offset, from a static vector of elements.
    #
    # elem ::= {table tableidx, offset expr, init vec(funcidx)}
    #
    # The offset is given by a constant expression.
    def __init__(self):
        self.tableidx: int
        self.expr: Expression
        self.init: typing.List[int]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ElementSegment()
        o.tableidx = common.read_count(r, 32)
        o.expr = Expression.from_reader(r)
        n = common.read_count(r, 32)
        o.init = [common.read_count(r, 32) for _ in range(n)]
        return o


class DataSegment:
    # The initial contents of a memory are zero-valued bytes. The data component of a module defines a vector of data
    # segments that initialize a range of memory, at a given offset, with a static vector of bytes.
    #
    # data::={data memidx,offset expr,init vec(byte)}
    #
    # The offset is given by a constant expression.
    def __init__(self):
        self.memidx: int
        self.expr: Expression
        self.init: bytearray

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = DataSegment()
        o.memidx = common.read_count(r, 32)
        o.expr = Expression.from_reader(r)
        o.init = bytearray(common.read_bytes(r, 32))
        return o


class StartFunction:
    # The start component of a module declares the function index of a start function that is automatically invoked
    # when the module is instantiated, after tables and memories have been initialized.
    #
    # start ::= {func funcidx}
    def __init__(self):
        self.funcidx: int

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = StartFunction()
        o.funcidx = common.read_count(r, 32)
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
        self.name: str
        self.kind: int
        self.desc = None

    def __repr__(self):
        if self.kind == 0:
            return f'{self.name} -> Function[{self.desc}]'
        if self.kind == 1:
            return f'{self.name} -> Table[{self.desc}]'
        if self.kind == 2:
            return f'{self.name} -> Memory[{self.desc}]'
        if self.kind == 3:
            return f'{self.name} -> Global[{self.desc}]'
        return f'{self.name}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Export()
        o.name = common.read_bytes(r, 32).decode()
        o.kind = ord(r.read(1))
        o.desc = common.read_count(r, 32)
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
        self.module: str
        self.name: str
        self.kind: int
        self.desc = None

    def __repr__(self):
        if self.kind == 0:
            return f'{self.module}.{self.name} -> Function[{self.desc}]'
        if self.kind == 1:
            return f'{self.module}.{self.name} -> Table[{self.desc}]'
        if self.kind == 2:
            return f'{self.module}.{self.name} -> Memory[{self.desc}]'
        if self.kind == 3:
            return f'{self.module}.{self.name} -> Global[{self.desc}]'
        return f'{self.module}.{self.name}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Import()
        o.module = common.read_bytes(r, 32).decode()
        o.name = common.read_bytes(r, 32).decode()
        o.kind = ord(r.read(1))
        if o.kind == 0x00:
            o.desc = common.read_count(r, 32)
        elif o.kind == 0x01:
            o.desc = TableType.from_reader(r)
        elif o.kind == 0x02:
            o.desc = MemoryType.from_reader(r)
        elif o.kind == 0x03:
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

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TableSection()
        n = common.read_count(r, 32)
        o.vec = [Table.from_reader(r) for _ in range(n)]
        return o


class MemorySection:
    # The memory section has the id 5. It decodes into a vector of memories
    # that represent the mems component of a module.
    #
    # memsec ::= mem∗:section5(vec(mem)) ⇒ mem∗
    # mem ::= mt:memtype ⇒ {type mt}

    def __init__(self):
        self.vec: typing.List[Memory] = []

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = MemorySection()
        n = common.read_count(r, 32)
        o.vec = [Memory.from_reader(r) for _ in range(n)]
        return o


class GlobalSection:
    # The global section has the id 6. It decodes into a vector of globals
    # that represent the globals component of a module.
    #
    # globalsec ::= glob*:section6(vec(global)) ⇒ glob∗
    # global ::= gt:globaltype e:expr ⇒ {type gt, init e}

    def __init__(self):
        self.vec: typing.List[Global] = []

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = GlobalSection()
        n = common.read_count(r, 32)
        o.vec = [Global.from_reader(r) for _ in range(n)]
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
        self.vec: typing.List[Export] = []

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ExportSection()
        n = common.read_count(r, 32)
        o.vec = [Export.from_reader(r) for _ in range(n)]
        return o


class StartSection:
    # The start section has the id 8. It decodes into an optional start
    # function that represents the start component of a module.
    #
    # startsec ::= st?:section8(start) ⇒ st?
    # start ::= x:funcidx ⇒ {func x}

    def __init__(self):
        self.start_function: StartFunction

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = StartSection()
        o.start_function = StartFunction.from_reader(r)
        return o


class ElementSection:
    # The element section has the id 9. It decodes into a vector of element
    # segments that represent the elem component of a module.
    #
    # elemsec ::= seg∗:section9(vec(elem)) ⇒ seg
    # elem ::= x:tableidx e:expr y∗:vec(funcidx) ⇒ {table x, offset e, init y∗}
    def __init__(self):
        self.vec: typing.List[ElementSegment]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = ElementSection()
        n = common.read_count(r, 32)
        o.vec = [ElementSegment.from_reader(r) for _ in range(n)]
        return o


class CodeSection:
    # The code section has the id 10. It decodes into a vector of code
    # entries that are pairs of value type vectors and expressions. They
    # represent the locals and body field of the functions in the funcs
    # component of a module. The type fields of the respective functions are
    # encoded separately in the function section.
    #
    # The encoding of each code entry consists of
    #     1. the u32 size of the function code in bytes,
    #     2. the actual function code, which in turn consists of
    #         1. the declaration of locals,
    #         2. the function body as an expression.
    #
    # Local declarations are compressed into a vector whose entries consist of
    #     1. a u32 count,
    #     2. a value type,
    #
    # denoting count locals of the same value type.
    #
    # codesec ::= code∗:section10(vec(code)) ⇒ code∗
    # code ::= size:u32 code:func ⇒ code(ifsize=||func||)
    # func ::= (t∗)∗:vec(locals) e:expr ⇒ concat((t∗)∗), e∗(if|concat((t∗)∗)|<232)
    # locals ::= n:u32 t:valtype⇒tn
    def __init__(self):
        self.vec: typing.List[Function] = []

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = CodeSection()
        n = common.read_count(r, 32)
        o.vec = [Function.from_reader(r) for _ in range(n)]
        return o


class DataSection:
    # The data section has the id 11. It decodes into a vector of data
    # segments that represent the data component of a module.
    #
    # datasec ::= seg∗:section11(vec(data)) ⇒ seg
    # data ::= x:memidx e:expr b∗:vec(byte) ⇒ {data x,offset e,init b∗}
    def __init__(self):
        self.vec: typing.List[DataSegment] = []

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = DataSection()
        n = common.read_count(r, 32)
        o.vec = [DataSegment.from_reader(r) for _ in range(n)]
        return o


class Module:
    def __init__(self):
        self.custom_section: CustomSection = None
        self.type_section: TypeSection = None
        self.import_section: ImportSection = None
        self.function_section: FunctionSection = None
        self.table_section: TableSection = None
        self.memory_section: MemorySection = None
        self.global_section: GlobalSection = None
        self.export_section: ExportSection = None
        self.start_section: StartFunction = None
        self.element_section: ElementSection = None
        self.code_section: CodeSection = None
        self.data_section: DataSection = None

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
        log.debugln()
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
                for i, e in enumerate(mod.type_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] {e}')
            elif section_id == convention.import_section:
                mod.import_section = ImportSection.from_reader(io.BytesIO(data))
                for i, e in enumerate(mod.import_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] {e}')
            elif section_id == convention.function_section:
                mod.function_section = FunctionSection.from_reader(io.BytesIO(data))
                for i, e in enumerate(mod.function_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] sig={e}')
            elif section_id == convention.table_section:
                mod.table_section = TableSection.from_reader(io.BytesIO(data))
                for i, e in enumerate(mod.table_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] {e}')
            elif section_id == convention.memory_section:
                mod.memory_section = MemorySection.from_reader(io.BytesIO(data))
                for i, e in enumerate(mod.memory_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] {e}')
            elif section_id == convention.global_section:
                mod.global_section = GlobalSection.from_reader(io.BytesIO(data))
                for i, e in enumerate(mod.global_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] {e}')
            elif section_id == convention.export_section:
                mod.export_section = ExportSection.from_reader(io.BytesIO(data))
                for i, e in enumerate(mod.export_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] {e}')
            elif section_id == convention.start_section:
                mod.start_section = StartSection.from_reader(io.BytesIO(data))
                log.debugln(mod.start_section)
            elif section_id == convention.element_section:
                mod.element_section = ElementSection.from_reader(io.BytesIO(data))
                log.debugln(mod.element_section)
            elif section_id == convention.code_section:
                mod.code_section = CodeSection.from_reader(io.BytesIO(data))

                def printex(instrs: typing.List[Instruction], prefix=0):
                    preblc = ' ' * prefix
                    for e in instrs:
                        a = f'           | {preblc}{convention.opcodes[e.code][0]}'
                        if e.immediate_arguments is None:
                            log.debugln(f'{a}')
                        elif e.code in [convention.block, convention.loop, convention.if_]:
                            log.debugln(f'{a}')
                            printex(e.immediate_arguments[1], prefix + 2)
                            if e.code == convention.if_ and len(e.immediate_arguments) == 3:
                                log.debugln(' ' * (prefix - 2) + 'else')
                                printex(e.immediate_arguments[2], prefix + 2)
                        elif isinstance(e.immediate_arguments, list):
                            log.debugln(f'{a} {" ".join(e.immediate_arguments)}')
                        else:
                            log.debugln(f'{a} {e.immediate_arguments}')
                for i, e in enumerate(mod.code_section.vec):
                    log.debugln(f'{convention.section[section_id][0]:>9}[{i}] {e}')
                    printex(e.expr.data)
            elif section_id == convention.data_section:
                mod.data_section = DataSection.from_reader(io.BytesIO(data))
                log.debugln(mod.data_section)
            else:
                log.panicln('pywasm: invalid section id')