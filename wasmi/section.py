import io
import typing

import wasmi.common
import wasmi.error
import wasmi.spec.external
import wasmi.spec.op
import wasmi.spec.section
import wasmi.spec.valtype


class Limits:
    """Limits are encoded with a preceding flag indicating whether a maximum
    is present.

    limits ::= 0x00  n:u32        ⇒ {min n,max ϵ}
             | 0x01  n:u32  m:u32 ⇒ {min n,max m}
    """

    def __init__(self, flag: int, minimum: int, maximum: int):
        self.flag = flag
        self.minimum = minimum
        self.maximum = maximum

    def __repr__(self):
        if self.flag:
            return f'Limits<minimum={self.minimum} maximum={self.maximum}>'
        return f'Limits<minimum={self.minimum} maximum=inf>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        flag = ord(r.read(1))
        minimum = wasmi.common.read_leb(r, 32)[1]
        if flag == 1:
            maximum = wasmi.common.read_leb(r, 32)[1]
            return Limits(flag, minimum, maximum)
        return Limits(flag, minimum, 0)


class Expression:
    """Expressions are encoded by their instruction sequence terminated with
    an explicit 0x0B opcode for end.

    expr ::= (in:instr)∗ 0x0B ⇒ in∗ end
    """

    def __init__(self, data: bytearray):
        self.data = data

    def __repr__(self):
        return f'Expression<data={self.data.hex()}>'

    @classmethod
    def skip(cls, opcode: int, r: typing.BinaryIO):
        data = bytearray()
        for e in wasmi.spec.op.info[opcode][1]:
            if e == 'leb_1':
                a = wasmi.common.read_leb(r, 1)[2]
                data.extend(a)
                continue
            if e == 'leb_7':
                a = wasmi.common.read_leb(r, 7)[2]
                data.extend(a)
                continue
            if e == 'leb_32':
                a = wasmi.common.read_leb(r, 32)[2]
                data.extend(a)
                continue
            if e == 'leb_64':
                a = wasmi.common.read_leb(r, 64)[2]
                data.extend(a)
                continue
            if e == 'bit_32':
                a = r.read(4)
                data.extend(a)
                continue
            if e == 'bit_64':
                a = r.read(8)
                data.extend(a)
                continue
            if e == 'leb_32xleb_32':
                _, c, a = wasmi.common.read_leb(r, 64)
                data.extend(a)
                for _ in range(c):
                    a = wasmi.common.read_leb(r, 64)[2]
                    data.extend(a)
                continue
        return data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        data = bytearray()
        d = 1
        for _ in range(1 << 32):
            op = ord(r.read(1))
            data.append(op)
            if op in [wasmi.spec.op.BLOCK, wasmi.spec.op.LOOP, wasmi.spec.op.IF]:
                d += 1
            if op == wasmi.spec.op.END:
                d -= 1
                if not d:
                    break
            data.extend(cls.skip(op, r))
        return Expression(data)


class FuncType:
    """Function types are encoded by the byte 0x60 followed by the respective
    vectors of parameter and result types.

    functype ::= 0x60 t1∗:vec(valtype) t2∗:vec(valtype) ⇒ [t1∗] → [t2∗]
    """

    def __init__(self, args: typing.List[int], rets: typing.List[int]):
        self.args = args
        self.rets = rets

    def __repr__(self):
        args = [wasmi.spec.valtype.info[i] for i in self.args]
        rets = [wasmi.spec.valtype.info[i] for i in self.rets]
        return f'FuncType<args={args} rets={rets}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        assert ord(r.read(1)) == 0x60
        n = wasmi.common.read_leb(r, 32)[1]
        args = r.read(n)
        n = wasmi.common.read_leb(r, 32)[1]
        rets = r.read(n)
        return FuncType(list(args), list(rets))


class GlobalType:
    """Global types are encoded by their value type and a flag for their
    mutability.

    globaltype ::= t:valtype m:mut ⇒ m t
    mut ::= 0x00 ⇒ const
          | 0x01 ⇒ var
    """

    def __init__(self, valtype: int, mut: int):
        self.valtype = valtype
        self.mut = mut

    def __repr__(self):
        return f'GlobalType<valtype={wasmi.spec.valtype.info[self.valtype]} mut={self.mut}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        valtype = ord(r.read(1))
        mut = ord(r.read(1))
        return GlobalType(valtype, mut)


