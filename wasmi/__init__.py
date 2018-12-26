import io
import itertools
import math
import typing

import wasmi.common
import wasmi.log
import wasmi.opcodes
import wasmi.stack
import wasmi.section
import wasmi.error

# -----------------------------------------------------------------------------
# About opcode description, see:
# https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md
# https://github.com/WebAssembly/design/blob/master/Semantics.md
# -----------------------------------------------------------------------------


class Mod:
    def __init__(self):
        self.version: int
        self.sections: typing.List[wasmi.section.Section] = []

        self.section_unknown: wasmi.section.SectionUnknown = None
        self.section_type: wasmi.section.SectionType = None
        self.section_import: wasmi.section.SectionImport = None
        self.section_function: wasmi.section.SectionFunction = None
        self.section_table: wasmi.section.SectionTable = None
        self.section_memory: wasmi.section.SectionMemory = None
        self.section_global: wasmi.section.SectionGlobal = None
        self.section_export: wasmi.section.SectionExport = None
        self.section_start: wasmi.section.SectionStart = None
        self.section_element: wasmi.section.SectionElement = None
        self.section_code: wasmi.section.SectionCode = None
        self.section_data: wasmi.section.SectionData = None

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        mod = Mod()
        mag = wasmi.common.read_u32(r)
        if mag != 0x6d736100:
            raise wasmi.error.InvalidMagicNumber
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
                mod.section_unknown = wasmi.section.SectionUnknown.from_section(e)
                wasmi.log.println(mod.section_unknown)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_TYPE:
                mod.section_type = wasmi.section.SectionType.from_section(e)
                wasmi.log.println(mod.section_type)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_IMPORT:
                mod.section_import = wasmi.section.SectionImport.from_section(e)
                wasmi.log.println(mod.section_import)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_FUNCTION:
                mod.section_function = wasmi.section.SectionFunction.from_section(e)
                wasmi.log.println(mod.section_function)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_TABLE:
                mod.section_table = wasmi.section.SectionTable.from_section(e)
                wasmi.log.println(mod.section_table)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_MEMORY:
                mod.section_memory = wasmi.section.SectionMemory.from_section(e)
                wasmi.log.println(mod.section_memory)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_GLOBAL:
                mod.section_global = wasmi.section.SectionGlobal.from_section(e)
                wasmi.log.println(mod.section_global)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_EXPORT:
                mod.section_export = wasmi.section.SectionExport.from_section(e)
                wasmi.log.println(mod.section_export)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_START:
                mod.section_start = wasmi.section.SectionStart.from_section(e)
                wasmi.log.println(mod.section_start)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_ELEMENT:
                mod.section_element = wasmi.section.SectionElement.from_section(e)
                wasmi.log.println(mod.section_element)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_CODE:
                mod.section_code = wasmi.section.SectionCode.from_section(e)
                wasmi.log.println(mod.section_code)
                continue
            if e.sid == wasmi.opcodes.SECTION_ID_DATA:
                mod.section_data = wasmi.section.SectionData.from_section(e)
                wasmi.log.println(mod.section_data)
                continue
        return mod


class Ctx:
    def __init__(self, data: typing.List[wasmi.stack.Entry]):
        self.stack = wasmi.stack.Stack()
        self.locals_data = data


