import struct
import typing

import wasmi.log
import wasmi.opcodes
import wasmi.stack

MAGIC_NUMBER = 0x6d736100
VERSION = 0x1

SECTION_ID_UNKNOWN = 0
SECTION_ID_TYPE = 1
SECTION_ID_IMPORT = 2
SECTION_ID_FUNCTION = 3
SECTION_ID_TABLE = 4
SECTION_ID_MEMORY = 5
SECTION_ID_GLOBAL = 6
SECTION_ID_EXPORT = 7
SECTION_ID_START = 8
SECTION_ID_ELEMENT = 9
SECTION_ID_CODE = 10
SECTION_ID_DATA = 11


def get_u32(r: bytes):
    assert len(r) == 4
    return struct.unpack('<I', r)[0]


def get_u64(r: bytes):
    assert len(r) == 8
    return struct.unpack('<I', r)[0]


def get_u32_leb128(r: bytes):
    vmask = [0xffffff80, 0xffffc000, 0xffe00000, 0xf0000000, 0]
    bmask = [0x40, 0x40, 0x40, 0x40, 0x8]
    v = 0
    n = 0
    for _ in range(0, 5):
        b = r[n]
        tmp = b & 0x7f
        v = tmp << (n * 7) | v
        if (b & 0x80) != 0x80:
            if bmask[n] & tmp:
                v |= vmask[n]
            break
        n += 1
    if n == 4 and (tmp & 0xf0) != 0:
        return -1
    v = struct.unpack('i', struct.pack('I', v))[0]
    return n + 1, v


class Section:
    def __init__(self):
        self.id: int
        self.raw: bytes

    def __str__(self):
        name = 'Section'
        seps = []
        seps.append(f'id={hex(self.id)}')
        seps.append(f'raw=0x{self.raw.hex()}')
        return f'{name}<{" ".join(seps)}>'


class FunctionSigature:
    def __init__(self, form: int, args: bytes, rets: bytes):
        self.form = form
        self.args = args
        self.rets = rets

    def __str__(self):
        name = 'FunctionSigature'
        seps = []
        seps.append(f'form={hex(self.form)}')
        seps.append(f'args=0x{self.args.hex()}')
        seps.append(f'rets=0x{self.rets.hex()}')
        return f'{name}<{" ".join(seps)}>'


class SectionUnknown:
    def __init__(self, father: Section):
        self.father = father


class SectionType:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[FunctionSigature] = []
        pos = 0

        n, n_func = get_u32_leb128(self.father.raw[pos:])
        pos += n
        for _ in range(n_func):
            form = self.father.raw[pos]
            pos += 1
            n, n_args = get_u32_leb128(self.father.raw[pos:])
            pos += n
            args = self.father.raw[pos:pos + n_args]
            pos += n_args
            n, n_rets = get_u32_leb128(self.father.raw[pos:])
            pos += n
            rets = self.father.raw[pos:pos + n_rets]
            pos += n_rets
            fs = FunctionSigature(form, args, rets)
            self.entries.append(fs)

    def __str__(self):
        name = 'SectionType'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'


class SectionImport:
    def __init__(self, father: Section):
        self.father = father


class SectionFunction:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[int] = []
        pos = 0

        n, n_func = get_u32_leb128(self.father.raw[pos:])
        pos += n
        for _ in range(n_func):
            n, i = get_u32_leb128(self.father.raw[pos:])
            pos += n
            self.entries.append(i)

    def __str__(self):
        name = 'SectionFunction'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'


class SectionTable:
    def __init__(self, father: Section):
        self.father = father


class SectionMemory:
    def __init__(self, father: Section):
        self.father = father


class SectionGlobal:
    def __init__(self, father: Section):
        self.father = father


class ExportEntry:
    def __init__(self, name: str, i: int):
        self.name = name
        self.i = i

    def __str__(self):
        name = 'ExportEntry'
        seps = []
        seps.append(f'name={self.name}')
        seps.append(f'i={self.i}')
        return f'{name}<{" ".join(seps)}>'


class SectionExport:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[ExportEntry] = []
        pos = 0

        n, n_func = get_u32_leb128(self.father.raw[pos:])
        pos += n
        for _ in range(n_func):
            l = self.father.raw[pos]
            pos += 1
            name = self.father.raw[pos:pos + l].decode()
            pos += l
            _ = self.father.raw[pos]
            pos += 1
            i = self.father.raw[pos]
            pos += 1
            self.entries.append(ExportEntry(name, i))

    def __str__(self):
        name = 'SectionExport'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'


class SectionStart:
    def __init__(self, father: Section):
        self.father = father


class SectionElement:
    def __init__(self, father: Section):
        self.father = father