class Global:
    """
    global ::= gt:globaltype e:expr ⇒ {type gt, init e}
    """

    def __init__(self, globaltype: GlobalType, expr: Expression):
        self.globaltype = globaltype
        self.expr = expr

    def __repr__(self):
        return f'Global<globaltype={self.globaltype} expr={self.expr}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        globaltype = GlobalType.from_reader(r)
        expr = Expression.from_reader(r)
        return Global(globaltype, expr)


class Export:
    """The exports component of a module defines a set of exports that become
    accessible to the host environment once the module has been instantiated.

    export ::= {name name, desc exportdesc}
    exportdesc ::= func funcidx
                 | table tableidx
                 | mem memidx
                 | global globalidx

    Each export is labeled by a unique name. Exportable definitions are
    functions, tables, memories, and globals, which are referenced through
    a respective descriptor.
    """

    def __init__(self, kind: int, name: str, idx: int):
        self.kind = kind
        self.name = name
        self.idx = idx

    def __repr__(self):
        return f'Export<kind={wasmi.spec.external.info[self.kind]} name={self.name} idx={self.idx}>'


class Locals:
    """
    locals ::= n:u32 t:valtype ⇒ tn
    """

    def __init__(self, n: int, valtype: int):
        self.n = n
        self.valtype = valtype

    def __repr__(self):
        return f'Locals<n={self.n} valtype={self.valtype}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        n = wasmi.common.read_leb(r, 32)[1]
        valtype = ord(r.read(1))
        return Locals(n, valtype)


class Block:
    def __init__(self, opcode, kind, pos_head):
        self.opcode = opcode  # block opcode (0x00 for init_expr)
        self.kind = kind  # valtype
        self.pos_head = pos_head
        self.pos_stop = 0
        self.pos_else = 0
        self.pos_br = 0

    def __repr__(self):
        name = 'Block'
        seps = []
        seps.append(f'opcode={wasmi.spec.op.info[self.opcode][0]}')
        seps.append(f'kind={wasmi.spec.valtype.info[self.kind]}')
        seps.append(f'pos_head={self.pos_head}')
        seps.append(f'pos_stop={self.pos_stop}')
        seps.append(f'pos_else={self.pos_else}')
        seps.append(f'pos_br={self.pos_br}')
        return f'{name}<{" ".join(seps)}>'


class Code:
    """The funcs component of a module defines a vector of functions with the
    following structure:

    func ::= {type typeidx, locals vec(valtype), body expr}
    """

    def __init__(self, locs: typing.List[int], expr: Expression):
        self.locals = locs
        self.expr = expr

        self.bmap = self.imap()
        self.pos_br = len(self.expr.data) - 1

    def __repr__(self):
        return f'Code<locals={self.locals} expr={self.expr}>'

    def imap(self) -> typing.Dict[int, Block]:
        pc = 0
        bmap: typing.Dict[int, Block] = {}
        bstack: typing.List[Block] = []
        code = self.expr.data
        for _ in range(1 << 32):
            op = code[pc]
            pc += 1
            if op >= wasmi.spec.op.BLOCK and op <= wasmi.spec.op.IF:
                b = Block(op, code[pc], pc - 1)
                bstack.append(b)
                bmap[pc - 1] = b
                data = Expression.skip(op, io.BytesIO(code[pc:]))
                pc += len(data)
                continue
            if op == wasmi.spec.op.ELSE:
                if bstack[-1].opcode != wasmi.spec.op.IF:
                    raise wasmi.error.WAException('else not matched with if')
                bstack[-1].pos_else = pc
                bmap[bstack[-1].pos_head].pos_else = pc
                continue
            if op == wasmi.spec.op.END:
                if pc == len(code):
                    break
                b = bstack.pop()
                if b.opcode == wasmi.spec.op.LOOP:
                    b.pos_stop = pc - 1
                    b.pos_br = b.pos_head + 2
                    continue
                b.pos_stop = pc - 1
                b.pos_br = pc - 1
                continue
            data = Expression.skip(op, io.BytesIO(code[pc:]))
            pc += len(data)
        if op != wasmi.spec.op.END:
            raise wasmi.error.WAException('function block did not end with 0xb')
        if bstack:
            raise wasmi.error.WAException('function ended in middle of block')
        return bmap

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        n = wasmi.common.read_leb(r, 32)[1]
        n = wasmi.common.read_leb(r, 32)[1]
        locs = [Locals.from_reader(r) for _ in range(n)]
        expr = Expression.from_reader(r)
        return Code(locs, expr)


