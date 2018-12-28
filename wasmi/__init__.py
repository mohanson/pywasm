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
        self.global_data: typing.List[wasmi.stack.Entry] = []
        self.mem = bytearray()
        self.mem_len = 0
        if self.mod.section_memory and self.mod.section_memory.entries:
            if len(self.mod.section_memory.entries) > 1:
                raise wasmi.error.MultipleLinearMemories
            self.mem_len = self.mod.section_memory.entries[0].limit.initial * 64 * 1024
            self.mem = bytearray([0 for _ in range(self.mem_len)])
        if self.mod.section_data:
            for e in self.mod.section_data.entries:
                assert e.idx == 0
                offset = self.exec_init_expr(e.expression.data)
                wasmi.log.println(f'VM.SetMem<offset={offset} init=0x{e.init.hex()}>')
                self.mem[offset: offset + len(e.init)] = e.init

    def exec_init_expr(self, code: bytearray):
        stack = wasmi.stack.Stack()
        if not code:
            raise wasmi.error.EmptyInitExpr
        pc = 0
        for _ in range(1 << 32):
            opcode = code[pc]
            pc += 1
            if opcode == wasmi.opcodes.I32_CONST:
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                stack.add_i32(i)
                continue
            if opcode == wasmi.opcodes.I64_CONST:
                n, i, _ = wasmi.common.decode_u64_leb128(code[pc:])
                pc += n
                stack.add_i64(i)
                continue
            if opcode == wasmi.opcodes.F32_CONST:
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                r = wasmi.stack.Entry.from_u32(i)
                r.kind = wasmi.opcodes.VALUE_TYPE_F32
                stack.add(r)
                continue
            if opcode == wasmi.opcodes.F64_CONST:
                n, i, _ = wasmi.common.decode_u64_leb128(code[pc:])
                pc += n
                r = wasmi.stack.Entry.from_u64(i)
                r.kind = wasmi.opcodes.VALUE_TYPE_F64
                stack.add(r)
                continue
            if opcode == wasmi.opcodes.GET_GLOBAL:
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                v = self.global_data[i]
                stack.add(v)
                continue
            if opcode == wasmi.opcodes.END:
                break
        if not stack.data:
            return 0
        return stack.data.pop().into_val()

    def exec(self, name: str, args: typing.List):
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
        for i, kind in enumerate(function_signature.args):
            args[i] = wasmi.stack.Entry.from_val(args[i], kind)
        ctx = Ctx(args)
        cdepth = 1
        pc = 0
        wasmi.log.println(code.hex())
        for _ in range(1 << 32):
            opcode = code[pc]
            pc += 1
            name = wasmi.opcodes.CODE_NAME[opcode]
            wasmi.log.println('0x' + wasmi.common.fmth(opcode, 2), name, ctx.stack.data)
            if opcode == wasmi.opcodes.UNREACHABLE:
                raise wasmi.error.WAException("unreachable")
            if opcode == wasmi.opcodes.NOP:
                continue
            if opcode == wasmi.opcodes.BLOCK:
                cdepth += 1
                n, kind, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                continue
            if opcode == wasmi.opcodes.LOOP:
                cdepth += 1
                raise NotImplementedError
            if opcode == wasmi.opcodes.IF:
                cdepth += 1
                raise NotImplementedError
            if opcode == wasmi.opcodes.ELSE:
                raise NotImplementedError
            if opcode == wasmi.opcodes.END:
                cdepth -= 1
                if cdepth == 0:
                    break
                continue
            if opcode == wasmi.opcodes.BR:
                raise NotImplementedError
            if opcode == wasmi.opcodes.BR_IF:
                n, _, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                cond = ctx.stack.pop_i32()
                if cond:
                    for _ in range(1 << 32):
                        if code[pc] == wasmi.opcodes.END:
                            break
                        pc += 1
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
                cond = ctx.stack.pop_i32()
                a = ctx.stack.pop()
                b = ctx.stack.pop()
                if cond:
                    ctx.stack.add(b)
                else:
                    ctx.stack.add(a)
                continue
            if opcode == wasmi.opcodes.GET_LOCAL:
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.stack.add(ctx.locals_data[i])
                continue
            if opcode == wasmi.opcodes.SET_LOCAL:
                v = ctx.stack.pop()
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.locals_data[i] = v
                continue
            if opcode == wasmi.opcodes.TEE_LOCAL:
                v = ctx.stack.data[-1]
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.locals_data[i] = v
                continue
            if opcode == wasmi.opcodes.GET_GLOBAL:
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                ctx.stack.add(self.global_data[i])
                continue
            if opcode == wasmi.opcodes.SET_GLOBAL:
                v = ctx.stack.pop()
                n, i, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                self.global_data[i] = v
                continue
            if opcode >= wasmi.opcodes.I32_LOAD and opcode <= wasmi.opcodes.I64_LOAD_32u:
                # memory_immediate has two fields, the alignment and the offset.
                # The former is simply an optimization hint and can be safely
                # discarded.
                pc += 1
                n, mem_offset, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                a = ctx.stack.pop_i64() + mem_offset
                if opcode == wasmi.opcodes.I32_LOAD:
                    r = wasmi.common.decode_i32(self.mem[a:a + 4])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD:
                    r = wasmi.common.decode_i64(self.mem[a:a + 8])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.F32_LOAD:
                    r = wasmi.common.decode_f32(self.mem[a:a + 4])
                    ctx.stack.add_f32(r)
                    continue
                if opcode == wasmi.opcodes.F64_LOAD:
                    r = wasmi.common.decode_f64(self.mem[a:a + 8])
                    ctx.stack.add_f64(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD_8s:
                    r = wasmi.common.decode_i8(self.mem[a:a + 1])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD_8u:
                    r = wasmi.common.decode_u8(self.mem[a:a + 1])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD_16s:
                    r = wasmi.common.decode_i16(self.mem[a:a + 2])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD_16u:
                    r = wasmi.common.decode_u16(self.mem[a:a + 2])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD_8s:
                    r = wasmi.common.decode_i8(self.mem[a:a + 1])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD_8u:
                    r = wasmi.common.decode_u8(self.mem[a:a + 1])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD_16s:
                    r = wasmi.common.decode_i16(self.mem[a:a + 2])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD_16u:
                    r = wasmi.common.decode_u16(self.mem[a:a + 2])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD_32s:
                    r = wasmi.common.decode_i32(self.mem[a:a + 4])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD_32u:
                    r = wasmi.common.decode_u32(self.mem[a:a + 4])
                    ctx.stack.add_i64(r)
                    continue
            if opcode >= wasmi.opcodes.I32_STORE and opcode <= wasmi.opcodes.I64_STORE32:
                v = ctx.stack.pop()
                pc += 1
                n, mem_offset, _ = wasmi.common.decode_u32_leb128(code[pc:])
                pc += n
                a = ctx.stack.pop_i64() + mem_offset
                if opcode == wasmi.opcodes.I32_STORE:
                    self.mem[a:a + 4] = wasmi.common.encode_i32(v.into_i32())
                    continue
                if opcode == wasmi.opcodes.I64_STORE:
                    self.mem[a:a + 8] = wasmi.common.encode_i64(v.into_i64())
                    continue
                if opcode == wasmi.opcodes.F32_STORE:
                    self.mem[a:a + 4] = wasmi.common.encode_f32(v.into_f32())
                    continue
                if opcode == wasmi.opcodes.F64_STORE:
                    self.mem[a:a + 8] = wasmi.common.encode_f64(v.into_f64())
                    continue
                if opcode == wasmi.opcodes.I32_STORE8:
                    self.mem[a:a + 1] = v.data[7, 8]
                    continue
                if opcode == wasmi.opcodes.I32_STORE16:
                    self.mem[a:a + 2] = v.data[6, 8]
                    continue
                if opcode == wasmi.opcodes.I64_STORE8:
                    self.mem[a:a + 1] = v.data[7, 8]
                    continue
                if opcode == wasmi.opcodes.I64_STORE16:
                    self.mem[a:a + 2] = v.data[6, 8]
                    continue
                if opcode == wasmi.opcodes.I64_STORE32:
                    self.mem[a:a + 4] = v.data[4, 8]
                    continue
            if opcode == wasmi.opcodes.CURRENT_MEMORY:
                pc += 1
                ctx.stack.add_i32(self.mem_len)
                continue
            if opcode == wasmi.opcodes.GROW_MEMORY:
                pc += 1
                cur_len = self.mem_len
                n = ctx.stack.pop_i32()
                self.mem.extend([0 for _ in range(n * 64 * 1024)])
                ctx.stack.add_i32(cur_len)
                continue
            if opcode == wasmi.opcodes.I32_CONST:
                n, r, _ = wasmi.common.decode_i32_leb128(code[pc:])
                pc += n
                ctx.stack.add_i32(r)
                continue
            if opcode == wasmi.opcodes.I64_CONST:
                n, r, _ = wasmi.common.decode_i64_leb128(code[pc:])
                pc += n
                ctx.stack.add_i64(r)
                continue
            if opcode == wasmi.opcodes.F32_CONST:
                n, r, _ = wasmi.common.decode_i32_leb128(code[pc:])
                pc += n
                r = wasmi.common.decode_f32(wasmi.common.encode_i32(r))
                ctx.stack.add_f32(r)
                continue
            if opcode == wasmi.opcodes.F64_CONST:
                n, r, _ = wasmi.common.decode_i64_leb128(code[pc:])
                pc += n
                r = wasmi.common.decode_f64(wasmi.common.encode_i64(r))
                ctx.stack.add_f32(r)
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
                b = ctx.stack.pop_i32()
                a = ctx.stack.pop_i32()
                ctx.stack.add_i32(a < b)
                continue
            if opcode == wasmi.opcodes.I32_LTU:
                b = ctx.stack.pop_u32()
                a = ctx.stack.pop_u32()
                ctx.stack.add_i32(a < b)
                continue
            if opcode == wasmi.opcodes.I32_GTS:
                b = ctx.stack.pop_i32()
                a = ctx.stack.pop_i32()
                ctx.stack.add_i32(a > b)
                continue
            if opcode == wasmi.opcodes.I32_GTU:
                b = ctx.stack.pop_u32()
                a = ctx.stack.pop_u32()
                ctx.stack.add_i32(a > b)
                continue
            if opcode == wasmi.opcodes.I32_LES:
                b = ctx.stack.pop_i32()
                a = ctx.stack.pop_i32()
                ctx.stack.add_i32(a <= b)
                continue
            if opcode == wasmi.opcodes.I32_LEU:
                b = ctx.stack.pop_u32()
                a = ctx.stack.pop_u32()
                ctx.stack.add_i32(a <= b)
                continue
            if opcode == wasmi.opcodes.I32_GES:
                b = ctx.stack.pop_i32()
                a = ctx.stack.pop_i32()
                ctx.stack.add_i32(a >= b)
                continue
            if opcode == wasmi.opcodes.I32_GEU:
                b = ctx.stack.pop_u32()
                a = ctx.stack.pop_u32()
                ctx.stack.add_i32(a >= b)
                continue
            if opcode == wasmi.opcodes.I64_EQZ:
                ctx.stack.add_i32(ctx.stack.pop_i64() == 0)
                continue
            if opcode == wasmi.opcodes.I64_EQ:
                ctx.stack.add_i32(ctx.stack.pop_i64() == ctx.stack.pop_i64())
                continue
            if opcode == wasmi.opcodes.I64_NE:
                ctx.stack.add_i32(ctx.stack.pop_i64() != ctx.stack.pop_i64())
                continue
            if opcode == wasmi.opcodes.I64_LTS:
                b = ctx.stack.pop_i64()
                a = ctx.stack.pop_i64()
                ctx.stack.add_i32(a < b)
                continue
            if opcode == wasmi.opcodes.I64_LTU:
                b = ctx.stack.pop_u64()
                a = ctx.stack.pop_u64()
                ctx.stack.add_i32(a < b)
                continue
            if opcode == wasmi.opcodes.I64_GTS:
                b = ctx.stack.pop_i64()
                a = ctx.stack.pop_i64()
                ctx.stack.add_i32(a > b)
                continue
            if opcode == wasmi.opcodes.I64_GTU:
                b = ctx.stack.pop_u64()
                a = ctx.stack.pop_u64()
                ctx.stack.add_i32(a > b)
                continue
            if opcode == wasmi.opcodes.I64_LES:
                b = ctx.stack.pop_i64()
                a = ctx.stack.pop_i64()
                ctx.stack.add_i32(a <= b)
                continue
            if opcode == wasmi.opcodes.I64_LEU:
                b = ctx.stack.pop_u64()
                a = ctx.stack.pop_u64()
                ctx.stack.add_i32(a <= b)
                continue
            if opcode == wasmi.opcodes.I64_GES:
                b = ctx.stack.pop_i64()
                a = ctx.stack.pop_i64()
                ctx.stack.add_i32(a >= b)
                continue
            if opcode == wasmi.opcodes.I64_GEU:
                b = ctx.stack.pop_u64()
                a = ctx.stack.pop_u64()
                ctx.stack.add_i32(a >= b)
                continue
            if opcode == wasmi.opcodes.F32_EQ:
                ctx.stack.add_i32(ctx.stack.pop_f32() == ctx.stack.pop_f32())
                continue
            if opcode == wasmi.opcodes.F32_NE:
                ctx.stack.add_i32(ctx.stack.pop_f32() != ctx.stack.pop_f32())
                continue
            if opcode == wasmi.opcodes.F32_LT:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_i32(a < b)
                continue
            if opcode == wasmi.opcodes.F32_GT:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_i32(a > b)
                continue
            if opcode == wasmi.opcodes.F32_LE:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_i32(a <= b)
                continue
            if opcode == wasmi.opcodes.F32_GE:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_i32(a >= b)
                continue
            if opcode == wasmi.opcodes.F64_EQ:
                ctx.stack.add_i32(ctx.stack.pop_f64() == ctx.stack.pop_f64())
                continue
            if opcode == wasmi.opcodes.F64_NE:
                ctx.stack.add_i32(ctx.stack.pop_f64() != ctx.stack.pop_f64())
                continue
            if opcode == wasmi.opcodes.F64_LT:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_i32(a < b)
                continue
            if opcode == wasmi.opcodes.F64_GT:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_i32(a > b)
                continue
            if opcode == wasmi.opcodes.F64_LE:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_i32(a <= b)
                continue
            if opcode == wasmi.opcodes.F64_GE:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_i32(a >= b)
                continue
            if opcode == wasmi.opcodes.I32_CLZ:
                v = ctx.stack.pop_i32()
                c = 0
                while c < 32 and (v & 0x80000000) == 0:
                    c += 1
                    v *= 2
                ctx.stack.add_i32(c)
                continue
            if opcode == wasmi.opcodes.I32_CTZ:
                v = ctx.stack.pop_i32()
                c = 0
                while c < 32 and (v % 2) == 0:
                    c += 1
                    v /= 2
                ctx.stack.add_i32(c)
                continue
            if opcode == wasmi.opcodes.I32_POPCNT:
                v = ctx.stack.pop_i32()
                c = 0
                for i in range(32):
                    if 0x1 & v:
                        c += 1
                    v /= 2
                ctx.stack.add_i32(c)
                continue
            if opcode >= wasmi.opcodes.I32_ADD and opcode <= wasmi.opcodes.I32_ROTR:
                b = ctx.stack.pop_i32()
                a = ctx.stack.pop_i32()
                if opcode == wasmi.opcodes.I32_ADD:
                    r = wasmi.common.into_i32(a + b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_SUB:
                    r = wasmi.common.into_i32(a - b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_MUL:
                    r = wasmi.common.into_i32(a * b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_DIVS:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    if a == 0x80000000 and b == -1:
                        raise wasmi.error.WAException("integer overflow")
                    r = wasmi.common.idiv_s(a, b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_DIVU:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    r = wasmi.common.into_u32(a) // wasmi.common.into_u32(b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_REMS:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    r = wasmi.common.irem_s(a, b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_REMU:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    r = wasmi.common.into_u32(a) % wasmi.common.into_u32(b)
                    continue
                if opcode == wasmi.opcodes.I32_AND:
                    ctx.stack.add_i32(a & b)
                    continue
                if opcode == wasmi.opcodes.I32_OR:
                    ctx.stack.add_i32(a | b)
                    continue
                if opcode == wasmi.opcodes.I32_XOR:
                    ctx.stack.add_i32(a ^ b)
                    continue
                if opcode == wasmi.opcodes.I32_SHL:
                    ctx.stack.add_i32(a << (b % 0x20))
                    continue
                if opcode == wasmi.opcodes.I32_SHRS:
                    ctx.stack.add_i32(a >> (b % 0x20))
                    continue
                if opcode == wasmi.opcodes.I32_SHRU:
                    ctx.stack.add_i32(wasmi.common.into_u32(a) >> (b % 0x20))
                    continue
                if opcode == wasmi.opcodes.I32_ROTL:
                    r = wasmi.common.rotl_u32(a, b)
                    r = wasmi.common.into_i32(r)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_ROTR:
                    r = wasmi.common.rotr_u32(a, b)
                    r = wasmi.common.into_i32(r)
                    ctx.stack.add_i32(r)
                    continue
            if opcode == wasmi.opcodes.I64_CLZ:
                v = ctx.stack.pop_i64()
                if v < 0:
                    ctx.stack.add_i32(0)
                    continue
                c = 1
                while c < 63 and (v & 0x4000000000000000) == 0:
                    c += 1
                    v *= 2
                ctx.stack.add_i64(c)
                continue
            if opcode == wasmi.opcodes.I64_CTZ:
                v = ctx.stack.pop_i64()
                c = 0
                while c < 64 and (v % 2) == 0:
                    c += 1
                    v /= 2
                ctx.stack.add_i64(c)
                continue
            if opcode == wasmi.opcodes.I64_POPCNT:
                v = ctx.stack.pop_i64()
                c = 0
                for i in range(64):
                    if 0x1 & v:
                        c += 1
                    v /= 2
                ctx.stack.add_i64(c)
                continue
            if opcode >= wasmi.opcodes.I64_ADD and opcode <= wasmi.opcodes.I64_ROTR:
                b = ctx.stack.pop_i64()
                a = ctx.stack.pop_i64()
                if opcode == wasmi.opcodes.I64_ADD:
                    r = wasmi.common.into_i64(a + b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_SUB:
                    r = wasmi.common.into_i64(a - b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_MUL:
                    r = wasmi.common.into_i64(a * b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_DIVS:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    r = wasmi.common.idiv_s(a, b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_DIVU:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    r = wasmi.common.into_u64(a) // wasmi.common.into_u64(b)
                    r = wasmi.common.into_i64(r)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_REMS:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    r = wasmi.common.irem_s(a, b)
                    ctx.stack.add_i64(r)
                if opcode == wasmi.opcodes.I64_REMU:
                    if b == 0:
                        raise wasmi.error.WAException("integer divide by zero")
                    r = wasmi.common.into_u64(a) % wasmi.common.into_u64(b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_AND:
                    ctx.stack.add_i64(a & b)
                    continue
                if opcode == wasmi.opcodes.I64_OR:
                    ctx.stack.add_i64(a | b)
                    continue
                if opcode == wasmi.opcodes.I64_XOR:
                    ctx.stack.add_i64(a ^ b)
                    continue
                if opcode == wasmi.opcodes.I64_SHL:
                    ctx.stack.add_i64(a << (b % 0x40))
                    continue
                if opcode == wasmi.opcodes.I64_SHRS:
                    ctx.stack.add_i64(a >> (b % 0x40))
                    continue
                if opcode == wasmi.opcodes.I64_SHRU:
                    ctx.stack.add_i64(wasmi.common.into_u64(a) >> (b % 0x40))
                    continue
                if opcode == wasmi.opcodes.I64_ROTL:
                    r = wasmi.common.rotl_u64(a, b)
                    r = wasmi.common.into_i64(r)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_ROTR:
                    r = wasmi.common.rotr_u64(a, b)
                    r = wasmi.common.into_i64(r)
                    ctx.stack.add_i64(r)
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
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_f32(a + b)
                continue
            if opcode == wasmi.opcodes.F32_SUB:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_f32(a - b)
                continue
            if opcode == wasmi.opcodes.F32_MUL:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_f32(a * b)
                continue
            if opcode == wasmi.opcodes.F32_DIV:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_f32(a / b)
                continue
            if opcode == wasmi.opcodes.F32_MIN:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_f32(min(a, b))
                continue
            if opcode == wasmi.opcodes.F32_MAX:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                ctx.stack.add_f32(max(a, b))
                continue
            if opcode == wasmi.opcodes.F32_COPYSIGN:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                r = math.copysign(b, a)
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
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_f64(a + b)
                continue
            if opcode == wasmi.opcodes.F64_SUB:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_f64(a - b)
                continue
            if opcode == wasmi.opcodes.F64_MUL:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_f64(a * b)
                continue
            if opcode == wasmi.opcodes.F64_DIV:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_f64(a / b)
                continue
            if opcode == wasmi.opcodes.F64_MIN:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_f64(min(a, b))
                continue
            if opcode == wasmi.opcodes.F64_MAX:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                ctx.stack.add_f64(max(a, b))
                continue
            if opcode == wasmi.opcodes.F64_COPYSIGN:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                r = math.copysign(b, a)
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

        if ctx.stack.len():
            return ctx.stack.pop().into_val()
        return None
