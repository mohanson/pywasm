import io
import typing

import wasmi.common
import wasmi.log
import wasmi.opcodes
import wasmi.stack
import wasmi.section


class Mod:
    def __init__(self):
        self.version: int
        self.sections: typing.List[wasmi.section.Section] = []

        # self.section_unknown: SectionUnknown = None
        self.section_type: wasmi.section.SectionType = None
        # self.section_import: SectionImport = None
        self.section_function: wasmi.section.SectionFunction = None
        # self.section_table: SectionTable = None
        # self.section_memory: SectionMemory = None
        # self.section_global: SectionGlobal = None
        self.section_export: wasmi.section.SectionExport = None
        # self.section_start: SectionStart = None
        # self.section_element: SectionElement = None
        self.section_code: wasmi.section.SectionCode = None
        # self.section_data: SectionData = None

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        mod = Mod()
        mag = wasmi.common.read_u32(r)
        if mag != 0x6d736100:
            wasmi.log.panicln('wasmi: invalid magic number')
        ver = mag = wasmi.common.read_u32(r)
        mod.version = ver
        for _ in range(1 << 32):
            try:
                sec = wasmi.section.Section.from_reader(r)
            except Exception as e:
                break
            else:
                wasmi.log.println(sec)
                mod.sections.append(sec)
        for e in mod.sections:
            if e.sid == wasmi.opcodes.SECTION_ID_UNKNOWN:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_TYPE:
                mod.section_type = wasmi.section.SectionType.from_section(e)
                wasmi.log.println(mod.section_type)
            if e.sid == wasmi.opcodes.SECTION_ID_IMPORT:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_FUNCTION:
                mod.section_function = wasmi.section.SectionFunction.from_section(e)
                wasmi.log.println(mod.section_function)
            if e.sid == wasmi.opcodes.SECTION_ID_TABLE:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_MEMORY:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_GLOBAL:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_EXPORT:
                mod.section_export = wasmi.section.SectionExport.from_section(e)
                wasmi.log.println(mod.section_export)
            if e.sid == wasmi.opcodes.SECTION_ID_START:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_ELEMENT:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_CODE:
                mod.section_code = wasmi.section.SectionCode.from_section(e)
                wasmi.log.println(mod.section_code)
            if e.sid == wasmi.opcodes.SECTION_ID_DATA:
                pass
        return mod


class Vm:
    def __init__(self, mod: Mod):
        self.mod = mod
        self.stack = wasmi.stack.Stack()

    def exec_i(self, i: int, data: typing.List):
        function = self.mod.section_function.entries[i]
        function_signature = self.mod.section_type.entries[function]
        function_body = self.mod.section_code.entries[function]
        code = function_body.code
        for idx, e in enumerate(data):
            data[idx] = wasmi.stack.Entry.from_val(e, function_signature.args[idx])
        pc = 0
        for _ in range(1 << 32):
            opcode = code[pc]
            pc += 1
            if opcode == wasmi.opcodes.GET_LOCAL:
                n, i = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                self.stack.add(data[i])
                continue
            if opcode == wasmi.opcodes.I32_ADD:
                a = self.stack.pop_i32()
                b = self.stack.pop_i32()
                self.stack.add_i32(a + b)
                continue
            if opcode == wasmi.opcodes.END:
                data = self.stack.pop()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_I32:
                    return data.into_i32()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_I64:
                    return data.into_i64()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_F32:
                    return data.into_f32()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_F64:
                    return data.into_f64()
                raise NotImplementedError