class Data:
    """The initial contents of a memory are zero-valued bytes. The data
    component of a module defines a vector of data segments that initialize
    a range of memory, at a given offset, with a static vector of bytes.

    data ::= {data memidx, offset expr, init vec(byte)}

    The offset is given by a constant expression.

    Note: In the current version of WebAssembly, at most one memory is allowed
    in a module. Consequently, the only valid memidx is 0.
    """

    def __init__(self, memidx: int, expr: Expression, init: bytearray):
        self.memidx = memidx
        self.expr = expr
        self.init = init

    def __repr__(self):
        return f'Data<memidx={self.memidx} expr={self.expr} init={self.init.hex()}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        memidx = wasmi.common.read_leb(r, 32)[1]
        expr = Expression.from_reader(r)
        n = wasmi.common.read_leb(r, 32)[1]
        init = r.read(n)
        return Data(memidx, expr, bytearray(init))


class Table:
    """Table types are encoded with their limits and a constant byte indicating
    their element type.

    tabletype ::= et:elemtype lim:limits ⇒ lim et
    elemtype ::= 0x70 ⇒ funcref
    """

    def __init__(self, elemtype: int, limits: Limits):
        self.elemtype = elemtype
        self.limits = limits

    def __repr__(self):
        return f'Table<elemtype={wasmi.spec.valtype.info[self.elemtype]} limits={self.limits}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        elemtype = ord(r.read(1))
        limits = Limits.from_reader(r)
        return Table(elemtype, limits)


class Memory:
    """Memory types are encoded with their limits.

    memtype ::= lim:limits ⇒ lim
    """

    def __init__(self, limits: Limits):
        self.limits = limits

    def __repr__(self):
        return f'Memory<limits={self.limits}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        limits = Limits.from_reader(r)
        return Memory(limits)


class Import:
    """The imports component of a module defines a set of imports that are
    required for instantiation.

    import ::= {module name, name name, desc importdesc}
    importdesc ::= func typeidx
                 | table tabletype
                 | mem memtype
                 | global globaltype

    Each import is labeled by a two-level name space, consisting of a module
    name and a name for an entity within that module. Importable definitions
    are functions, tables, memories, and globals. Each import is specified by
    a descriptor with a respective type that a definition provided during
    instantiation is required to match. Every import defines an index in the
    respective index space. In each index space, the indices of imports go
    before the first index of any definition contained in the module itself.
    """

    def __init__(self, kind: int, module: str, name: str):
        self.kind = kind
        self.module = module
        self.name = name
        self.desc = None

    def __repr__(self):
        return f'Import<kind={self.kind} module={self.module} name={self.name} desc={self.desc}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        n = wasmi.common.read_leb(r, 32)[1]
        module = r.read(n).decode()
        n = wasmi.common.read_leb(r, 32)[1]
        name = r.read(n).decode()
        kind = ord(r.read(1))
        sec = Import(kind, module, name)
        if kind == wasmi.spec.external.FUNCTION:
            n = wasmi.common.read_leb(r, 32)[1]
            sec.desc = n
        if kind == wasmi.spec.external.TABLE:
            sec.desc = Table.from_reader(r)
        if kind == wasmi.spec.external.MEMORY:
            sec.desc = Memory.from_reader(r)
        if kind == wasmi.spec.external.GLOBAL:
            sec.desc = GlobalType.from_reader(r)
        return sec