class Vm:
    def __init__(self, mod: Mod):
        self.mod = mod
        self.mem = bytearray()
        if self.mod.section_memory and len(self.mod.section_memory.entries):
            if len(self.mod.section_memory.entries) > 1:
                raise wasmi.error.MultipleLinearMemories
            size = self.mod.section_memory.entries[0].limit.initial * 64 * 1024
            self.mem = bytearray([0 for _ in range(size)])
        self.global_data: typing.List[wasmi.stack.Entry] = []

    def exec(self, name: str, args: typing.List[wasmi.stack.Entry]):
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
        code = function_body.expression.data + chr(0x0f).encode()
        ctx = Ctx(args)
        pc = 0
        for _ in range(1 << 32):
            opcode = code[pc]
            pc += 1
            name = wasmi.opcodes.CODE_DICT.get(opcode, f'Invalid Opcode {opcode}')
            wasmi.log.println(name, ctx.stack.data)
            if opcode == wasmi.opcodes.UNREACHABLE:
                raise wasmi.error.Unreachable
            if opcode == wasmi.opcodes.NOP:
                continue
            if opcode == wasmi.opcodes.BLOCK:
                continue
            if opcode == wasmi.opcodes.LOOP:
                raise NotImplementedError
            if opcode == wasmi.opcodes.IF:
                raise NotImplementedError
            if opcode == wasmi.opcodes.ELSE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.END:
                continue
            if opcode == wasmi.opcodes.BR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.BR_IF:
                raise NotImplementedError
            if opcode == wasmi.opcodes.BR_TABLE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.RETURN:
                if not ctx.stack.len():
                    return 0
                data = ctx.stack.pop()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_I32:
                    return data.into_i32()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_I64:
                    return data.into_i64()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_F32:
                    return data.into_f32()
                if function_signature.rets[0] == wasmi.opcodes.VALUE_TYPE_F64:
                    return data.into_f64()
            if opcode == wasmi.opcodes.CALL:
                raise NotImplementedError
            if opcode == wasmi.opcodes.CALL_INDIRECT:
                raise NotImplementedError
            if opcode == wasmi.opcodes.DROP:
                ctx.stack.pop()
                continue
            if opcode == wasmi.opcodes.SELECT:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop()
                v3 = ctx.stack.pop()
                ctx.stack.add(v3 if v1 != 0 else v2)
                continue
            if opcode == wasmi.opcodes.GET_LOCAL:
                n, i = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.stack.add(ctx.locals_data[i])
                continue
            if opcode == wasmi.opcodes.SET_LOCAL:
                n, i = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.locals_data[i] = ctx.stack.pop()
                continue
            if opcode == wasmi.opcodes.TEE_LOCAL:
                n, i = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.locals_data[i] = ctx.stack.data[-1]
                continue
            if opcode == wasmi.opcodes.GET_GLOBAL:
                n, i = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.stack.add(self.global_data[i])
                continue
            if opcode == wasmi.opcodes.SET_GLOBAL:
                n, i = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                self.global_data[i] = ctx.stack.pop()
                continue
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
                n, r = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.stack.add_i32(r)
                continue
            if opcode == wasmi.opcodes.I64_CONST:
                n, r = wasmi.common.decode_u64_leb128(code[pc:])
                pc += n
                r = wasmi.common.into_i64(r)
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.F32_CONST:
                n, r = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F64_CONST:
                n, r = wasmi.common.decode_u64_leb128(code[pc:])
                pc += n
                ctx.stack.add_f64(r)
            if opcode == wasmi.opcodes.I32_EQZ:
                ctx.stack.add_i32(ctx.stack.pop_i32() == 0)
                continue
            if opcode == wasmi.opcodes.I32_EQ:
                ctx.stack.add_i32(ctx.stack.pop_i32() == ctx.stack.pop_i32())
                continue
            if opcode == wasmi.opcodes.I32_NE:
                ctx.stack.add_i32(ctx.stack.pop_i32() != ctx.stack.pop_i32())
                continue
            if opcode == wasmi.opcodes.I32_LTS:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 < v1)
                continue
            if opcode == wasmi.opcodes.I32_LTU:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_i32(v2 < v1)
                continue
            if opcode == wasmi.opcodes.I32_GTS:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 > v1)
                continue
            if opcode == wasmi.opcodes.I32_GTU:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_i32(v2 > v1)
                continue
            if opcode == wasmi.opcodes.I32_LES:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 <= v1)
                continue
            if opcode == wasmi.opcodes.I32_LEU:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_i32(v2 <= v1)
                continue
            if opcode == wasmi.opcodes.I32_GES:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 >= v1)
                continue
            if opcode == wasmi.opcodes.I32_GEU:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_i32(v2 >= v1)
                continue
            if opcode == wasmi.opcodes.I64_EQZ:
                ctx.stack.add_i64(ctx.stack.pop_i64() == 0)
                continue
            if opcode == wasmi.opcodes.I64_EQ:
                ctx.stack.add_i64(ctx.stack.pop_i64() == ctx.stack.pop_i64())
                continue
            if opcode == wasmi.opcodes.I64_NE:
                ctx.stack.add_i64(ctx.stack.pop_i64() != ctx.stack.pop_i64())
                continue
            if opcode == wasmi.opcodes.I64_LTS:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i32(v2 < v1)
                continue
            if opcode == wasmi.opcodes.I64_LTU:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_i32(v2 < v1)
                continue
            if opcode == wasmi.opcodes.I64_GTS:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i32(v2 > v1)
                continue
            if opcode == wasmi.opcodes.I64_GTU:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_i32(v2 > v1)
                continue
            if opcode == wasmi.opcodes.I64_LES:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i32(v2 <= v1)
                continue
            if opcode == wasmi.opcodes.I64_LEU:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_i32(v2 <= v1)
                continue
            if opcode == wasmi.opcodes.I64_GES:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i32(v2 >= v1)
                continue
            if opcode == wasmi.opcodes.I64_GEU:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_i32(v2 >= v1)
                continue
            if opcode == wasmi.opcodes.F32_EQ:
                ctx.stack.add_i32(ctx.stack.pop_f32() == ctx.stack.pop_f32())
                continue
            if opcode == wasmi.opcodes.F32_NE:
                ctx.stack.add_i32(ctx.stack.pop_f32() != ctx.stack.pop_f32())
                continue
            if opcode == wasmi.opcodes.F32_LT:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_i32(v2 < v1)
                continue
            if opcode == wasmi.opcodes.F32_GT:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_i32(v2 > v1)
                continue
            if opcode == wasmi.opcodes.F32_LE:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_i32(v2 <= v1)
                continue
            if opcode == wasmi.opcodes.F32_GE:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_i32(v2 >= v1)
                continue
            if opcode == wasmi.opcodes.F64_EQ:
                ctx.stack.add_i32(ctx.stack.pop_f64() == ctx.stack.pop_f64())
                continue
            if opcode == wasmi.opcodes.F64_NE:
                ctx.stack.add_i32(ctx.stack.pop_f64() != ctx.stack.pop_f64())
                continue
            if opcode == wasmi.opcodes.F64_LT:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_i32(v2 < v1)
                continue
            if opcode == wasmi.opcodes.F64_GT:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_i32(v2 > v1)
                continue
            if opcode == wasmi.opcodes.F64_LE:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_i32(v2 <= v1)
                continue
            if opcode == wasmi.opcodes.F64_GE:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_i32(v2 >= v1)
                continue
            if opcode == wasmi.opcodes.I32_CLZ:
                e = ctx.stack.pop().data[4:]
                c = sum(1 for _ in itertools.takewhile(lambda x: x == 0, e))
                ctx.stack.add_u64(c)
                continue
            if opcode == wasmi.opcodes.I32_CTZ:
                e = ctx.stack.pop().data[4:]
                c = sum(1 for _ in itertools.takewhile(lambda x: x == 0, e[::-1]))
                ctx.stack.add_u64(c)
                continue
            if opcode == wasmi.opcodes.I32_POPCNT:
                e = ctx.stack.pop().data[4:]
                r = sum([wasmi.common.POP_TAB[i] for i in e])
                ctx.stack.add_u64(c)
                continue
            if opcode == wasmi.opcodes.I32_ADD:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 + v1)
                continue
            if opcode == wasmi.opcodes.I32_SUB:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 - v1)
                continue
            if opcode == wasmi.opcodes.I32_MUL:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 * v1)
                continue
            if opcode == wasmi.opcodes.I32_DIVS:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 // v1)
                continue
            if opcode == wasmi.opcodes.I32_DIVU:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_u32(v2 // v1)
                continue
            if opcode == wasmi.opcodes.I32_REMS:
                v1 = ctx.stack.pop_i32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 % v1)
                continue
            if opcode == wasmi.opcodes.I32_REMU:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_u32(v2 % v1)
                continue
            if opcode == wasmi.opcodes.I32_AND:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_u32(v2 & v1)
                continue
            if opcode == wasmi.opcodes.I32_OR:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_u32(v2 | v1)
                continue
            if opcode == wasmi.opcodes.I32_XOR:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_u32(v2 ^ v1)
                continue
            if opcode == wasmi.opcodes.I32_SHL:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_u32(v2 << v1)
                continue
            if opcode == wasmi.opcodes.I32_SHRS:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_i32()
                ctx.stack.add_i32(v2 >> v1)
                continue
            if opcode == wasmi.opcodes.I32_SHRU:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                ctx.stack.add_u32(v2 >> v1)
                continue
            if opcode == wasmi.opcodes.I32_ROTL:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                r = wasmi.common.rotl_u32(v2, v1)
                ctx.stack.add_u32(r)
                continue
            if opcode == wasmi.opcodes.I32_ROTR:
                v1 = ctx.stack.pop_u32()
                v2 = ctx.stack.pop_u32()
                r = wasmi.common.rotr_u32(v2, v1)
                ctx.stack.add_u32(r)
                continue
            if opcode == wasmi.opcodes.I64_CTZ:
                e = ctx.stack.pop().data[4:]
                c = sum(1 for _ in itertools.takewhile(lambda x: x == 0, e[::-1]))
                ctx.stack.add_u64(c)
                continue
            if opcode == wasmi.opcodes.I64_POPCNT:
                e = ctx.stack.pop().data[4:]
                r = sum([wasmi.common.POP_TAB[i] for i in e])
                ctx.stack.add_u64(c)
                continue
            if opcode == wasmi.opcodes.I64_ADD:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i64(v2 + v1)
                continue
            if opcode == wasmi.opcodes.I64_SUB:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i64(v2 - v1)
                continue
            if opcode == wasmi.opcodes.I64_MUL:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i64(v2 * v1)
                continue
            if opcode == wasmi.opcodes.I64_DIVS:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i64(v2 // v1)
                continue
            if opcode == wasmi.opcodes.I64_DIVU:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_u64(v2 // v1)
                continue
            if opcode == wasmi.opcodes.I64_REMS:
                v1 = ctx.stack.pop_i64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i64(v2 % v1)
                continue
            if opcode == wasmi.opcodes.I64_REMU:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_u64(v2 % v1)
                continue
            if opcode == wasmi.opcodes.I64_AND:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_u64(v2 & v1)
                continue
            if opcode == wasmi.opcodes.I64_OR:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_u64(v2 | v1)
                continue
            if opcode == wasmi.opcodes.I64_XOR:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_u64(v2 ^ v1)
                continue
            if opcode == wasmi.opcodes.I64_SHL:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_u64(v2 << v1)
                continue
            if opcode == wasmi.opcodes.I64_SHRS:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_i64()
                ctx.stack.add_i64(v2 >> v1)
                continue
            if opcode == wasmi.opcodes.I64_SHRU:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                ctx.stack.add_u64(v2 >> v1)
                continue
            if opcode == wasmi.opcodes.I64_ROTL:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                r = wasmi.common.rotl_u64(v2, v1)
                ctx.stack.add_u64(r)
                continue
            if opcode == wasmi.opcodes.I64_ROTR:
                v1 = ctx.stack.pop_u64()
                v2 = ctx.stack.pop_u64()
                r = wasmi.common.rotr_u64(v2, v1)
                ctx.stack.add_u64(r)
                continue
            if opcode == wasmi.opcodes.F32_ABS:
                v = ctx.stack.pop_f32()
                r = v if v > 0 else -v
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_NEG:
                v = ctx.stack.pop_f32()
                r = -v
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_CEIL:
                v = ctx.stack.pop_f32()
                r = math.ceil(v)
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_FLOOR:
                v = ctx.stack.pop_f32()
                r = math.floor(v)
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_TRUNC:
                v = ctx.stack.pop_f32()
                r = math.trunc(v)
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_NEAREST:
                v = ctx.stack.pop_f32()
                ceil = math.ceil(v)
                if ceil - v >= 0.5:
                    r = ceil
                else:
                    r = ceil - 1
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_SQRT:
                v = ctx.stack.pop_f32()
                r = math.sqrt(v)
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_ADD:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_f32(v2 + v1)
                continue
            if opcode == wasmi.opcodes.F32_SUB:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_f32(v2 - v1)
                continue
            if opcode == wasmi.opcodes.F32_MUL:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_f32(v2 * v1)
                continue
            if opcode == wasmi.opcodes.F32_DIV:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_f32(v2 / v1)
                continue
            if opcode == wasmi.opcodes.F32_MIN:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_f32(min(v2, v1))
                continue
            if opcode == wasmi.opcodes.F32_MAX:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                ctx.stack.add_f32(max(v2, v1))
                continue
            if opcode == wasmi.opcodes.F32_COPYSIGN:
                v1 = ctx.stack.pop_f32()
                v2 = ctx.stack.pop_f32()
                r = math.copysign(v1, v2)
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F64_ABS:
                v = ctx.stack.pop_f64()
                r = v if v > 0 else -v
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_NEG:
                v = ctx.stack.pop_f64()
                r = -v
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_CEIL:
                v = ctx.stack.pop_f64()
                r = math.ceil(v)
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_FLOOR:
                v = ctx.stack.pop_f64()
                r = math.floor(v)
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_TRUNC:
                v = ctx.stack.pop_f64()
                r = math.trunc(v)
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_NEAREST:
                v = ctx.stack.pop_f64()
                ceil = math.ceil(v)
                if ceil - v >= 0.5:
                    r = ceil
                else:
                    r = ceil - 1
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_SQRT:
                v = ctx.stack.pop_f64()
                r = math.sqrt(v)
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_ADD:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_f64(v2 + v1)
                continue
            if opcode == wasmi.opcodes.F64_SUB:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_f64(v2 - v1)
                continue
            if opcode == wasmi.opcodes.F64_MUL:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_f64(v2 * v1)
                continue
            if opcode == wasmi.opcodes.F64_DIV:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_f64(v2 / v1)
                continue
            if opcode == wasmi.opcodes.F64_MIN:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_f64(min(v2, v1))
                continue
            if opcode == wasmi.opcodes.F64_MAX:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                ctx.stack.add_f64(max(v2, v1))
                continue
            if opcode == wasmi.opcodes.F64_COPYSIGN:
                v1 = ctx.stack.pop_f64()
                v2 = ctx.stack.pop_f64()
                r = math.copysign(v1, v2)
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.I32_WRAP_I64:
                r = ctx.stack.pop_i64()
                r = wasmi.common.into_i32(r)
                ctx.stack.add_i32(r)
                continue
            if opcode == wasmi.opcodes.I32_TRUNC_SF32:
                r = ctx.stack.pop_f32()
                r = math.trunc(r)
                r = wasmi.common.into_i32(r)
                ctx.stack.add_i32(r)
                continue
            if opcode == wasmi.opcodes.I32_TRUNC_UF32:
                r = ctx.stack.pop_f32()
                r = math.trunc(r)
                r = wasmi.common.into_i32(r)
                ctx.stack.add_i32(r)
                continue
            if opcode == wasmi.opcodes.I32_TRUNC_SF64:
                r = ctx.stack.pop_f64()
                r = math.trunc(r)
                r = wasmi.common.into_i32(r)
                ctx.stack.add_i32(r)
                continue
            if opcode == wasmi.opcodes.I32_TRUNC_UF64:
                r = ctx.stack.pop_f64()
                r = math.trunc(r)
                r = wasmi.common.into_i32(r)
                ctx.stack.add_i32(r)
                continue
            if opcode == wasmi.opcodes.I64_EXTEND_SI32:
                r = ctx.stack.pop_i32()
                r = wasmi.common.into_i64(r)
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.I64_EXTEND_UI32:
                r = ctx.stack.pop_u32()
                r = wasmi.common.into_i64(r)
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.I64_TRUNC_SF32:
                r = ctx.stack.pop_f32()
                r = math.trunc(r)
                r = wasmi.common.into_i64(r)
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.I64_TRUNC_UF32:
                r = ctx.stack.pop_f32()
                r = math.trunc(r)
                r = wasmi.common.into_i64(r)
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.I64_TRUNC_SF64:
                r = ctx.stack.pop_f64()
                r = math.trunc(r)
                r = wasmi.common.into_i64(r)
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.I64_TRUNC_UF64:
                r = ctx.stack.pop_f64()
                r = math.trunc(r)
                r = wasmi.common.into_i64(r)
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.F32_CONVERT_SI32:
                r = ctx.stack.pop_i32()
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_CONVERT_UI32:
                r = ctx.stack.pop_u32()
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_CONVERT_SI64:
                r = ctx.stack.pop_i64()
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_CONVERT_UI64:
                r = ctx.stack.pop_u64()
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F32_DEMOTE_F64:
                r = ctx.stack.pop_f64()
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F64_CONVERT_SI32:
                r = ctx.stack.pop_i32()
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_CONVERT_UI32:
                r = ctx.stack.pop_u32()
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_CONVERT_SI64:
                r = ctx.stack.pop_i64()
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_CONVERT_UI64:
                r = ctx.stack.pop_u64()
                ctx.stack.add_f64(r)
                continue
            if opcode == wasmi.opcodes.F64_PROMOTE_F32:
                ctx.stack.data[-1].kind = wasmi.opcodes.VALUE_TYPE_F64
                continue
            if opcode == wasmi.opcodes.I32_REINTERPRET_F32:
                ctx.stack.data[-1].kind = wasmi.opcodes.VALUE_TYPE_I32
                continue
            if opcode == wasmi.opcodes.I64_REINTERPRET_F64:
                ctx.stack.data[-1].kind = wasmi.opcodes.VALUE_TYPE_I64
                continue
            if opcode == wasmi.opcodes.F32_REINTERPRET_I32:
                ctx.stack.data[-1].kind = wasmi.opcodes.VALUE_TYPE_F32
                continue
            if opcode == wasmi.opcodes.F64_REINTERPRET_I64:
                ctx.stack.data[-1].kind = wasmi.opcodes.VALUE_TYPE_F64
                continue


# -----------------------------------------------------------------------------
# Export klasses
# -----------------------------------------------------------------------------
Entry = wasmi.stack.Entry
