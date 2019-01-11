import itertools
import math
import typing

import wasmi.common
import wasmi.log
import wasmi.opcodes
import wasmi.stack
import wasmi.section
import wasmi.error
import wasmi.num as num

# -----------------------------------------------------------------------------
# About opcode description, see:
# https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md
# https://github.com/WebAssembly/design/blob/master/Semantics.md
# -----------------------------------------------------------------------------


class Mod:
    def __init__(self):
        self.version: int
        self.sections: typing.List[wasmi.section.Section] = []

        self.section_custom: wasmi.section.SectionUnknown = None
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
        mag = num.LittleEndian.u32(r.read(4))
        if mag != 0x6d736100:
            raise wasmi.error.WAException(f'magicv')
        ver = num.LittleEndian.u32(r.read(4))
        mod.version = ver
        wasmi.log.println('Section slice'.center(80, '-'))
        for _ in range(1 << 32):
            try:
                sec = wasmi.section.Section.from_reader(r)
            except Exception as e:
                break
            else:
                wasmi.log.println(sec)
                mod.sections.append(sec)
        wasmi.log.println('Section parse'.center(80, '-'))
        for e in mod.sections:
            if e.section_id == wasmi.opcodes.SECTION_ID_CUSTOM:
                mod.section_custom = wasmi.section.SectionCustom.from_section(e)
                wasmi.log.println(mod.section_custom)
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_TYPE:
                mod.section_type = wasmi.section.SectionType.from_section(e)
                wasmi.log.println(f'SectionType')
                for i in mod.section_type.entries:
                    wasmi.log.println(' ' * 4 + str(i))
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_IMPORT:
                mod.section_import = wasmi.section.SectionImport.from_section(e)
                wasmi.log.println(f'SectionImport')
                for i in mod.section_import.entries:
                    wasmi.log.println(' ' * 4 + str(i))
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_FUNCTION:
                mod.section_function = wasmi.section.SectionFunction.from_section(e)
                wasmi.log.println(mod.section_function)
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_TABLE:
                mod.section_table = wasmi.section.SectionTable.from_section(e)
                wasmi.log.println(mod.section_table)
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_MEMORY:
                mod.section_memory = wasmi.section.SectionMemory.from_section(e)
                wasmi.log.println(f'SectionMemory')
                for i in mod.section_memory.entries:
                    wasmi.log.println(' ' * 4 + str(i))
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_GLOBAL:
                mod.section_global = wasmi.section.SectionGlobal.from_section(e)
                wasmi.log.println(f'SectionGlobal')
                for i in mod.section_global.entries:
                    wasmi.log.println(' ' * 4 + str(i))
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_EXPORT:
                mod.section_export = wasmi.section.SectionExport.from_section(e)
                wasmi.log.println(f'SectionExport')
                for i in mod.section_export.entries:
                    wasmi.log.println(' ' * 4 + str(i))
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_START:
                mod.section_start = wasmi.section.SectionStart.from_section(e)
                wasmi.log.println(mod.section_start)
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_ELEMENT:
                mod.section_element = wasmi.section.SectionElement.from_section(e)
                wasmi.log.println(mod.section_element)
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_CODE:
                mod.section_code = wasmi.section.SectionCode.from_section(e)
                wasmi.log.println(f'SectionCode')
                for i in mod.section_code.entries:
                    wasmi.log.println(' ' * 4 + str(i))
                continue
            if e.section_id == wasmi.opcodes.SECTION_ID_DATA:
                mod.section_data = wasmi.section.SectionData.from_section(e)
                wasmi.log.println(f'SectionData')
                for i in mod.section_data.entries:
                    wasmi.log.println(' ' * 4 + str(i))
                continue
        return mod


class Env:
    def __init__(self):
        self.import_func = {}


class Ctx:
    def __init__(self, data: typing.List[wasmi.stack.Entry]):
        self.stack = wasmi.stack.Stack()
        self.ctack = []
        self.locals_data = data


class Function:
    def __init__(self, signature: wasmi.section.FuncType):
        self.signature = signature
        self.code: wasmi.section.Code = None
        self.envb = False
        self.module: str
        self.name: str

    def __repr__(self):
        name = 'Function'
        seps = []
        seps.append(f'envb={self.envb}')
        seps.append(f'signature={self.signature}')
        if self.envb:
            seps.append(f'module={self.module}')
            seps.append(f'name={self.name}')
        return f'{name}<{" ".join(seps)}>'

    @classmethod
    def from_sec(cls, signature: wasmi.section.FuncType, code: wasmi.section.Code):
        func = Function(signature)
        func.code = code
        return func

    @classmethod
    def from_env(cls, signature: wasmi.section.FuncType, module: str, name: str):
        func = Function(signature)
        func.envb = True
        func.module = module
        func.name = name
        return func