class Element:
    """The initial contents of a table is uninitialized. The elem component
    of a module defines a vector of element segments that initialize a subrange
    of a table, at a given offset, from a static vector of elements.

    elem ::= {table tableidx, offset expr, init vec(funcidx)}

    The offset is given by a constant expression.

    Note: In the current version of WebAssembly, at most one table is allowed in a module.
    Consequently, the only valid tableidx is 0.
    """

    def __init__(self, tableidx: int, expr: Expression, init: typing.List[int]):
        self.tableidx = tableidx
        self.expr = expr
        self.init = init

    def __repr__(self):
        return f'Element<tableidx={self.tableidx} expr={self.expr} init={self.init}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        tableidx = wasmi.common.read_leb(r, 32)[1]
        expr = Expression.from_reader(r)
        n = wasmi.common.read_leb(r, 32)[1]
        init = []
        for _ in range(n):
            e = wasmi.common.read_leb(r, 32)[1]
            init.append(e)
        return Element(tableidx, expr, init)


class Section:
    """Each section consists of
    1. a one-byte section id
    2. the u32 size of the contents, in bytes
    3. the actual contents, whose structure is depended on the section id
    """

    def __init__(self):
        self.section_id: int
        self.contents: bytearray

    def __repr__(self):
        return f'Section<section_id={self.section_id} contents={self.contents.hex()}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        section_id = wasmi.common.read_leb(r, 32)[1]
        n = wasmi.common.read_leb(r, 32)[1]
        contents = r.read(n)
        sec = Section()
        sec.section_id = section_id
        sec.contents = bytearray(contents)
        return sec


class SectionCustom:
    """Custom sections have the id 0. They are intended to be used for debugging
    information or third-party extensions, and are ignored by the WebAssembly
    semantics. Their contents consist of a name further identifying the custom
    section, followed by an uninterpreted sequence of bytes for custom use.

    customsec ::= section0(custom)
    custom ::= name byte∗
    """

    def __init__(self):
        self.name: str = None
        self.data: bytearray = None

    def __repr__(self):
        return f'SectionCustom<name={self.name} data={self.data}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionCustom()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        sec.name = r.read(n).decode()
        sec.data = bytearray(r.read(-1))
        return sec


class SectionType:
    """The type section has the id 1. It decodes into a vector of function
    types that represent the types component of a module.

    typesec ::= ft∗:section1(vec(functype)) ⇒ ft∗
    """

    def __init__(self):
        self.entries: typing.List[FuncType] = []

    def __repr__(self):
        return f'SectionType<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionType()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = FuncType.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionImport:
    """The import section has the id 2. It decodes into a vector of imports
    that represent the imports component of a module.

    importsec ::= im∗:section2(vec(import)) ⇒ im∗
    import ::= mod:name nm:name d:importdesc ⇒ {module mod, name nm, desc d}
    importdesc ::= 0x00 x:typeidx ⇒ func x
                 | 0x01 tt:tabletype ⇒ table tt
                 | 0x02 mt:memtype ⇒ mem mt
                 | 0x03 gt:globaltype ⇒ global gt
    """

    def __init__(self):
        self.entries: typing.List[Import] = []

    def __repr__(self):
        return f'SectionImport<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionImport()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = Import.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionFunction:
    """The function section has the id 3. It decodes into a vector of type
    indices that represent the type fields of the functions in the funcs
    component of a module. The locals and body fields of the respective
    functions are encoded separately in the code section.

    funcsec ::= x∗:section3(vec(typeidx)) ⇒ x∗
    """

    def __init__(self):
        self.entries: typing.List[int] = []

    def __repr__(self):
        return f'SectionFunction<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionFunction()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            _, e, _ = wasmi.common.read_leb(r, 32)
            sec.entries.append(e)
        return sec


class SectionTable:
    """The table section has the id 4. It decodes into a vector of tables that
    represent the tables component of a module.

    tablesec ::= tab∗:section4(vec(table)) ⇒ tab∗
    table ::= tt:tabletype ⇒ {type tt}
    """

    def __init__(self):
        self.entries: typing.List[Table] = []
        self.dict = {}

    def __repr__(self):
        return f'SectionTable<entries={self.entries} dict={self.dict}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionTable()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = Table.from_reader(r)
            sec.entries.append(e)
            sec.dict[e.elemtype] = [0] * e.limits.minimum
        return sec


