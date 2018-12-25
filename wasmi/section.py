import io
import typing

import wasmi.common


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
        self.entries: typing.List[wasmi.types.FunctionSig] = []

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
            fsig = FunctionSig(form, args, rets)
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


# class SectionTable:
#     def __init__(self, father: Section):
#         self.father = father


# class SectionMemory:
#     def __init__(self, father: Section):
#         self.father = father


# class SectionGlobal:
#     def __init__(self, father: Section):
#         self.father = father


class SectionExport:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[ExportEntry] = []

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
            sec.entries.append(ExportEntry(name, kind, idx))
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
        self.entries: typing.List[FunctionBody] = []

    def __repr__(self):
        name = 'SectionCode'
        seps = []
        seps.append(f'entries={[str(e) for e in self.entries]}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_section(cls, f: Section):
        sec = SectionCode(f)
        r = io.BytesIO(f.raw)
        _, n_func = wasmi.common.read_u32_leb128(r)
        for _ in range(n_func):
            funcbody: FunctionBody
            localvar: typing.List[LocalEntry] = []
            _, n = wasmi.common.read_u32_leb128(r)
            full = r.read(n)
            r = io.BytesIO(full)
            _, n_vars = wasmi.common.read_u32_leb128(r)
            for _ in range(n_vars):
                e = LocalEntry.from_reader(r)
                localvar.append(e)
            code = r.read(-1)
            funcbody = FunctionBody(localvar, code)
            sec.entries.append(funcbody)
        return sec


# class SectionData:
#     def __init__(self, father: Section):
#         self.father = father


class FunctionSig:
    def __init__(self, form: int, args: bytes, rets: bytes):
        self.form = form
        self.args = args
        self.rets = rets

    def __repr__(self):
        name = 'FunctionSigature'
        seps = []
        seps.append(f'form={hex(self.form)}')
        seps.append(f'args=0x{self.args.hex()}')
        seps.append(f'rets=0x{self.rets.hex()}')
        return f'{name}<{" ".join(seps)}>'


class ExportEntry:
    def __init__(self, name: str, kind: int, idx: int):
        self.name = name
        self.kind = kind
        self.idx = idx

    def __repr__(self):
        name = 'ExportEntry'
        seps = []
        seps.append(f'name={self.name}')
        seps.append(f'kind={self.kind}')
        seps.append(f'idx={self.idx}')
        return f'{name}<{" ".join(seps)}>'


class LocalEntry:
    def __init__(self, count: int, kind: int):
        self.count = count
        self.kind = kind

    def __repr__(self):
        name = 'LocalEntry'
        seps = []
        seps.append(f'count={self.count}')
        seps.append(f'kind={self.kind}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        _, n_locals = wasmi.common.read_u32_leb128(r)
        kind = ord(r.read(1))
        return LocalEntry(n_locals, kind)


class FunctionBody:
    def __init__(self, locale: typing.List[LocalEntry], code: bytes):
        self.locale = locale
        self.code = code

    def __repr__(self):
        name = 'FunctionBody'
        seps = []
        seps.append(f'locale={[str(e) for e in self.locale]}')
        seps.append(f'code=0x{self.code.hex()}')
        return f'{name}<{" ".join(seps)}>'