class FunctionBody:
    def __init__(self, body: bytes):
        self.body = body

    def __str__(self):
        name = 'FunctionBody'
        seps = []
        seps.append(f'body=0x{self.body.hex()}')
        return f'{name}<{" ".join(seps)}>'


class SectionCode:
    def __init__(self, father: Section):
        self.father = father
        self.entries: typing.List[FunctionBody] = []
        pos = 0

        n, n_func = get_u32_leb128(self.father.raw[pos:])
        pos += n
        for _ in range(n_func):
            n, l_func = get_u32_leb128(self.father.raw[pos:])
            pos += n
            body = self.father.raw[pos:pos + l_func]
            pos += l_func
            self.entries.append(FunctionBody(body))

    def __str__(self):
        name = 'SectionCode'
        seps = []
        seps.append(f'entries={self.entries}')
        return f'{name}<{" ".join(seps)}>'


class SectionData:
    def __init__(self, father: Section):
        self.father = father


class Mod:
    def __init__(self):
        self.version: int
        self.sections: typing.List[Section] = []

        self.section_unknown: SectionUnknown = None
        self.section_type: SectionType = None
        self.section_import: SectionImport = None
        self.section_function: SectionFunction = None
        self.section_table: SectionTable = None
        self.section_memory: SectionMemory = None
        self.section_global: SectionGlobal = None
        self.section_export: SectionExport = None
        self.section_start: SectionStart = None
        self.section_element: SectionElement = None
        self.section_code: SectionCode = None
        self.section_data: SectionData = None

        self.name

    @classmethod
    def from_byte(cls, r: bytes):
        mod = Mod()
        pos = 0
        assert len(r) >= 8
        mag = get_u32(r[pos: pos + 4])
        pos += 4
        if mag != MAGIC_NUMBER:
            wasmi.log.panicln('wasmi: invalid magic number')
        ver = get_u32(r[pos: pos + 4])
        pos += 4
        mod.version = ver
        for _ in range(2 ** 32):
            try:
                n, section_id = get_u32_leb128(r[pos:])
                pos += n
                n, section_remain = get_u32_leb128(r[pos:])
                pos += n
                section_raw = r[pos:pos + section_remain]
                pos += len(section_raw)
                sec = Section()
                sec.id = section_id
                sec.raw = section_raw
                wasmi.log.println(sec)
                mod.sections.append(sec)
            except IndexError:
                break
        for e in mod.sections:
            if e.id == SECTION_ID_UNKNOWN:
                pass
            if e.id == SECTION_ID_TYPE:
                mod.section_type = SectionType(e)
                for f in mod.section_type.entries:
                    wasmi.log.println(f)
            if e.id == SECTION_ID_IMPORT:
                pass
            if e.id == SECTION_ID_FUNCTION:
                mod.section_function = SectionFunction(e)
                wasmi.log.println(mod.section_function)
            if e.id == SECTION_ID_TABLE:
                pass
            if e.id == SECTION_ID_MEMORY:
                pass
            if e.id == SECTION_ID_GLOBAL:
                pass
            if e.id == SECTION_ID_EXPORT:
                mod.section_export = SectionExport(e)
                for f in mod.section_export.entries:
                    wasmi.log.println(f)
            if e.id == SECTION_ID_START:
                pass
            if e.id == SECTION_ID_ELEMENT:
                pass
            if e.id == SECTION_ID_CODE:
                mod.section_code = SectionCode(e)
                for f in mod.section_code.entries:
                    wasmi.log.println(f)
            if e.id == SECTION_ID_DATA:
                pass
        return mod


class Interpreter:
    def __init__(self, code: bytes, data: typing.List[int]):
        self.code = code
        self.data = data
        self.stack = wasmi.stack.Stack()
        self.pc = 0
        self.dict = {}
        self.dict[wasmi.opcodes.I32_ADD] = self.opcode_i32_add
        self.dict[wasmi.opcodes.GET_LOCAL] = self.opcode_get_local
        self.dict[wasmi.opcodes.END] = self.opcode_end

    def exec(self):
        for _ in range(1 << 32):
            opcode = self.code[self.pc]
            self.pc += 1

    def opcode_i32_add(self):
        pass

    def opcode_get_local(self):
        data = self.code[self.pc:self.pc + 4]
        self.pc += 4
        i = get_u32(data)
        self.stack.push_u64(self.data[i])

    def opcode_end(self):
        self.stack.pop_u64()


class Vm:
    def __init__(self, mod: Mod):
        self.mod = mod

    def exec_i(self, i: int, data: typing.List[int]):
        function = self.mod.section_function.entries[i]
        function_signature = self.mod.section_type.entries[function]
        function_body = self.mod.section_code.entries[function]
        it = Interpreter(function_body, data)
        return it.exec()

    def exec(self, name: str, data: typing.List[int]):
        pass