class SectionMemory:
    """The memory section has the id 5. It decodes into a vector of memories
    that represent the mems component of a module.

    memsec ::= mem∗:section5(vec(mem)) ⇒ mem∗
    mem ::= mt:memtype ⇒ {type mt}
    """

    def __init__(self):
        self.entries: typing.List[Memory] = []

    def __repr__(self):
        return f'SectionMemory<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionMemory()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = Memory.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionGlobal:
    """The global section has the id 6. It decodes into a vector of globals
    that represent the globals component of a module.

    globalsec ::= glob*:section6(vec(global)) ⇒ glob∗
    global ::= gt:globaltype e:expr ⇒ {type gt, init e}
    """

    def __init__(self):
        self.entries: typing.List[Global] = []

    def __repr__(self):
        return f'SectionGlobal<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionGlobal()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = Global.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionExport:
    """The export section has the id 7. It decodes into a vector of exports
    that represent the exports component of a module.

    exportsec ::= ex∗:section7(vec(export)) ⇒ ex∗
    export :: =nm:name d:exportdesc ⇒ {name nm, desc d}
    exportdesc ::= 0x00 x:funcidx ⇒ func x
                 | 0x01 x:tableidx ⇒ table x
                 | 0x02 x:memidx ⇒ mem x
                 | 0x03 x:globalidx⇒global x
    """

    def __init__(self):
        self.entries: typing.List[Export] = []

    def __repr__(self):
        return f'SectionExport<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionExport()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            n = wasmi.common.read_leb(r, 32)[1]
            name = r.read(n).decode()
            kind = ord(r.read(1))
            n = wasmi.common.read_leb(r, 32)[1]
            sec.entries.append(Export(kind, name, n))
        return sec


class SectionStart:
    """The start section has the id 8. It decodes into an optional start
    function that represents the start component of a module.

    startsec ::= st?:section8(start) ⇒ st?
    start ::= x:funcidx ⇒ {func x}
    """

    def __init__(self):
        self.funcidx: int

    def __repr__(self):
        return f'SectionStart<funcidx={self.funcidx}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionStart()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        sec.funcidx = n
        return sec


class SectionElement:
    """The element section has the id 9. It decodes into a vector of element
    segments that represent the elem component of a module.

    elemsec ::= seg∗:section9(vec(elem)) ⇒ seg
    elem ::= x:tableidx e:expr y∗:vec(funcidx) ⇒ {table x, offset e, init y∗}
    """

    def __init__(self):
        self.entries: typing.List[Element] = []

    def __repr__(self):
        return f'SectionElement<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionElement()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = Element.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionCode:
    """The code section has the id 10. It decodes into a vector of code
    entries that are pairs of value type vectors and expressions. They
    represent the locals and body field of the functions in the funcs
    component of a module. The type fields of the respective functions are
    encoded separately in the function section.

    The encoding of each code entry consists of
        1. the u32 size of the function code in bytes,
        2. the actual function code, which in turn consists of
            1. the declaration of locals,
            2. the function body as an expression.

    Local declarations are compressed into a vector whose entries consist of
        1. a u32 count,
        2. a value type,

    denoting count locals of the same value type.

    codesec ::= code∗:section10(vec(code)) ⇒ code∗
    code ::= size:u32 code:func ⇒ code(ifsize=||func||)
    func ::= (t∗)∗:vec(locals) e:expr ⇒ concat((t∗)∗), e∗(if|concat((t∗)∗)|<232)
    locals ::= n:u32 t:valtype⇒tn
    """

    def __init__(self):
        self.entries: typing.List[Code] = []

    def __repr__(self):
        return f'SectionCode<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionCode()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = Code.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionData:
    """The data section has the id 11. It decodes into a vector of data
    segments that represent the data component of a module.

    datasec ::= seg∗:section11(vec(data)) ⇒ seg
    data ::= x:memidx e:expr b∗:vec(byte) ⇒ {data x,offset e,init b∗}
    """

    def __init__(self):
        self.entries: typing.List[Data] = []

    def __repr__(self):
        return f'SectionData<entries={self.entries}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionData()
        r = io.BytesIO(f.contents)
        n = wasmi.common.read_leb(r, 32)[1]
        for _ in range(n):
            e = Data.from_reader(r)
            sec.entries.append(e)
        return sec