class Vm:
    def __init__(self, mod: Mod, env: Env = None):
        self.mod = mod
        self.global_data: typing.List[wasmi.stack.Entry] = []
        self.mem = bytearray()
        self.mem_len = 0
        self.table = {}
        self.functions: typing.List[Function] = []
        self.env = env if env else Env()

        if self.mod.section_custom:
            pass
        if self.mod.section_type:
            pass
        if self.mod.section_import:
            for e in self.mod.section_import.entries:
                if e.kind == wasmi.opcodes.EXTERNAL_FUNCTION:
                    func = Function.from_env(
                        self.mod.section_type.entries[e.desc],
                        e.module,
                        e.name
                    )
                    self.functions.append(func)
                if e.kind == wasmi.opcodes.EXTERNAL_TABLE:
                    continue
                if e.kind == wasmi.opcodes.EXTERNAL_MEMORY:
                    continue
                if e.kind == wasmi.opcodes.EXTERNAL_GLOBAL:
                    continue

        if self.mod.section_function:
            for fun_idx, sig_idx in enumerate(self.mod.section_function.entries):
                func = Function.from_sec(
                    self.mod.section_type.entries[sig_idx],
                    self.mod.section_code.entries[fun_idx]
                )
                self.functions.append(func)
        if self.mod.section_table:
            self.table = self.mod.section_table.dict
        if self.mod.section_memory:
            if self.mod.section_memory.entries:
                if len(self.mod.section_memory.entries) > 1:
                    raise wasmi.error.Exception('multiple linear memories')
                self.mem_len = self.mod.section_memory.entries[0].limits.minimum
                self.mem = bytearray([0 for _ in range(self.mem_len * 64 * 1024)])
        if self.mod.section_global:
            for e in self.mod.section_global.entries:
                v = self.exec_init_expr(e.expr.data)
                self.global_data.append(wasmi.stack.Entry.from_val(v, e.globaltype.valtype))
        if self.mod.section_export:
            pass
        if self.mod.section_start:
            pass
        if self.mod.section_element:
            for e in self.mod.section_element.entries:
                offset = self.exec_init_expr(e.expr.data)
                for i, sube in enumerate(e.init):
                    self.table[wasmi.opcodes.VALUE_TYPE_FUNCREF][offset + i] = sube
        if self.mod.section_code:
            pass
        if self.mod.section_data:
            for e in self.mod.section_data.entries:
                assert e.memidx == 0
                offset = self.exec_init_expr(e.expr.data)
                self.mem[offset: offset + len(e.init)] = e.init

    def exec_init_expr(self, code: bytearray):
        stack = wasmi.stack.Stack()
        if not code:
            raise wasmi.error.WAException('empty init expr')
        pc = 0
        for _ in range(1 << 32):
            opcode = code[pc]
            pc += 1
            if opcode == wasmi.opcodes.I32_CONST:
                n, i, _ = wasmi.common.read_leb(code[pc:], 32, True)
                pc += n
                stack.add_i32(i)
                continue
            if opcode == wasmi.opcodes.I64_CONST:
                n, i, _ = wasmi.common.read_leb(code[pc:], 64, True)
                pc += n
                stack.add_i64(i)
                continue
            if opcode == wasmi.opcodes.F32_CONST:
                v = wasmi.common.read_f32(code[pc:])
                pc += 4
                stack.add_f32(v)
                continue
            if opcode == wasmi.opcodes.F64_CONST:
                v = wasmi.common.read_f64(code[pc:])
                pc += 8
                stack.add_f64(v)
                continue
            if opcode == wasmi.opcodes.GET_GLOBAL:
                n, i, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                v = self.global_data[i]
                stack.add(v)
                continue
            if opcode == wasmi.opcodes.END:
                break
        if not stack.len():
            return 0
        return stack.pop().into_val()

    def exec_step(self, f_idx: int, ctx: Ctx):
        f_fun = self.functions[f_idx]
        f_sig = f_fun.signature
        f_sec = f_fun.code
        for eloc in f_sec.locals:
            for _ in range(eloc.n):
                e = wasmi.stack.Entry.from_val(0, eloc.valtype)
                ctx.locals_data.append(e)
        ctx.ctack.append([f_sec, ctx.stack.i])
        code = f_sec.expr.data
        wasmi.log.println('Code', code.hex())
        wasmi.log.println('Locals', ctx.locals_data)
        wasmi.log.println('Global', self.global_data)
        pc = 0
        for _ in range(1 << 32):
            opcode = code[pc]
            pc += 1
            name = wasmi.opcodes.OP_INFO[opcode][0]
            wasmi.log.println(f'0x{wasmi.common.fmth(opcode, 2)}({name}) {ctx.stack.data[:ctx.stack.i + 1]}')
            if opcode == wasmi.opcodes.UNREACHABLE:
                raise wasmi.error.WAException('reached unreachable')
            if opcode == wasmi.opcodes.NOP:
                continue
            if opcode == wasmi.opcodes.BLOCK:
                n, _, _ = wasmi.common.read_leb(code[pc:], 32)
                b = f_sec.bmap[pc - 1]
                pc += n
                ctx.ctack.append([b, ctx.stack.i])
                continue
            if opcode == wasmi.opcodes.LOOP:
                n, _, _ = wasmi.common.read_leb(code[pc:], 32)
                b = f_sec.bmap[pc - 1]
                pc += n
                ctx.ctack.append([b, ctx.stack.i])
                continue
            if opcode == wasmi.opcodes.IF:
                n, _, _ = wasmi.common.read_leb(code[pc:], 32)
                b = f_sec.bmap[pc - 1]
                pc += n
                ctx.ctack.append([b, ctx.stack.i])
                cond = ctx.stack.pop_i32()
                if cond:
                    continue
                if b.pos_else == 0:
                    ctx.ctack.pop()
                    pc = b.pos_br + 1
                    continue
                pc = b.pos_else
                continue
            if opcode == wasmi.opcodes.ELSE:
                b, _ = ctx.ctack[-1]
                pc = b.pos_br
                continue
            if opcode == wasmi.opcodes.END:
                b, sp = ctx.ctack.pop()
                if isinstance(b, wasmi.section.Code):
                    if not ctx.ctack:
                        if f_sig.rets:
                            if f_sig.rets[0] != ctx.stack.top().kind:
                                raise wasmi.error.WAException('signature mismatch in call_indirect')
                            return ctx.stack.pop().into_val()
                        return None
                    return
                if sp < ctx.stack.i:
                    v = ctx.stack.pop()
                    ctx.stack.i = sp
                    ctx.stack.add(v)
                continue
            if opcode == wasmi.opcodes.BR:
                n, c, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                for _ in range(c):
                    ctx.ctack.pop()
                b, _ = ctx.ctack[-1]
                pc = b.pos_br
                continue
            if opcode == wasmi.opcodes.BR_IF:
                n, br_depth, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                cond = ctx.stack.pop_i32()
                if cond:
                    for _ in range(br_depth):
                        ctx.ctack.pop()
                    b, _ = ctx.ctack[-1]
                    pc = b.pos_br
                continue
            if opcode == wasmi.opcodes.BR_TABLE:
                n, lcount, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                depths = []
                for c in range(lcount):
                    n, ldepth, _ = wasmi.common.read_leb(code[pc:], 32)
                    pc += n
                    depths.append(ldepth)
                n, ddepth, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                didx = ctx.stack.pop_i32()
                if didx >= 0 and didx < len(depths):
                    ddepth = depths[didx]
                for _ in range(ddepth):
                    ctx.ctack.pop()
                b, _ = ctx.ctack[-1]
                pc = b.pos_br
                continue
            if opcode == wasmi.opcodes.RETURN:
                while ctx.ctack:
                    if isinstance(ctx.ctack[-1][0], wasmi.section.Code):
                        break
                    ctx.ctack.pop()
                b, _ = ctx.ctack[-1]
                pc = len(b.expr.data) - 1
                continue
            if opcode == wasmi.opcodes.CALL:
                n, f_idx, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                son_f_fun = self.functions[f_idx]
                son_f_sig = son_f_fun.signature
                if son_f_fun.envb:
                    name = son_f_fun.module + '.' + son_f_fun.name
                    func = self.env.import_func[name]
                    r = func(self.mem, [ctx.stack.pop() for _ in son_f_sig.args][::-1])
                    e = wasmi.stack.Entry.from_val(r, ord(son_f_sig.rets))
                    ctx.stack.add(e)
                    continue
                pre_locals_data = ctx.locals_data
                ctx.locals_data = [ctx.stack.pop() for _ in son_f_sig.args][::-1]
                self.exec_step(f_idx, ctx)
                ctx.locals_data = pre_locals_data
                continue
            if opcode == wasmi.opcodes.CALL_INDIRECT:
                n, _, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                n, _, _ = wasmi.common.read_leb(code[pc:], 1)
                pc += n
                t_idx = ctx.stack.pop_i32()
                if not 0 <= t_idx < len(self.table[wasmi.opcodes.VALUE_TYPE_FUNCREF]):
                    raise wasmi.error.WAException('undefined element index')
                f_idx = self.table[wasmi.opcodes.VALUE_TYPE_FUNCREF][t_idx]
                son_f_fun = self.functions[f_idx]
                son_f_sig = son_f_fun.signature
                a = list(son_f_sig.args)
                b = [ctx.stack.pop() for _ in son_f_sig.args][::-1]
                for i in range(len(a)):
                    ia = a[i]
                    ib = b[i]
                    if ib == None or ia != ib.kind:
                        raise wasmi.error.WAException('signature mismatch in call_indirect')
                pre_locals_data = ctx.locals_data
                ctx.locals_data = b
                self.exec_step(f_idx, ctx)
                ctx.locals_data = pre_locals_data
                continue
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
                n, i, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                ctx.stack.add(ctx.locals_data[i])
                continue
            if opcode == wasmi.opcodes.SET_LOCAL:
                v = ctx.stack.pop()
                n, i, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                if i >= len(ctx.locals_data):
                    ctx.locals_data.extend(
                        [wasmi.stack.Entry.from_i32(0) for _ in range(i - len(ctx.locals_data) + 1)]
                    )
                ctx.locals_data[i] = v
                continue
            if opcode == wasmi.opcodes.TEE_LOCAL:
                v = ctx.stack.top()
                n, i, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                ctx.locals_data[i] = v
                continue
            if opcode == wasmi.opcodes.GET_GLOBAL:
                n, i, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                ctx.stack.add(self.global_data[i])
                continue
            if opcode == wasmi.opcodes.SET_GLOBAL:
                v = ctx.stack.pop()
                n, i, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                self.global_data[i] = v
                continue
            if opcode >= wasmi.opcodes.I32_LOAD and opcode <= wasmi.opcodes.I64_LOAD32_U:
                # memory_immediate has two fields, the alignment and the offset.
                # The former is simply an optimization hint and can be safely
                # discarded.
                pc += 1
                n, mem_offset, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                a = ctx.stack.pop_i64() + mem_offset
                if a + wasmi.opcodes.OP_INFO[opcode][2] > len(self.mem):
                    raise wasmi.error.WAException('out of bounds memory access')
                if opcode == wasmi.opcodes.I32_LOAD:
                    r = num.LittleEndian.i32(self.mem[a:a + 4])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD:
                    r = num.LittleEndian.i64(self.mem[a:a + 8])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.F32_LOAD:
                    r = num.LittleEndian.f32(self.mem[a:a + 4])
                    ctx.stack.add_f32(r)
                    continue
                if opcode == wasmi.opcodes.F64_LOAD:
                    r = num.LittleEndian.f64(self.mem[a:a + 8])
                    ctx.stack.add_f64(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD8_S:
                    r = num.LittleEndian.i8(self.mem[a:a + 1])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD8_U:
                    r = num.LittleEndian.u8(self.mem[a:a + 1])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD16_S:
                    r = num.LittleEndian.i16(self.mem[a:a + 2])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_LOAD16_U:
                    r = num.LittleEndian.u16(self.mem[a:a + 2])
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD8_S:
                    r = num.LittleEndian.i8(self.mem[a:a + 1])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD8_U:
                    r = num.LittleEndian.u8(self.mem[a:a + 1])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD16_S:
                    r = num.LittleEndian.i16(self.mem[a:a + 2])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD16_U:
                    r = num.LittleEndian.u16(self.mem[a:a + 2])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD32_S:
                    r = num.LittleEndian.i32(self.mem[a:a + 4])
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_LOAD32_U:
                    r = num.LittleEndian.u32(self.mem[a:a + 4])
                    ctx.stack.add_i64(r)
                    continue
            if opcode >= wasmi.opcodes.I32_STORE and opcode <= wasmi.opcodes.I64_STORE32:
                v = ctx.stack.pop()
                pc += 1
                n, mem_offset, _ = wasmi.common.read_leb(code[pc:], 32)
                pc += n
                a = ctx.stack.pop_i64() + mem_offset
                if a + wasmi.opcodes.OP_INFO[opcode][2] > len(self.mem):
                    raise wasmi.error.WAException('out of bounds memory access')
                if opcode == wasmi.opcodes.I32_STORE:
                    self.mem[a:a + 4] = num.LittleEndian.pack_i32(v.into_i32())
                    continue
                if opcode == wasmi.opcodes.I64_STORE:
                    self.mem[a:a + 8] = num.LittleEndian.pack_i64(v.into_i64())
                    continue
                if opcode == wasmi.opcodes.F32_STORE:
                    self.mem[a:a + 4] = num.LittleEndian.pack_f32(v.into_f32())
                    continue
                if opcode == wasmi.opcodes.F64_STORE:
                    self.mem[a:a + 8] = num.LittleEndian.pack_f64(v.into_f64())
                    continue
                if opcode == wasmi.opcodes.I32_STORE8:
                    self.mem[a:a + 1] = num.LittleEndian.pack_i8(num.int2i8(v.into_i32()))
                    continue
                if opcode == wasmi.opcodes.I32_STORE16:
                    self.mem[a:a + 2] = num.LittleEndian.pack_i16(num.int2i16(v.into_i32()))
                    continue
                if opcode == wasmi.opcodes.I64_STORE8:
                    self.mem[a:a + 1] = num.LittleEndian.pack_i8(num.int2i8(v.into_i64()))
                    continue
                if opcode == wasmi.opcodes.I64_STORE16:
                    self.mem[a:a + 2] = num.LittleEndian.pack_i16(num.int2i16(v.into_i64()))
                    continue
                if opcode == wasmi.opcodes.I64_STORE32:
                    self.mem[a:a + 4] = num.LittleEndian.pack_i32(num.int2i32(v.into_i64()))
                    continue
            if opcode == wasmi.opcodes.CURRENT_MEMORY:
                pc += 1
                ctx.stack.add_i32(self.mem_len)
                continue
            if opcode == wasmi.opcodes.GROW_MEMORY:
                pc += 1
                cur_len = self.mem_len
                n = ctx.stack.pop_i32()
                self.mem_len += n
                self.mem.extend([0 for _ in range(n * 64 * 1024)])
                ctx.stack.add_i32(cur_len)
                continue
            if opcode >= wasmi.opcodes.I32_CONST and opcode <= wasmi.opcodes.F64_CONST:
                if opcode == wasmi.opcodes.I32_CONST:
                    n, r, _ = wasmi.common.read_leb(code[pc:], 32, True)
                    pc += n
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I64_CONST:
                    n, r, _ = wasmi.common.read_leb(code[pc:], 64, True)
                    pc += n
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.F32_CONST:
                    r = wasmi.common.read_f32(code[pc:])
                    pc += 4
                    ctx.stack.add_f32(r)
                    continue
                if opcode == wasmi.opcodes.F64_CONST:
                    r = wasmi.common.read_f64(code[pc:])
                    pc += 8
                    ctx.stack.add_f64(r)
                    continue
            if opcode == wasmi.opcodes.I32_EQZ:
                ctx.stack.add_i32(ctx.stack.pop_i32() == 0)
                continue
            if opcode >= wasmi.opcodes.I32_EQ and opcode <= wasmi.opcodes.I32_GEU:
                b = ctx.stack.pop()
                a = ctx.stack.pop()
                if opcode == wasmi.opcodes.I32_EQ:
                    ctx.stack.add_i32(a.into_i32() == b.into_i32())
                    continue
                if opcode == wasmi.opcodes.I32_NE:
                    ctx.stack.add_i32(a.into_i32() != b.into_i32())
                    continue
                if opcode == wasmi.opcodes.I32_LTS:
                    ctx.stack.add_i32(a.into_i32() < b.into_i32())
                    continue
                if opcode == wasmi.opcodes.I32_LTU:
                    ctx.stack.add_i32(a.into_u32() < b.into_u32())
                    continue
                if opcode == wasmi.opcodes.I32_GTS:
                    ctx.stack.add_i32(a.into_i32() > b.into_i32())
                    continue
                if opcode == wasmi.opcodes.I32_GTU:
                    ctx.stack.add_i32(a.into_u32() > b.into_u32())
                    continue
                if opcode == wasmi.opcodes.I32_LES:
                    ctx.stack.add_i32(a.into_i32() <= b.into_i32())
                    continue
                if opcode == wasmi.opcodes.I32_LEU:
                    ctx.stack.add_i32(a.into_u32() <= b.into_u32())
                    continue
                if opcode == wasmi.opcodes.I32_GES:
                    ctx.stack.add_i32(a.into_i32() >= b.into_i32())
                    continue
                if opcode == wasmi.opcodes.I32_GEU:
                    ctx.stack.add_i32(a.into_u32() >= b.into_u32())
                    continue
            if opcode == wasmi.opcodes.I64_EQZ:
                ctx.stack.add_i32(ctx.stack.pop_i64() == 0)
                continue
            if opcode >= wasmi.opcodes.I64_EQ and opcode <= wasmi.opcodes.I64_GEU:
                b = ctx.stack.pop()
                a = ctx.stack.pop()
                if opcode == wasmi.opcodes.I64_EQ:
                    ctx.stack.add_i32(a.into_i64() == b.into_i64())
                    continue
                if opcode == wasmi.opcodes.I64_NE:
                    ctx.stack.add_i32(a.into_i64() != b.into_i64())
                    continue
                if opcode == wasmi.opcodes.I64_LTS:
                    ctx.stack.add_i32(a.into_i64() < b.into_i64())
                    continue
                if opcode == wasmi.opcodes.I64_LTU:
                    ctx.stack.add_i32(a.into_u64() < b.into_u64())
                    continue
                if opcode == wasmi.opcodes.I64_GTS:
                    ctx.stack.add_i32(a.into_i64() > b.into_i64())
                    continue
                if opcode == wasmi.opcodes.I64_GTU:
                    ctx.stack.add_i32(a.into_u64() > b.into_i64())
                    continue
                if opcode == wasmi.opcodes.I64_LES:
                    ctx.stack.add_i32(a.into_i64() <= b.into_i64())
                    continue
                if opcode == wasmi.opcodes.I64_LEU:
                    ctx.stack.add_i32(a.into_u64() <= b.into_u64())
                    continue
                if opcode == wasmi.opcodes.I64_GES:
                    ctx.stack.add_i32(a.into_i64() >= b.into_i64())
                    continue
                if opcode == wasmi.opcodes.I64_GEU:
                    ctx.stack.add_i32(a.into_u64() >= b.into_u64())
                    continue
            if opcode >= wasmi.opcodes.F32_EQ and opcode <= wasmi.opcodes.F64_GE:
                b = ctx.stack.pop()
                a = ctx.stack.pop()
                if opcode == wasmi.opcodes.F32_EQ:
                    ctx.stack.add_i32(a.into_f32() == b.into_f32())
                    continue
                if opcode == wasmi.opcodes.F32_NE:
                    ctx.stack.add_i32(a.into_f32() != b.into_f32())
                    continue
                if opcode == wasmi.opcodes.F32_LT:
                    ctx.stack.add_i32(a.into_f32() < b.into_f32())
                    continue
                if opcode == wasmi.opcodes.F32_GT:
                    ctx.stack.add_i32(a.into_f32() > b.into_f32())
                    continue
                if opcode == wasmi.opcodes.F32_LE:
                    ctx.stack.add_i32(a.into_f32() <= b.into_f32())
                    continue
                if opcode == wasmi.opcodes.F32_GE:
                    ctx.stack.add_i32(a.into_f32() >= b.into_f32())
                    continue
                if opcode == wasmi.opcodes.F64_EQ:
                    ctx.stack.add_i32(a.into_f64() == b.into_f64())
                    continue
                if opcode == wasmi.opcodes.F64_NE:
                    ctx.stack.add_i32(a.into_f64() != b.into_f64())
                    continue
                if opcode == wasmi.opcodes.F64_LT:
                    ctx.stack.add_i32(a.into_f64() < b.into_f64())
                    continue
                if opcode == wasmi.opcodes.F64_GT:
                    ctx.stack.add_i32(a.into_f64() > b.into_f64())
                    continue
                if opcode == wasmi.opcodes.F64_LE:
                    ctx.stack.add_i32(a.into_f64() <= b.into_f64())
                    continue
                if opcode == wasmi.opcodes.F64_GE:
                    ctx.stack.add_i32(a.into_f64() >= b.into_f64())
                    continue
            if opcode >= wasmi.opcodes.I32_CLZ and opcode <= wasmi.opcodes.I32_POPCNT:
                v = ctx.stack.pop_i32()
                if opcode == wasmi.opcodes.I32_CLZ:
                    c = 0
                    while c < 32 and (v & 0x80000000) == 0:
                        c += 1
                        v *= 2
                    ctx.stack.add_i32(c)
                    continue
                if opcode == wasmi.opcodes.I32_CTZ:
                    c = 0
                    while c < 32 and (v % 2) == 0:
                        c += 1
                        v /= 2
                    ctx.stack.add_i32(c)
                    continue
                if opcode == wasmi.opcodes.I32_POPCNT:
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
                    r = num.int2i32(a + b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_SUB:
                    r = num.int2i32(a - b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_MUL:
                    r = num.int2i32(a * b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_DIVS:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    if a == 0x80000000 and b == -1:
                        raise wasmi.error.WAException('integer overflow')
                    r = wasmi.common.idiv_s(a, b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_DIVU:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    r = num.int2u32(a) // num.int2u32(b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_REMS:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    r = wasmi.common.irem_s(a, b)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_REMU:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    r = num.int2u32(a) % num.int2u32(b)
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
                    ctx.stack.add_i32(num.int2u32(a) >> (b % 0x20))
                    continue
                if opcode == wasmi.opcodes.I32_ROTL:
                    r = wasmi.common.rotl_u32(a, b)
                    r = num.int2i32(r)
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_ROTR:
                    r = wasmi.common.rotr_u32(a, b)
                    r = num.int2i32(r)
                    ctx.stack.add_i32(r)
                    continue
            if opcode >= wasmi.opcodes.I64_CLZ and opcode <= wasmi.opcodes.I64_POPCNT:
                v = ctx.stack.pop_i64()
                if opcode == wasmi.opcodes.I64_CLZ:
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
                    c = 0
                    while c < 64 and (v % 2) == 0:
                        c += 1
                        v /= 2
                    ctx.stack.add_i64(c)
                    continue
                if opcode == wasmi.opcodes.I64_POPCNT:
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
                    r = num.int2i64(a + b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_SUB:
                    r = num.int2i64(a - b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_MUL:
                    r = num.int2i64(a * b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_DIVS:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    r = wasmi.common.idiv_s(a, b)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_DIVU:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    r = num.int2u64(a) // num.int2u64(b)
                    r = num.int2i64(r)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_REMS:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    r = wasmi.common.irem_s(a, b)
                    ctx.stack.add_i64(r)
                if opcode == wasmi.opcodes.I64_REMU:
                    if b == 0:
                        raise wasmi.error.WAException('integer divide by zero')
                    r = num.int2u64(a) % num.int2u64(b)
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
                    ctx.stack.add_i64(num.int2u64(a) >> (b % 0x40))
                    continue
                if opcode == wasmi.opcodes.I64_ROTL:
                    r = wasmi.common.rotl_u64(a, b)
                    r = num.int2i64(r)
                    ctx.stack.add_i64(r)
                    continue
                if opcode == wasmi.opcodes.I64_ROTR:
                    r = wasmi.common.rotr_u64(a, b)
                    r = num.int2i64(r)
                    ctx.stack.add_i64(r)
                    continue
            if opcode >= wasmi.opcodes.F32_ABS and opcode <= wasmi.opcodes.F32_SQRT:
                v = ctx.stack.pop_f32()
                if opcode == wasmi.opcodes.F32_ABS:
                    ctx.stack.add_f32(abs(v))
                    continue
                if opcode == wasmi.opcodes.F32_NEG:
                    ctx.stack.add_f32(-v)
                    continue
                if opcode == wasmi.opcodes.F32_CEIL:
                    ctx.stack.add_f32(math.ceil(v))
                    continue
                if opcode == wasmi.opcodes.F32_FLOOR:
                    ctx.stack.add_f32(math.floor(v))
                    continue
                if opcode == wasmi.opcodes.F32_TRUNC:
                    ctx.stack.add_f32(math.trunc(v))
                    continue
                if opcode == wasmi.opcodes.F32_NEAREST:
                    ceil = math.ceil(v)
                    if ceil - v >= 0.5:
                        r = ceil
                    else:
                        r = ceil - 1
                    ctx.stack.add_f32(r)
                    continue
                if opcode == wasmi.opcodes.F32_SQRT:
                    ctx.stack.add_f32(math.sqrt(v))
                    continue
            if opcode >= wasmi.opcodes.F32_ADD and opcode <= wasmi.opcodes.F32_COPYSIGN:
                b = ctx.stack.pop_f32()
                a = ctx.stack.pop_f32()
                if opcode == wasmi.opcodes.F32_ADD:
                    ctx.stack.add_f32(a + b)
                    continue
                if opcode == wasmi.opcodes.F32_SUB:
                    ctx.stack.add_f32(a - b)
                    continue
                if opcode == wasmi.opcodes.F32_MUL:
                    ctx.stack.add_f32(a * b)
                    continue
                if opcode == wasmi.opcodes.F32_DIV:
                    ctx.stack.add_f32(a / b)
                    continue
                if opcode == wasmi.opcodes.F32_MIN:
                    ctx.stack.add_f32(min(a, b))
                    continue
                if opcode == wasmi.opcodes.F32_MAX:
                    ctx.stack.add_f32(max(a, b))
                    continue
                if opcode == wasmi.opcodes.F32_COPYSIGN:
                    ctx.stack.add_f32(math.copysign(a, b))
                    continue
            if opcode >= wasmi.opcodes.F64_ABS and opcode <= wasmi.opcodes.F64_SQRT:
                v = ctx.stack.pop_f64()
                if opcode == wasmi.opcodes.F64_ABS:
                    ctx.stack.add_f64(abs(v))
                    continue
                if opcode == wasmi.opcodes.F64_NEG:
                    ctx.stack.add_f64(-v)
                    continue
                if opcode == wasmi.opcodes.F64_CEIL:
                    ctx.stack.add_f64(math.ceil(v))
                    continue
                if opcode == wasmi.opcodes.F64_FLOOR:
                    ctx.stack.add_f64(math.floor(v))
                    continue
                if opcode == wasmi.opcodes.F64_TRUNC:
                    ctx.stack.add_f64(math.trunc(v))
                    continue
                if opcode == wasmi.opcodes.F64_NEAREST:
                    ceil = math.ceil(v)
                    if ceil - v >= 0.5:
                        r = ceil
                    else:
                        r = ceil - 1
                    ctx.stack.add_f64(r)
                    continue
                if opcode == wasmi.opcodes.F64_SQRT:
                    ctx.stack.add_f64(math.sqrt(v))
                    continue
            if opcode >= wasmi.opcodes.F64_ADD and opcode <= wasmi.opcodes.F64_COPYSIGN:
                b = ctx.stack.pop_f64()
                a = ctx.stack.pop_f64()
                if opcode == wasmi.opcodes.F64_ADD:
                    ctx.stack.add_f64(a + b)
                    continue
                if opcode == wasmi.opcodes.F64_SUB:
                    ctx.stack.add_f64(a - b)
                    continue
                if opcode == wasmi.opcodes.F64_MUL:
                    ctx.stack.add_f64(a * b)
                    continue
                if opcode == wasmi.opcodes.F64_DIV:
                    ctx.stack.add_f64(a / b)
                    continue
                if opcode == wasmi.opcodes.F64_MIN:
                    ctx.stack.add_f64(min(a, b))
                    continue
                if opcode == wasmi.opcodes.F64_MAX:
                    ctx.stack.add_f64(max(a, b))
                    continue
                if opcode == wasmi.opcodes.F64_COPYSIGN:
                    ctx.stack.add_f64(math.copysign(a, b))
                    continue
            if opcode >= wasmi.opcodes.I32_WRAP_I64 and opcode <= wasmi.opcodes.F64_PROMOTE_F32:
                v = ctx.stack.pop()
                if opcode == wasmi.opcodes.I32_WRAP_I64:
                    r = num.int2i32(v.into_i64())
                    ctx.stack.add_i32(r)
                    continue
                if opcode == wasmi.opcodes.I32_TRUNC_SF32:
                    v = v.into_f32()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    if v > 2**31 - 1 or v < -2**32:
                        raise wasmi.error.WAException('integer overflow')
                    ctx.stack.add_i32(int(v))
                    continue
                if opcode == wasmi.opcodes.I32_TRUNC_UF32:
                    v = v.into_f32()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    if v > 2 ** 32 - 1 or v < -1:
                        raise wasmi.error.WAException('integer overflow')
                    ctx.stack.add_i32(int(v))
                    continue
                if opcode == wasmi.opcodes.I32_TRUNC_SF64:
                    v = v.into_f64()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    if v > 2**31 - 1 or v < -2**31:
                        raise wasmi.error.WAException('integer overflow')
                    ctx.stack.add_i32(int(v))
                    continue
                if opcode == wasmi.opcodes.I32_TRUNC_UF64:
                    v = v.into_f64()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    if v > 2**32 - 1 or v < -1:
                        raise wasmi.error.WAException('integer overflow')
                    ctx.stack.add_i32(int(v))
                    continue
                if opcode == wasmi.opcodes.I64_EXTEND_SI32:
                    v = v.into_i32()
                    ctx.stack.add_i64(v)
                    continue
                if opcode == wasmi.opcodes.I64_EXTEND_UI32:
                    v = v.into_u32()
                    ctx.stack.add_i64(v)
                    continue
                if opcode == wasmi.opcodes.I64_TRUNC_SF32:
                    v = v.into_f32()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    if v > 2**63 - 1 or v < -2**63:
                        raise wasmi.error.WAException('integer overflow')
                    ctx.stack.add_i64(int(v))
                    continue
                if opcode == wasmi.opcodes.I64_TRUNC_UF32:
                    v = v.into_f32()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    if v > 2**63 - 1 or v < -1:
                        raise wasmi.error.WAException('integer overflow')
                    ctx.stack.add_i64(int(v))
                    continue
                if opcode == wasmi.opcodes.I64_TRUNC_SF64:
                    v = v.into_f64()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    ctx.stack.add_i64(int(v))
                    continue
                if opcode == wasmi.opcodes.I64_TRUNC_UF64:
                    v = v.into_f64()
                    if math.isnan(v):
                        raise wasmi.error.WAException("invalid conversion to integer")
                    if v < -1:
                        raise wasmi.error.WAException('integer overflow')
                    ctx.stack.add_i64(int(v))
                    continue
                if opcode == wasmi.opcodes.F32_CONVERT_SI32:
                    v = v.into_i32()
                    ctx.stack.add_f32(v)
                    continue
                if opcode == wasmi.opcodes.F32_CONVERT_UI32:
                    v = v.into_u32()
                    ctx.stack.add_f32(r)
                    continue
                if opcode == wasmi.opcodes.F32_CONVERT_SI64:
                    v = v.into_i64()
                    ctx.stack.add_f32(v)
                    continue
                if opcode == wasmi.opcodes.F32_CONVERT_UI64:
                    v = v.into_u64()
                    ctx.stack.add_f32(v)
                    continue
                if opcode == wasmi.opcodes.F32_DEMOTE_F64:
                    v = v.into_f64()
                    ctx.stack.add_f32(v)
                    continue
                if opcode == wasmi.opcodes.F64_CONVERT_SI32:
                    v = v.into_i32()
                    ctx.stack.add_f64(v)
                    continue
                if opcode == wasmi.opcodes.F64_CONVERT_UI32:
                    v = v.into_u32()
                    ctx.stack.add_f64(v)
                    continue
                if opcode == wasmi.opcodes.F64_CONVERT_SI64:
                    v = v.into_i64()
                    ctx.stack.add_f64(v)
                    continue
                if opcode == wasmi.opcodes.F64_CONVERT_UI64:
                    v = v.into_u64()
                    ctx.stack.add_f64(v)
                    continue
                if opcode == wasmi.opcodes.F64_PROMOTE_F32:
                    v = v.into_f32()
                    ctx.stack.add_f64(v)
                    continue
            if opcode >= wasmi.opcodes.I32_REINTERPRET_F32 and opcode <= wasmi.opcodes.F64_REINTERPRET_I64:
                if opcode == wasmi.opcodes.I32_REINTERPRET_F32:
                    ctx.stack.add_i32(num.f322i32(ctx.stack.pop().into_f32()))
                    continue
                if opcode == wasmi.opcodes.I64_REINTERPRET_F64:
                    ctx.stack.add_i64(num.f642i64(ctx.stack.pop().into_f64()))
                    continue
                if opcode == wasmi.opcodes.F32_REINTERPRET_I32:
                    ctx.stack.add_f32(num.i322f32(ctx.stack.pop().into_i32()))
                    continue
                if opcode == wasmi.opcodes.F64_REINTERPRET_I64:
                    ctx.stack.add_f64(num.i642f64(ctx.stack.pop().into_i64()))
                    continue

    def exec(self, name: str, args: typing.List):
        export: wasmi.section.Export = None
        for e in self.mod.section_export.entries:
            if e.kind == wasmi.opcodes.EXTERNAL_FUNCTION and e.name == name:
                export = e
                break
        if not export:
            raise wasmi.error.WAException(f'function not found')
        f_idx = export.idx
        f_sig = self.functions[f_idx].signature
        ergs = []
        for i, kind in enumerate(f_sig.args):
            ergs.append(wasmi.stack.Entry.from_val(args[i], kind))
        ctx = Ctx(ergs)
        wasmi.log.println('Exec'.center(80, '-'))
        return self.exec_step(f_idx, ctx)
