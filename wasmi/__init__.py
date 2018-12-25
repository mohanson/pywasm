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
        self.section_table: wasmi.section.SectionTable = None
        self.section_memory: wasmi.section.SectionMemory = None
        self.section_global: wasmi.section.SectionGlobal = None
        self.section_export: wasmi.section.SectionExport = None
        self.section_start: wasmi.section.SectionStart = None
        # self.section_element: SectionElement = None
        self.section_code: wasmi.section.SectionCode = None
        self.section_data: wasmi.section.SectionData = None

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
                mod.section_table = wasmi.section.SectionTable.from_section(e)
                wasmi.log.println(mod.section_table)
            if e.sid == wasmi.opcodes.SECTION_ID_MEMORY:
                mod.section_memory = wasmi.section.SectionMemory.from_section(e)
                wasmi.log.println(mod.section_memory)
            if e.sid == wasmi.opcodes.SECTION_ID_GLOBAL:
                mod.section_global = wasmi.section.SectionGlobal.from_section(e)
                wasmi.log.println(mod.section_global)
            if e.sid == wasmi.opcodes.SECTION_ID_EXPORT:
                mod.section_export = wasmi.section.SectionExport.from_section(e)
                wasmi.log.println(mod.section_export)
            if e.sid == wasmi.opcodes.SECTION_ID_START:
                mod.section_start = wasmi.section.SectionStart.from_section(e)
                wasmi.log.println(mod.section_start)
            if e.sid == wasmi.opcodes.SECTION_ID_ELEMENT:
                pass
            if e.sid == wasmi.opcodes.SECTION_ID_CODE:
                mod.section_code = wasmi.section.SectionCode.from_section(e)
                wasmi.log.println(mod.section_code)
            if e.sid == wasmi.opcodes.SECTION_ID_DATA:
                mod.section_data = wasmi.section.SectionData.from_section(e)
                wasmi.log.println(mod.section_data)
        return mod


class Vm:
    def __init__(self, mod: Mod):
        self.mod = mod
        self.stack = wasmi.stack.Stack()

    def exec(self, name: str, data: typing.List):
        export: wasmi.section.Export = None
        for e in self.mod.section_export.entries:
            if e.name == name:
                export = e
                break
        if not export:
            raise NotImplementedError
        function = self.mod.section_function.entries[export.idx]
        function_signature = self.mod.section_type.entries[function]
        function_body = self.mod.section_code.entries[export.idx]
        code = function_body.expression.data
        for idx, e in enumerate(data):
            data[idx] = wasmi.stack.Entry.from_val(e, function_signature.args[idx])
        pc = 0
        for _ in range(1 << 32):
            opcode = code[pc]
            pc += 1
            if opcode == wasmi.opcodes.UNREACHABLE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.NOP:
                raise NotImplementedError
            if opcode == wasmi.opcodes.BLOCK:
                raise NotImplementedError
            if opcode == wasmi.opcodes.LOOP:
                raise NotImplementedError
            if opcode == wasmi.opcodes.IF:
                raise NotImplementedError
            if opcode == wasmi.opcodes.ELSE:
                raise NotImplementedError
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
            if opcode == wasmi.opcodes.BR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.BR_IF:
                raise NotImplementedError
            if opcode == wasmi.opcodes.BR_TABLE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.RETURN:
                raise NotImplementedError
            if opcode == wasmi.opcodes.CALL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.CALL_INDIRECT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.DROP:
                raise NotImplementedError
            if opcode == wasmi.opcodes.SELECT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.GET_LOCAL:
                n, i = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                self.stack.add(data[i])
                continue
            if opcode == wasmi.opcodes.SET_LOCAL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.TEE_LOCAL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.GET_GLOBAL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.SET_GLOBAL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LOAD:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LOAD:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_LOAD:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_LOAD:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LOAD_8s:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LOAD_8u:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LOAD_16s:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LOAD_16u:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LOAD_8s:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LOAD_8u:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LOAD_16s:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LOAD_16u:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LOAD_32s:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LOAD_32u:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_STORE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_STORE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_STORE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_STORE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_STORE8:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_STORE16:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_STORE8:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_STORE16:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_STORE32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.CURRENT_MEMORY:
                raise NotImplementedError
            if opcode == wasmi.opcodes.GROW_MEMORY:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_CONST:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_CONST:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_CONST:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_CONST:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_EQZ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_EQ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_NE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LTS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LTU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_GTS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_GTU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LES:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_LEU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_GES:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_GEU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_EQZ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_EQ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_NE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LTS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LTU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_GTS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_GTU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LES:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_LEU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_GES:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_GEU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_EQ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_NE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_LT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_GT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_LE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_GE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_EQ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_NE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_LT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_GT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_LE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_GE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_CLZ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_CTZ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_POPCNT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_ADD:
                v2 = self.stack.pop_i32()
                v1 = self.stack.pop_i32()
                self.stack.add_i32(v1 + v2)
                continue
            if opcode == wasmi.opcodes.I32_SUB:
                v2 = self.stack.pop_i32()
                v1 = self.stack.pop_i32()
                self.stack.add_i32(v1 - v2)
                continue
            if opcode == wasmi.opcodes.I32_MUL:
                v2 = self.stack.pop_i32()
                v1 = self.stack.pop_i32()
                self.stack.add_i32(v1 * v2)
                continue
            if opcode == wasmi.opcodes.I32_DIVS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_DIVU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_REMS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_REMU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_AND:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_OR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_XOR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_SHL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_SHRS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_SHRU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_ROTL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_ROTR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_CLZ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_CTZ:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_POPCNT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_ADD:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_SUB:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_MUL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_DIVS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_DIVU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_REMS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_REMU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_AND:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_OR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_XOR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_SHL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_SHRS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_SHRU:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_ROTL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_ROTR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_ABS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_NEG:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_CEIL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_FLOOR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_TRUNC:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_NEAREST:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_SQRT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_ADD:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_SUB:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_MUL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_DIV:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_MIN:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_MAX:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_COPYSIGN:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_ABS:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_NEG:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_CEIL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_FLOOR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_TRUNC:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_NEAREST:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_SQRT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_ADD:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_SUB:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_MUL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_DIV:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_MIN:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_MAX:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_COPYSIGN:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_WRAP_I64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_TRUNC_SF32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_TRUNC_UF32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_TRUNC_SF64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_TRUNC_UF64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_EXTEND_SI32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_EXTEND_UI32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_TRUNC_SF32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_TRUNC_UF32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_TRUNC_SF64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_TRUNC_UF64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_CONVERT_SI32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_CONVERT_UI32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_CONVERT_SI64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_CONVERT_UI64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_DEMOTE_F64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_CONVERT_SI32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_CONVERT_UI32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_CONVERT_SI64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_CONVERT_UI64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_PROMOTE_F32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I32_REINTERPRET_F32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.I64_REINTERPRET_F64:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F32_REINTERPRET_I32:
                raise NotImplementedError
            if opcode == wasmi.opcodes.F64_REINTERPRET_I64:
                raise NotImplementedError
