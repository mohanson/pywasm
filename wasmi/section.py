import io
import typing

import wasmi.common

# -----------------------------------------------------------------------------
# Binary Format Types
#
# See https://www.w3.org/TR/wasm-core-1/#binary-format①
# -----------------------------------------------------------------------------


class Limit:
    def __init__(self, flag: int, initial: int, maximum: int):
        self.flag = flag
        self.initial = initial
        self.maximum = maximum

    def __repr__(self):
        name = 'Limit'
        seps = []
        seps.append(f'flag={self.flag}')
        seps.append(f'initial={self.initial}')
        seps.append(f'maximum={self.maximum}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        flag = ord(r.read(1))
        _, initial, _ = wasmi.common.read_leb(r, 32)
        if flag == 1:
            maximum, _, _ = wasmi.common.read_leb(r, 32)
        else:
            maximum = 0
        return Limit(flag, initial, maximum)


class Expression:
    def __init__(self, data: bytearray):
        self.data = data

    def __repr__(self):
        name = 'Expression'
        seps = []
        seps.append(f'data=0x{self.data.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def skip(cls, opcode: int, r: typing.BinaryIO):
        data = bytearray()
        c = 0
        for e in wasmi.opcodes.OP_INFO[opcode][1]:
            if e == 0x01:
                data.extend(r.read(1))
                continue
            if e == 0x20:
                _, c, a = wasmi.common.read_leb(r, 32)
                data.extend(a)
                continue
            if e == 0x40:
                _, c, a = wasmi.common.read_leb(r, 64)
                data.extend(a)
                continue
            if e == 0xFF:
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


class Type:
    def __init__(self, form: int, args: bytearray, rets: bytearray):
        self.form = form
        self.args = args
        self.rets = rets

    def __repr__(self):
        name = 'Type'
        seps = []
        seps.append(f'form={hex(self.form)}')
        seps.append(f'args=0x{self.args.hex()}')
        seps.append(f'rets=0x{self.rets.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        form = ord(r.read(1))
        _, n_args, _ = wasmi.common.read_leb(r, 32)
        args = r.read(n_args)
        _, n_rets, _ = wasmi.common.read_leb(r, 32)
        rets = r.read(n_rets)
        return Type(form, bytearray(args), bytearray(rets))


class GlobalType:
    def __init__(self, kind: int, mut: int):
        self.kind = kind
        self.mut = mut

    def __repr__(self):
        name = 'GlobalType'
        seps = []
        seps.append(f'kind={self.kind}')
        seps.append(f'mut={self.mut}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        kind = ord(r.read(1))
        mut = ord(r.read(1))
        return GlobalType(kind, mut)


class Global:
    def __init__(self, kind: GlobalType, expression: Expression):
        self.kind = kind
        self.expression = expression

    def __repr__(self):
        name = 'Global'
        seps = []
        seps.append(f'kind={self.kind}')
        seps.append(f'expression={self.expression}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        kind = GlobalType.from_reader(r)
        expression = Expression.from_reader(r)
        return Global(kind, expression)


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
    def __init__(self, locs: typing.List[Local], expression: Expression):
        self.locs = locs
        self.expression = expression
        self.bmap = self.imap()

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
    def __init__(self, idx: int, expression: Expression, init: bytearray):
        self.idx = idx
        self.expression = expression
        self.init = init

    def __repr__(self):
        name = 'Data'
        seps = []
        seps.append(f'idx={self.idx}')
        seps.append(f'expression={self.expression}')
        seps.append(f'init=0x{self.init.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, idx, _ = wasmi.common.read_leb(r, 32)
        expression = Expression.from_reader(r)
        _, n, _ = wasmi.common.read_leb(r, 32)
        init = r.read(n)
        return Data(idx, expression, bytearray(init))


class Table:
    def __init__(self, kind: int, limit: Limit):
        self.kind = kind
        self.limit = limit

    def __repr__(self):
        name = 'Table'
        seps = []
        seps.append(f'kind={wasmi.opcodes.OP_INFO[self.kind][0]}')
        seps.append(f'limit={self.limit}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        kind = ord(r.read(1))
        limit = Limit.from_reader(r)
        return Table(kind, limit)


class Memory:
    def __init__(self, limit: Limit):
        self.limit = limit

    def __repr__(self):
        name = 'Memory'
        seps = []
        seps.append(f'limit={self.limit}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        limit = Limit.from_reader(r)
        return Memory(limit)


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
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, n, _ = wasmi.common.read_leb(r, 32)
        module = r.read(n).decode()
        _, n, _ = wasmi.common.read_leb(r, 32)
        name = r.read(n).decode()
        kind = ord(r.read(1))
        r = Import(kind, module, name)
        if kind == wasmi.opcodes.EXTERNAL_FUNCTION:
            _, idx, _ = wasmi.common.read_leb(r, 32)
            r.description = idx
        if kind == wasmi.opcodes.EXTERNAL_TABLE:
            r.description = Table.from_reader(r)
        if kind == wasmi.opcodes.EXTERNAL_MEMORY:
            r.description = Memory.from_reader(r)
        if kind == wasmi.opcodes.EXTERNAL_GLOBAL:
            r.description = Global.from_reader(r)
        return r


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
        init = [ord(e) for e in r.read(n)]
        return Element(idx, expression, init)


# -----------------------------------------------------------------------------
# Binary Format Section
# -----------------------------------------------------------------------------


class Section:
    def __init__(self):
        self.sid: int
        self.raw: bytearray

    def __repr__(self):
        name = 'Section'
        seps = []
        seps.append(f'sid={wasmi.opcodes.SECTION_NAME[self.sid]}')
        seps.append(f'raw=0x{self.raw.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, section_sid, _ = wasmi.common.read_leb(r, 32)
        _, n_remain, _ = wasmi.common.read_leb(r, 32)
        section_raw = r.read(n_remain)
        sec = Section()
        sec.sid = section_sid
        sec.raw = bytearray(section_raw)
        return sec


class SectionUnknown:
    def __init__(self, father: Section):
        self.father = father
        self.name: str = None
        self.data: bytearray = None

    def __repr__(self):
        name = 'SectionUnknown'
        seps = []
        seps.append(f'name={self.name}')
        seps.append(f'data={self.data}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionUnknown(f)
        r = io.BytesIO(f.raw)
        _, n, _ = wasmi.common.read_leb(r, 32)
        sec.name = r.read(n).decode()
        sec.data = bytearray(r.read(-1))
        return sec


class SectionType:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Type] = []

    def __repr__(self):
        name = 'SectionType'
        seps = []
        seps.append(f'entries={",".join([str(e) for e in self.entries])}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionType(f)
        r = io.BytesIO(f.raw)
        _, n_func, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n_func):
            e = Type.from_reader(r)
            sec.entries.append(e)
        return sec


class SectionImport:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Import] = []

    def __repr__(self):
        name = 'SectionImport'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionImport(f)
        r = io.BytesIO(f.raw)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            sec.entries.append(Import.from_read(r))
        return sec


class SectionFunction:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[int] = []

    def __repr__(self):
        name = 'SectionFunction'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionFunction(f)
        r = io.BytesIO(f.raw)
        _, n_func, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n_func):
            _, i, _ = wasmi.common.read_leb(r, 32)
            sec.entries.append(i)
        return sec


class SectionTable:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Table] = []
        self.dict = {}

    def __repr__(self):
        name = 'SectionTable'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionTable(f)
        r = io.BytesIO(f.raw)
        _, n_table, _ = wasmi.common.read_leb(r, 32)
        assert n_table == 1
        for _ in range(n_table):
            table = Table.from_reader(r)
            sec.entries.append(table)
            sec.dict[table.kind] = table.limit.initial
        return sec


class SectionMemory:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Memory] = []

    def __repr__(self):
        name = 'SectionMemory'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionMemory(f)
        r = io.BytesIO(f.raw)
        _, n_memory, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n_memory):
            memory = Memory.from_reader(r)
            sec.entries.append(memory)
        return sec


class SectionGlobal:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Global] = []

    def __repr__(self):
        name = 'SectionGlobal'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionGlobal(f)
        r = io.BytesIO(f.raw)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            sec.entries.append(Global.from_reader(r))
        return sec


class SectionExport:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Export] = []

    def __repr__(self):
        name = 'SectionExport'
        seps = []
        seps.append(f'entries={",".join([str(e) for e in self.entries])}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionExport(f)
        r = io.BytesIO(f.raw)
        _, n_entry, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n_entry):
            _, n_name, _ = wasmi.common.read_leb(r, 32)
            name = r.read(n_name).decode()
            kind = ord(r.read(1))
            _, idx, _ = wasmi.common.read_leb(r, 32)
            sec.entries.append(Export(name, kind, idx))
        return sec


class SectionStart:
    def __init__(self, father: Section):
        self.father = father
        self.idx: int

    def __repr__(self):
        name = 'SectionStart'
        seps = []
        seps.append(f'idx={self.idx}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionStart(f)
        r = io.BytesIO(f.raw)
        _, idx, _ = wasmi.common.read_leb(r, 32)
        sec.idx = idx
        return sec


class SectionElement:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Element] = []

    def __repr__(self):
        name = 'SectionElement'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionElement(f)
        r = io.BytesIO(f.raw)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            element = Element.from_reader(r)
            sec.entries.append(element)
        return sec


class SectionCode:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Code] = []

    def __repr__(self):
        name = 'SectionCode'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionCode(f)
        r = io.BytesIO(f.raw)
        _, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            code = Code.from_reader(r)
            sec.entries.append(code)
        return sec


class SectionData:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Data] = []

    def __repr__(self):
        name = 'SectionData'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionData(f)
        r = io.BytesIO(f.raw)
        a, n, _ = wasmi.common.read_leb(r, 32)
        for _ in range(n):
            data = Data.from_reader(r)
            sec.entries.append(data)
        return sec
