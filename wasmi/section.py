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
        _, initial = wasmi.common.read_u32_leb128(r)
        maximum = wasmi.common.read_u32_leb128(r) if flag == 1 else 0
        return Limit(flag, initial, maximum)


class Expression:
    def __init__(self, data: bytes):
        self.data = data

    def __repr__(self):
        name = 'Expression'
        seps = []
        seps.append(f'data=0x{self.data.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        data = bytearray()
        for _ in range(1 << 32):
            b = r.read(1)
            if not b:
                break
            data.append(ord(b))
            if b == wasmi.opcodes.END:
                break
        return Expression(bytes(data))


class Type:
    def __init__(self, form: int, args: bytes, rets: bytes):
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
        seps.append(f'kind={self.kind}')
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
        _, count = wasmi.common.read_u32_leb128(r)
        kind = ord(r.read(1))
        return Local(count, kind)


class Code:
    def __init__(self, locs: typing.List[Local], expression: Expression):
        self.locs = locs
        self.expression = expression

    def __repr__(self):
        name = 'Code'
        seps = []
        seps.append(f'locs={self.locs}')
        seps.append(f'expression={self.expression}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, n = wasmi.common.read_u32_leb128(r)
        full = r.read(n)
        r = io.BytesIO(full)
        _, n = wasmi.common.read_u32_leb128(r)
        locs = [Local.from_reader(r) for _ in range(n)]
        expression = Expression.from_reader(r)
        return Code(locs, expression)


class Table:
    def __init__(self, kind: int, limit: Limit):
        self.kind = kind
        self.limit = limit

    def __repr__(self):
        name = 'Table'
        seps = []
        seps.append(f'kind={self.kind}')
        seps.append(f'limit={self.limit}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        kind = ord(r.read(1))
        limit = Limit.from_reader(r)
        return Table(kind, limit)


class Memory:
    def __init__(self, limit):
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

# -----------------------------------------------------------------------------
# Binary Format Section
# -----------------------------------------------------------------------------


class Section:
    def __init__(self):
        self.sid: int
        self.raw: bytes

    def __repr__(self):
        name = 'Section'
        seps = []
        seps.append(f'sid={hex(self.sid)}')
        seps.append(f'raw=0x{self.raw.hex()}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, section_sid = wasmi.common.read_u32_leb128(r)
        _, n_remain = wasmi.common.read_u32_leb128(r)
        section_raw = r.read(n_remain)
        sec = Section()
        sec.sid = section_sid
        sec.raw = section_raw
        return sec


class SectionUnknown:
    def __init__(self, father: Section):
        self.father = father


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
        _, n_func = wasmi.common.read_u32_leb128(r)
        for _ in range(n_func):
            form = ord(r.read(1))
            _, n_args = wasmi.common.read_u32_leb128(r)
            args = r.read(n_args)
            _, n_rets = wasmi.common.read_u32_leb128(r)
            rets = r.read(n_rets)
            fsig = Type(form, args, rets)
            sec.entries.append(fsig)
        return sec


# class ImportEntry:
#     def __init__(self, module: str, field: str, kind: int):
#         self.module = module
#         self.field = field
#         self.kind = kind
#         self.description = None


# class ImportDescriptionFunction:
#     def __init__(self, idx: int):
#         self.idx = idx


# class ImportDescriptionTable:
#     def __init__(self):
#         pass


# class ImportDescriptionMemory:
#     def __init__(self):
#         pass


# class ImportDescriptionGlobal:
#     def __init__(self):
#         pass


# class SectionImport:
#     def __init__(self, father: Section):
#         self.father = father
#         self.entries: typing.List[ImportEntry] = []
#         pos = 0

#         n, n_import = wasmi.common.decode_u32_leb128(self.father.raw[pos:])
#         pos += n
#         for _ in range(n_import):
#             n, n_name = wasmi.common.decode_u32_leb128(self.father.raw[pos:])
#             pos += n
#             name = self.father.raw[pos:pos + n_name].decode()
#             pos += n_name

#             n, n_field = wasmi.common.decode_u32_leb128(self.father.raw[pos:])
#             pos += n
#             field = self.father.raw[pos:pos + n_field].decode()
#             pos += n_field

#             kind = self.father.raw[pos]
#             pos += 1

#             if kind == wasmi.opcodes.EXTERNAL_FUNCTION:
#                 pass
#             if kind == wasmi.opcodes.EXTERNAL_TABLE:
#                 pass
#             if kind == wasmi.opcodes.EXTERNAL_MEMORY:
#                 pass
#             if kind == wasmi.opcodes.EXTERNAL_GLOBAL:
#                 pass


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
        _, n_func = wasmi.common.read_u32_leb128(r)
        for _ in range(n_func):
            _, i = wasmi.common.read_u32_leb128(r)
            sec.entries.append(i)
        return sec


class SectionTable:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[Table] = []

    def __repr__(self):
        name = 'SectionTable'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionTable(f)
        r = io.BytesIO(f.raw)
        _, n_table = wasmi.common.read_u32_leb128(r)
        for _ in range(n_table):
            table = Table.from_reader(r)
            sec.entries.append(table)
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
        _, n_memory = wasmi.common.read_u32_leb128(r)
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
        _, n = wasmi.common.read_u32_leb128(r)
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
        _, n_entry = wasmi.common.read_u32_leb128(r)
        for _ in range(n_entry):
            _, n_name = wasmi.common.read_u32_leb128(r)
            name = r.read(n_name).decode()
            kind = ord(r.read(1))
            _, idx = wasmi.common.read_u32_leb128(r)
            sec.entries.append(Export(name, kind, idx))
        return sec


# class SectionStart:
#     def __init__(self, father: Section):
#         self.father = father


# class SectionElement:
#     def __init__(self, father: Section):
#         self.father = father


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
        _, n = wasmi.common.read_u32_leb128(r)
        for _ in range(n):
            code = Code.from_reader(r)
            sec.entries.append(code)
        return sec

# class SectionData:
#     def __init__(self, father: Section):
#         self.father = father
