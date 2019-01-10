import io
import typing

import wasmi.common
import wasmi.opcodes as opcodes


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
        name = 'Limits'
        seps = []
        seps.append(f'flag={self.flag}')
        seps.append(f'minimum={self.minimum}')
        seps.append(f'maximum={self.maximum}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        flag = ord(r.read(1))
        _, minimum, _ = wasmi.common.read_leb(r, 32)
        if flag == 1:
            _, maximum, _ = wasmi.common.read_leb(r, 32)
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
        name = 'Expression'
        seps = []
        seps.append(f'data={self.data.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def skip(cls, opcode: int, r: typing.BinaryIO):
        data = bytearray()
        for e in wasmi.opcodes.OP_INFO[opcode][1]:
            if e == 'leb_1':
                _, _, a = wasmi.common.read_leb(r, 1)
                data.extend(a)
                continue
            if e == 'leb_7':
                _, _, a = wasmi.common.read_leb(r, 7)
                data.extend(a)
                continue
            if e == 'leb_32':
                _, _, a = wasmi.common.read_leb(r, 32)
                data.extend(a)
                continue
            if e == 'leb_64':
                _, _, a = wasmi.common.read_leb(r, 64)
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
                    _, _, a = wasmi.common.read_leb(r, 64)
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
            if op in [wasmi.opcodes.BLOCK, wasmi.opcodes.LOOP, wasmi.opcodes.IF]:
                d += 1
            if op == wasmi.opcodes.END:
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
        name = 'FuncType'
        seps = []
        seps.append(f'args={[opcodes.VALUE_TYPE_NAME[i] for i in self.args]}')
        seps.append(f'rets={[opcodes.VALUE_TYPE_NAME[i] for i in self.rets]}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        assert ord(r.read(1)) == 0x60
        _, n, _ = wasmi.common.read_leb(r, 32)
        args = r.read(n)
        _, n, _ = wasmi.common.read_leb(r, 32)
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
        name = 'GlobalType'
        seps = []
        seps.append(f'valtype={wasmi.opcodes.VALUE_TYPE_NAME[self.valtype]}')
        seps.append(f'mut={self.mut}')
        return f'{name}<{" ".join(seps)}>'

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
        name = 'Global'
        seps = []
        seps.append(f'globaltype={self.globaltype}')
        seps.append(f'expr={self.expr}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        globaltype = GlobalType.from_reader(r)
        expr = Expression.from_reader(r)
        return Global(globaltype, expr)


class Export:
    def __init__(self, name: str, kind: int, idx: int):
        self.name = name
        self.kind = kind
        self.idx = idx

    def __repr__(self):
        name = 'Export'
        seps = []
        seps.append(f'name={self.name}')
        seps.append(f'kind={wasmi.opcodes.EXTERNAL_NAME[self.kind]}')
        seps.append(f'idx={self.idx}')
        return f'{name}<{" ".join(seps)}>'


class Local:
    def __init__(self, count: int, kind: int):
        self.count = count
        self.kind = kind

    def __repr__(self):
        name = 'Local'
        seps = []
        seps.append(f'count={self.count}')
        seps.append(f'kind={self.kind}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, count, _ = wasmi.common.read_leb(r, 32)
        kind = ord(r.read(1))
        return Local(count, kind)


class Block:
    def __init__(self, opcode, kind, pos_head):
        self.opcode = opcode  # block opcode (0x00 for init_expr)
        self.kind = kind  # value_type
        self.pos_head = pos_head
        self.pos_stop = 0
        self.pos_else = 0
        self.pos_br = 0

    def __repr__(self):
        name = 'Block'
        seps = []
        seps.append(f'opcode={wasmi.opcodes.OP_INFO[self.opcode][0]}')
        seps.append(f'kind={wasmi.opcodes.VALUE_TYPE_NAME[self.kind]}')
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

    def __init__(self, locs: typing.List[Local], expression: Expression):
        self.locs = locs
        self.expression = expression
        self.bmap = self.imap()
        self.pos_br = len(self.expression.data) - 1

    def __repr__(self):
        name = 'Code'
        seps = []
        seps.append(f'locs={self.locs}')
        seps.append(f'expression={self.expression}')
        seps.append(f'bmap={self.bmap}')
        return f'{name}<{" ".join(seps)}>'

    def imap(self) -> typing.Dict[int, Block]:
        pc = 0
        bmap: typing.Dict[int, Block] = {}
        bstack: typing.List[Block] = []
        code = self.expression.data
        for _ in range(1 << 32):
            op = code[pc]
            pc += 1
            if op >= wasmi.opcodes.BLOCK and op <= wasmi.opcodes.IF:
                b = Block(op, code[pc], pc - 1)
                bstack.append(b)
                bmap[pc - 1] = b
                data = Expression.skip(op, io.BytesIO(code[pc:]))
                pc += len(data)
                continue
            if op == wasmi.opcodes.ELSE:
                if bstack[-1].opcode != wasmi.opcodes.IF:
                    raise wasmi.error.WAException('else not matched with if')
                bstack[-1].pos_else = pc
                bmap[bstack[-1].pos_head].pos_else = pc
                continue
            if op == wasmi.opcodes.END:
                if pc == len(code):
                    break
                b = bstack.pop()
                if b.opcode == wasmi.opcodes.LOOP:
                    b.pos_stop = pc - 1
                    b.pos_br = b.pos_head + 2
                    continue
                b.pos_stop = pc - 1
                b.pos_br = pc - 1
                continue
            data = Expression.skip(op, io.BytesIO(code[pc:]))
            pc += len(data)
        if op != wasmi.opcodes.END:
            raise wasmi.error.WAException('function block did not end with 0xb')
        if bstack:
            raise wasmi.error.WAException('function ended in middle of block')
        return bmap

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, n, _ = wasmi.common.read_leb(r, 32)
        full = r.read(n)
        r = io.BytesIO(full)
        _, n, _ = wasmi.common.read_leb(r, 32)
        locs = [Local.from_reader(r) for _ in range(n)]
        expression = Expression.from_reader(r)
        return Code(locs, expression)


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
        name = 'Data'
        seps = []
        seps.append(f'memidx={self.memidx}')
        seps.append(f'expr={self.expr}')
        seps.append(f'init={self.init.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, memidx, _ = wasmi.common.read_leb(r, 32)
        expr = Expression.from_reader(r)
        _, n, _ = wasmi.common.read_leb(r, 32)
        init = r.read(n)
        return Data(memidx, expr, bytearray(init))


class Table:
    def __init__(self, kind: int, limits: Limits):
        self.kind = kind
        self.limits = limits

    def __repr__(self):
        name = 'Table'
        seps = []
        seps.append(f'kind={wasmi.opcodes.VALUE_TYPE_NAME[self.kind]}')
        seps.append(f'limits={self.limits}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        kind = ord(r.read(1))
        limits = Limits.from_reader(r)
        return Table(kind, limits)


class Memory:
    """Memory types are encoded with their limits.

    memtype ::= lim:limits ⇒ lim
    """

    def __init__(self, limits: Limits):
        self.limits = limits

    def __repr__(self):
        name = 'Memory'
        seps = []
        seps.append(f'limits={self.limits}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        limits = Limits.from_reader(r)
        return Memory(limits)


class Import:
    def __init__(self, kind: int, module: str, name: str):
        self.kind = kind
        self.module = module
        self.name = name
        self.description = None

    def __repr__(self):
        name = 'Import'
        seps = []
        seps.append(f'kind={self.kind}')
        seps.append(f'module={self.module}')
        seps.append(f'name={self.name}')
        seps.append(f'description={self.description}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, n, _ = wasmi.common.read_leb(r, 32)
        module = r.read(n).decode()
        _, n, _ = wasmi.common.read_leb(r, 32)
        name = r.read(n).decode()
        kind = ord(r.read(1))
        isec = Import(kind, module, name)
        if kind == wasmi.opcodes.EXTERNAL_FUNCTION:
            _, idx, _ = wasmi.common.read_leb(r, 32)
            isec.description = idx
        if kind == wasmi.opcodes.EXTERNAL_TABLE:
            isec.description = Table.from_reader(r)
        if kind == wasmi.opcodes.EXTERNAL_MEMORY:
            isec.description = Memory.from_reader(r)
        if kind == wasmi.opcodes.EXTERNAL_GLOBAL:
            isec.description = GlobalType.from_reader(r)
        return isec


class Element:
    def __init__(self, idx: int, expression: Expression, init: typing.List[int]):
        self.idx = idx
        self.expression = expression
        self.init = init

    def __repr__(self):
        name = 'Element'
        seps = []
        seps.append(f'idx={self.idx}')
        seps.append(f'expression={self.expression}')
        seps.append(f'init={self.init}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, idx, _ = wasmi.common.read_leb(r, 32)
        expression = Expression.from_reader(r)
        _, n, _ = wasmi.common.read_leb(r, 32)
        init = []
        for _ in range(n):
            init.append(wasmi.common.read_leb(r, 32)[1])
        return Element(idx, expression, init)


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
        name = 'Section'
        seps = []
        seps.append(f'section_id={wasmi.opcodes.SECTION_NAME[self.section_id]}')
        seps.append(f'contents={self.contents.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, section_id, _ = wasmi.common.read_leb(r, 32)
        _, n, _ = wasmi.common.read_leb(r, 32)
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
        name = 'SectionCustom'
        seps = []
        seps.append(f'name={self.name}')
        seps.append(f'data={self.data}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionCustom()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
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
        name = 'SectionType'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionType()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            e = FuncType.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionImport:
    def __init__(self):
        self.entries: typing.List[Import] = []

    def __repr__(self):
        name = 'SectionImport'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionImport()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
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
        name = 'SectionFunction'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionFunction()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            _, e, _ = wasmi.common.read_leb(r, 32)
            sec.entries.append(e)
        return sec


class SectionTable:
    def __init__(self):
        self.entries: typing.List[Table] = []
        self.dict = {}

    def __repr__(self):
        name = 'SectionTable'
        seps = []
        seps.append(f'entries={self.entries}')
        seps.append(f'dict={self.dict}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionTable()
        r = io.BytesIO(f.contents)
        _, n_table, _ = wasmi.common.read_leb(r, 32)
        assert n_table == 1
        for _ in range(n_table):
            table = Table.from_reader(r)
            sec.entries.append(table)
            sec.dict[table.kind] = [0] * table.limits.minimum
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
        name = 'SectionMemory'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionMemory()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
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
        name = 'SectionGlobal'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionGlobal()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            e = Global.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionExport:
    def __init__(self):
        self.entries: typing.List[Export] = []

    def __repr__(self):
        name = 'SectionExport'
        seps = []
        seps.append(f'entries={",".join([str(e) for e in self.entries])}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionExport()
        r = io.BytesIO(f.contents)
        _, n_entry, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n_entry):
            _, n_name, _ = wasmi.common.read_leb(r, 32)
            name = r.read(n_name).decode()
            kind = ord(r.read(1))
            _, idx, _ = wasmi.common.read_leb(r, 32)
            sec.entries.append(Export(name, kind, idx))
        return sec


class SectionStart:
    def __init__(self):
        self.idx: int

    def __repr__(self):
        name = 'SectionStart'
        seps = []
        seps.append(f'idx={self.idx}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionStart()
        r = io.BytesIO(f.contents)
        _, idx, _ = wasmi.common.read_leb(r, 32)
        sec.idx = idx
        return sec


class SectionElement:
    def __init__(self):
        self.entries: typing.List[Element] = []

    def __repr__(self):
        name = 'SectionElement'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionElement()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            e = Element.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionCode:
    def __init__(self):
        self.entries: typing.List[Code] = []

    def __repr__(self):
        name = 'SectionCode'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionCode()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
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
        name = 'SectionData'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionData()
        r = io.BytesIO(f.contents)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            e = Data.from_reader(r)
            sec.entries.append(e)
        return sec
