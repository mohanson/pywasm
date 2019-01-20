import typing

from pywasm import convention
from pywasm import log
from pywasm import num
from pywasm import structure


class Store:
    # The store represents all global state that can be manipulated by WebAssembly programs. It consists of the runtime
    # representation of all instances of functions, tables, memories, and globals that have been allocated during the
    # life time of the abstract machine
    # Syntactically, the store is defined as a record listing the existing instances of each category:
    # store ::= {
    #     funcs funcinst∗
    #     tables tableinst∗
    #     mems meminst∗
    #     globals globalinst∗
    # }
    #
    # Addresses are dynamic, globally unique references to runtime objects, in contrast to indices, which are static,
    # module-local references to their original definitions. A memory address memaddr denotes the abstract address of
    # a memory instance in the store, not an offset inside a memory instance.
    def __init__(self):
        self.funcs: typing.List[FunctionInstance] = []
        self.tables: typing.List[TableInstance] = []
        self.mems: typing.List[MemoryInstance] = []
        self.globals: typing.List[GlobalInstance] = []


class FunctionInstance:
    # A function instance is the runtime representation of a function. It effectively is a closure of the original
    # function over the runtime module instance of its originating module. The module instance is used to resolve
    # references to other definitions during execution of the function.
    #
    # funcinst ::= {type functype,module moduleinst,code func}
    #            | {type functype,hostcode hostfunc}
    # hostfunc ::= ...
    pass


class WasmFunc(FunctionInstance):
    def __init__(self,
                 functype: structure.FunctionType,
                 module: 'ModuleInstance',
                 code: structure.Function
                 ):
        self.functype = functype
        self.module = module
        self.code = code


class HostFunc(FunctionInstance):
    # A host function is a function expressed outside WebAssembly but passed to a module as an import. The definition
    # and behavior of host functions are outside the scope of this specification. For the purpose of this
    # specification, it is assumed that when invoked, a host function behaves non-deterministically, but within certain
    # constraints that ensure the integrity of the runtime.
    def __init__(self, functype: structure.FunctionType, hostcode: typing.Callable):
        self.functype = functype
        self.hostcode = hostcode


class TableInstance:
    # A table instance is the runtime representation of a table. It holds a vector of function elements and an optional
    # maximum size, if one was specified in the table type at the table’s definition site.
    #
    # Each function element is either empty, representing an uninitialized table entry, or a function address. Function
    # elements can be mutated through the execution of an element segment or by external means provided by the embedder.
    #
    # tableinst ::= {elem vec(funcelem), max u32?}
    # funcelem ::= funcaddr?
    #
    # It is an invariant of the semantics that the length of the element vector never exceeds the maximum size, if
    # present.
    def __init__(self, elemtype: int, limits: structure.Limits):
        self.elemtype = elemtype
        self.limits = limits
        self.elem = [None for _ in range(limits.minimum)]


class MemoryInstance:
    # A memory instance is the runtime representation of a linear memory. It holds a vector of bytes and an optional
    # maximum size, if one was specified at the definition site of the memory.
    #
    # meminst ::= {data vec(byte), max u32?}
    #
    # The length of the vector always is a multiple of the WebAssembly page size, which is defined to be the constant
    # 65536 – abbreviated 64Ki. Like in a memory type, the maximum size in a memory instance is given in units of this
    # page size.
    #
    # The bytes can be mutated through memory instructions, the execution of a data segment, or by external means
    # provided by the embedder.
    #
    # It is an invariant of the semantics that the length of the byte vector, divided by page size, never exceeds the
    # maximum size, if present.
    def __init__(self, limits: structure.Limits):
        self.limits = limits
        self.data = bytearray([0x00 for _ in range(limits.minimum * 64 * 1024)])


class GlobalInstance:
    # A global instance is the runtime representation of a global variable. It holds an individual value and a flag
    # indicating whether it is mutable.
    #
    # globalinst ::= {value val, mut mut}
    #
    # The value of mutable globals can be mutated through variable instructions or by external means provided by the
    # embedder.
    def __init__(self, value: 'Value', mut: bool):
        self.value = value
        self.mut = mut


class ExportInstance:
    # An export instance is the runtime representation of an export. It defines the export’s name and the associated
    # external value.
    #
    # exportinst ::= {name name, value externval}
    def __init__(self, name: str, value: 'ExternValue'):
        self.name = name
        self.value = value


class ExternValue:
    # An external value is the runtime representation of an entity that can be imported or exported. It is an address
    # denoting either a function instance, table instance, memory instance, or global instances in the shared store.
    #
    # externval ::= func funcaddr
    #             | table tableaddr
    #             | mem memaddr
    #             | global globaladdr
    def __init__(self, extern_type: int, addr: int):
        self.extern_type = extern_type
        self.addr = addr


class Value:
    # Values are represented by themselves.
    def __init__(self, valtype: int, n):
        self.valtype = valtype
        self.n = n

    @classmethod
    def from_i32(cls, n):
        return Value(convention.i32, n)

    @classmethod
    def from_i64(cls, n):
        return Value(convention.i64, n)

    @classmethod
    def from_f32(cls, n):
        return Value(convention.f32, n)

    @classmethod
    def from_f64(cls, n):
        return Value(convention.f64, n)


class Label:
    # Labels carry an argument arity n and their associated branch target, which is expressed syntactically as an
    # instruction sequence:
    #
    # label ::= labeln{instr∗}
    #
    # Intuitively, instr∗ is the continuation to execute when the branch is taken, in place of the original control
    # construct.
    pass


class Frame:
    # Activation frames carry the return arity of the respective function, hold the values of its locals (including
    # arguments) in the order corresponding to their static local indices, and a reference to the function’s own module
    # instance:
    #
    # activation ::= framen{frame}
    # frame ::= {locals val∗, module moduleinst}
    def __init__(self, module: 'ModuleInstance', locs: typing.List[Value]):
        self.module = module
        self.locals = locs


class Stack:
    # Besides the store, most instructions interact with an implicit stack. The stack contains three kinds of entries:
    #
    # Values: the operands of instructions.
    # Labels: active structured control instructions that can be targeted by branches.
    # Activations: the call frames of active function calls.
    #
    # These entries can occur on the stack in any order during the execution of a program. Stack entries are described
    # by abstract syntax as follows.
    def __init__(self):
        self.data = []

    def add(self, e):
        self.data.append(e)

    def pop(self):
        return self.data.pop()

    def len(self):
        return len(self.data)


class AdministrativeInstruction:
    pass


class BlockContext:
    pass


class Configuration:
    # A configuration consists of the current store and an executing thread.
    #
    # A thread is a computation over instructions that operates relative to a current frame referring to the home
    # module instance that the computation runs in.
    #
    # config ::= store;thread
    # thread ::= frame;instr∗
    pass


class EvaluationContext:
    # Finally, the following definition of evaluation context and associated structural rules enable reduction inside
    # instruction sequences and administrative forms as well as the propagation of traps.
    pass


def import_matching_limits(limits1: structure.Limits, limits2: structure.Limits):
    n1 = limits1.minimum
    m1 = limits1.maximum
    n2 = limits2.minimum
    m2 = limits2.maximum
    if n1 < n2:
        return False
    if m2 is None or (m1 != None and m2 != None and m1 <= m2):
        return True
    return False


class ModuleInstance:
    # A module instance is the runtime representation of a module. It is created by instantiating a module, and
    # collects runtime representations of all entities that are imported, defined, or exported by the module.
    #
    # moduleinst ::= {
    #     types functype∗
    #     funcaddrs funcaddr∗
    #     tableaddrs tableaddr∗
    #     memaddrs memaddr∗
    #     globaladdrs globaladdr∗
    #     exports exportinst∗
    # }
    def __init__(self):
        self.types: typing.List[structure.FunctionType] = []
        self.funcaddrs: typing.List[int] = []
        self.tableaddrs: typing.List[int] = []
        self.memaddrs: typing.List[int] = []
        self.globaladdrs: typing.List[int] = []
        self.exports: typing.List[ExportInstance] = []

    def instantiate(
        self,
        module: structure.Module,
        store: Store,
        externvals: typing.List[ExternValue] = None,
    ):
        # [TODO] If module is not valid, then panic
        # Assert: module is valid with external types classifying its imports
        for e in module.imports:
            assert e.kind in convention.extern_type
        # Assert: number m of imports is equal to the number n of provided external values
        assert len(module.imports) == len(externvals)
        # Assert: externvals matching imports of module
        for i in range(len(externvals)):
            e = externvals[i]
            assert e.extern_type in convention.extern_type
            if e.extern_type == convention.extern_func:
                a = store.funcs[e.addr]
                b = self.types[module.imports[i].desc]
                assert a.functype.args == b.args
                assert a.functype.rets == b.rets
            elif e.extern_type == convention.extern_table:
                a = store.tables[e.addr]
                b = module.imports[i].desc
                assert a.elemtype == b.elemtype
                assert import_matching_limits(b.limits, a.limits)
            elif e.extern_type == convention.extern_mem:
                a = store.mems[e.addr]
                b = module.imports[i].desc
                assert import_matching_limits(b, a)
            elif e.extern_type == convention.extern_global:
                a = store.globals[e.addr]
                b = module.imports[i].desc
                assert a.value.valtype == b.valtype
        # Let vals be the vector of global initialization values determined by module and externvaln
        auxmod = ModuleInstance()
        auxmod.globaladdrs = [e.addr for e in externvals if e.extern_type == convention.extern_global]
        stack = Stack()
        frame = Frame(auxmod, [])
        stack.add(frame)
        vals = []
        for glob in module.globals:
            v = invoke(auxmod, store, stack, glob.expr, [convention.i32])[0]
            vals.append(v)
        # Assert: due to validation, the frame F is now on the top of the stack.
        assert isinstance(stack.pop(), Frame)
        # Allocation
        self.allocate(module, store, externvals, vals)

        frame = Frame(self, [])
        stack.add(frame)
        # For each element segment in module.elem, do:
        for e in module.elem:
            offset = invoke(self, store, stack, e.expr, [convention.i32])
            assert offset.valtype == convention.i32
            t = store.tables[self.tableaddrs[e.tableidx]]
            for i, e in enumerate(e.init):
                t.elem[offset + i] = e
        # For each data segment in module.data, do:
        for e in module.data:
            offset = invoke(self, store, stack, e.expr, [convention.i32])
            assert offset.valtype == convention.i32
            m = store.mems[self.memaddrs[e.memidx]]
            end = offset + len(e.init)
            assert end <= len(m.data)
            m.data[offset: offset + len(e.init)] = e.init
        # Assert: due to validation, the frame F is now on the top of the stack.
        assert isinstance(stack.pop(), Frame)
        # If the start function module.start is not empty, invoke the function instance
        if module.start is not None:
            frame = Frame(self, [])
            stack.add(frame)
            func = store.funcs[self.funcaddrs[module.start]]
            invoke(self, store, stack, func.code.expr, [convention.i32])
            assert isinstance(stack.pop(), Frame)

    def allocate(
        self,
        module: structure.Module,
        store: Store,
        externvals: typing.List[ExternValue],
        vals: typing.List[Value],
    ):
        self.types = module.types
        # Imports
        self.funcaddrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_func])
        self.tableaddrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_table])
        self.memaddrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_mem])
        self.globaladdrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_global])
        # For each function func in module.funcs, do:
        for func in module.funcs:
            functype = self.types[func.typeidx]
            funcinst = WasmFunc(functype, self, func)
            store.funcs.append(funcinst)
            self.funcaddrs.append(len(store.funcs) - 1)
        # For each table in module.tables, do:
        for table in module.tables:
            tabletype = table.tabletype
            elemtype = tabletype.elemtype
            tableinst = TableInstance(elemtype, tabletype.limits)
            store.tables.append(tableinst)
            self.tableaddrs.append(len(store.tables) - 1)
        # For each memory module.mems, do:
        for mem in module.mems:
            meminst = MemoryInstance(mem.memtype)
            store.mems.append(meminst)
            self.memaddrs.append(len(store.mems) - 1)
        # For each global in module.globals, do:
        for i, glob in enumerate(module.globals):
            val = vals[i]
            if val.valtype != glob.globaltype.valtype:
                log.panicln('pywasm: mismatch valtype')
            globalinst = GlobalInstance(val, glob.globaltype.mut)
            store.globals.append(globalinst)
            self.globaladdrs.append(len(store.globals) - 1)
        # For each export in module.exports, do:
        for i, export in enumerate(module.exports):
            externval = ExternValue(export.kind, export.desc)
            exportinst = ExportInstance(export.name, externval)
            self.exports.append(exportinst)


def invoke(
    module: ModuleInstance,
    store: Store,
    stack: Stack,
    expr: structure.Expression,
    rets: typing.List[int],
):
    frame: Frame = stack.data[-1]
    if not expr.data:
        log.panicln('pywasm: empty init expr')
    for i in expr.data:
        opcode = i.code
        # if opcode == wasmi.spec.op.UNREACHABLE:
        #     raise wasmi.error.WAException('reached unreachable')
        # if opcode == wasmi.spec.op.NOP:
        #     continue
        # if opcode == wasmi.spec.op.BLOCK:
        #     n, _, _ = wasmi.common.read_leb(code[pc:], 32)
        #     b = f_sec.bmap[pc - 1]
        #     pc += n
        #     ctx.ctack.append([b, ctx.stack.i])
        #     continue
        # if opcode == wasmi.spec.op.LOOP:
        #     n, _, _ = wasmi.common.read_leb(code[pc:], 32)
        #     b = f_sec.bmap[pc - 1]
        #     pc += n
        #     ctx.ctack.append([b, ctx.stack.i])
        #     continue
        # if opcode == wasmi.spec.op.IF:
        #     n, _, _ = wasmi.common.read_leb(code[pc:], 32)
        #     b = f_sec.bmap[pc - 1]
        #     pc += n
        #     ctx.ctack.append([b, ctx.stack.i])
        #     cond = ctx.stack.pop_i32()
        #     if cond:
        #         continue
        #     if b.pos_else == 0:
        #         ctx.ctack.pop()
        #         pc = b.pos_br + 1
        #         continue
        #     pc = b.pos_else
        #     continue
        # if opcode == wasmi.spec.op.ELSE:
        #     b, _ = ctx.ctack[-1]
        #     pc = b.pos_br
        #     continue
        # if opcode == wasmi.spec.op.END:
        #     b, sp = ctx.ctack.pop()
        #     if isinstance(b, wasmi.section.Code):
        #         if not ctx.ctack:
        #             if f_sig.rets:
        #                 if f_sig.rets[0] != ctx.stack.top().valtype:
        #                     raise wasmi.error.WAException('signature mismatch in call_indirect')
        #                 return ctx.stack.pop().n
        #             return None
        #         return
        #     if sp < ctx.stack.i:
        #         v = ctx.stack.pop()
        #         ctx.stack.i = sp
        #         ctx.stack.add(v)
        #     continue
        # if opcode == wasmi.spec.op.BR:
        #     n, c, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     for _ in range(c):
        #         ctx.ctack.pop()
        #     b, _ = ctx.ctack[-1]
        #     pc = b.pos_br
        #     continue
        # if opcode == wasmi.spec.op.BR_IF:
        #     n, br_depth, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     cond = ctx.stack.pop_i32()
        #     if cond:
        #         for _ in range(br_depth):
        #             ctx.ctack.pop()
        #         b, _ = ctx.ctack[-1]
        #         pc = b.pos_br
        #     continue
        # if opcode == wasmi.spec.op.BR_TABLE:
        #     n, lcount, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     depths = []
        #     for c in range(lcount):
        #         n, ldepth, _ = wasmi.common.read_leb(code[pc:], 32)
        #         pc += n
        #         depths.append(ldepth)
        #     n, ddepth, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     didx = ctx.stack.pop_i32()
        #     if didx >= 0 and didx < len(depths):
        #         ddepth = depths[didx]
        #     for _ in range(ddepth):
        #         ctx.ctack.pop()
        #     b, _ = ctx.ctack[-1]
        #     pc = b.pos_br
        #     continue
        # if opcode == wasmi.spec.op.RETURN:
        #     while ctx.ctack:
        #         if isinstance(ctx.ctack[-1][0], wasmi.section.Code):
        #             break
        #         ctx.ctack.pop()
        #     b, _ = ctx.ctack[-1]
        #     pc = len(b.expr.data) - 1
        #     continue
        # if opcode == wasmi.spec.op.CALL:
        #     n, f_idx, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     son_f_fun = self.functions[f_idx]
        #     son_f_sig = son_f_fun.signature
        #     if son_f_fun.envb:
        #         name = son_f_fun.module + '.' + son_f_fun.name
        #         func = self.env.import_func[name]
        #         r = func(self.mem, [ctx.stack.pop() for _ in son_f_sig.args][::-1])
        #         e = wasmi.stack.Entry(son_f_sig.rets[0], r)
        #         ctx.stack.add(e)
        #         continue
        #     pre_locals_data = ctx.locals_data
        #     ctx.locals_data = [ctx.stack.pop() for _ in son_f_sig.args][::-1]
        #     self.exec_step(f_idx, ctx)
        #     ctx.locals_data = pre_locals_data
        #     continue
        # if opcode == wasmi.spec.op.CALL_INDIRECT:
        #     n, _, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     n, _, _ = wasmi.common.read_leb(code[pc:], 1)
        #     pc += n
        #     t_idx = ctx.stack.pop_i32()
        #     if not 0 <= t_idx < len(self.table[wasmi.spec.valtype.FUNCREF]):
        #         raise wasmi.error.WAException('undefined element index')
        #     f_idx = self.table[wasmi.spec.valtype.FUNCREF][t_idx]
        #     son_f_fun = self.functions[f_idx]
        #     son_f_sig = son_f_fun.signature
        #     a = list(son_f_sig.args)
        #     b = [ctx.stack.pop() for _ in son_f_sig.args][::-1]
        #     for i in range(len(a)):
        #         ia = a[i]
        #         ib = b[i]
        #         if not ib or ia != ib.valtype:
        #             raise wasmi.error.WAException('signature mismatch in call_indirect')
        #     pre_locals_data = ctx.locals_data
        #     ctx.locals_data = b
        #     self.exec_step(f_idx, ctx)
        #     ctx.locals_data = pre_locals_data
        #     continue
        # if opcode == wasmi.spec.op.DROP:
        #     ctx.stack.pop()
        #     continue
        # if opcode == wasmi.spec.op.SELECT:
        #     cond = ctx.stack.pop_i32()
        #     a = ctx.stack.pop()
        #     b = ctx.stack.pop()
        #     if cond:
        #         ctx.stack.add(b)
        #     else:
        #         ctx.stack.add(a)
        #     continue
        if opcode == convention.get_local:
            stack.add(frame.locals[i.immediate_arguments])
            continue
        # if opcode == wasmi.spec.op.SET_LOCAL:
        #     v = ctx.stack.pop()
        #     n, i, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     if i >= len(ctx.locals_data):
        #         ctx.locals_data.extend(
        #             [wasmi.stack.Entry.from_i32(0) for _ in range(i - len(ctx.locals_data) + 1)]
        #         )
        #     ctx.locals_data[i] = v
        #     continue
        # if opcode == wasmi.spec.op.TEE_LOCAL:
        #     v = ctx.stack.top()
        #     n, i, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     ctx.locals_data[i] = v
        #     continue
        # if opcode == wasmi.spec.op.GET_GLOBAL:
        #     n, i, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     ctx.stack.add(self.global_data[i])
        #     continue
        # if opcode == wasmi.spec.op.SET_GLOBAL:
        #     v = ctx.stack.pop()
        #     n, i, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     self.global_data[i] = v
        #     continue
        # if opcode >= wasmi.spec.op.I32_LOAD and opcode <= wasmi.spec.op.I64_LOAD32_U:
        #     # memory_immediate has two fields, the alignment and the offset.
        #     # The former is simply an optimization hint and can be safely
        #     # discarded.
        #     pc += 1
        #     n, mem_offset, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     a = ctx.stack.pop_i64() + mem_offset
        #     if a + wasmi.spec.op.info[opcode][2] > len(self.mem):
        #         raise wasmi.error.WAException('out of bounds memory access')
        #     if opcode == wasmi.spec.op.I32_LOAD:
        #         r = wasmi.num.LittleEndian.i32(self.mem[a:a + 4])
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_LOAD:
        #         r = wasmi.num.LittleEndian.i64(self.mem[a:a + 8])
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.F32_LOAD:
        #         r = wasmi.num.LittleEndian.f32(self.mem[a:a + 4])
        #         ctx.stack.add_f32(r)
        #         continue
        #     if opcode == wasmi.spec.op.F64_LOAD:
        #         r = wasmi.num.LittleEndian.f64(self.mem[a:a + 8])
        #         ctx.stack.add_f64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_LOAD8_S:
        #         r = wasmi.num.LittleEndian.i8(self.mem[a:a + 1])
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_LOAD8_U:
        #         r = wasmi.num.LittleEndian.u8(self.mem[a:a + 1])
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_LOAD16_S:
        #         r = wasmi.num.LittleEndian.i16(self.mem[a:a + 2])
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_LOAD16_U:
        #         r = wasmi.num.LittleEndian.u16(self.mem[a:a + 2])
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_LOAD8_S:
        #         r = wasmi.num.LittleEndian.i8(self.mem[a:a + 1])
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_LOAD8_U:
        #         r = wasmi.num.LittleEndian.u8(self.mem[a:a + 1])
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_LOAD16_S:
        #         r = wasmi.num.LittleEndian.i16(self.mem[a:a + 2])
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_LOAD16_U:
        #         r = wasmi.num.LittleEndian.u16(self.mem[a:a + 2])
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_LOAD32_S:
        #         r = wasmi.num.LittleEndian.i32(self.mem[a:a + 4])
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_LOAD32_U:
        #         r = wasmi.num.LittleEndian.u32(self.mem[a:a + 4])
        #         ctx.stack.add_i64(r)
        #         continue
        # if opcode >= wasmi.spec.op.I32_STORE and opcode <= wasmi.spec.op.I64_STORE32:
        #     v = ctx.stack.pop()
        #     pc += 1
        #     n, mem_offset, _ = wasmi.common.read_leb(code[pc:], 32)
        #     pc += n
        #     a = ctx.stack.pop_i64() + mem_offset
        #     if a + wasmi.spec.op.info[opcode][2] > len(self.mem):
        #         raise wasmi.error.WAException('out of bounds memory access')
        #     if opcode == wasmi.spec.op.I32_STORE:
        #         self.mem[a:a + 4] = wasmi.num.LittleEndian.pack_i32(v.into_i32())
        #         continue
        #     if opcode == wasmi.spec.op.I64_STORE:
        #         self.mem[a:a + 8] = wasmi.num.LittleEndian.pack_i64(v.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.F32_STORE:
        #         self.mem[a:a + 4] = wasmi.num.LittleEndian.pack_f32(v.into_f32())
        #         continue
        #     if opcode == wasmi.spec.op.F64_STORE:
        #         self.mem[a:a + 8] = wasmi.num.LittleEndian.pack_f64(v.into_f64())
        #         continue
        #     if opcode == wasmi.spec.op.I32_STORE8:
        #         self.mem[a:a + 1] = wasmi.num.LittleEndian.pack_i8(wasmi.num.int2i8(v.into_i32()))
        #         continue
        #     if opcode == wasmi.spec.op.I32_STORE16:
        #         self.mem[a:a + 2] = wasmi.num.LittleEndian.pack_i16(wasmi.num.int2i16(v.into_i32()))
        #         continue
        #     if opcode == wasmi.spec.op.I64_STORE8:
        #         self.mem[a:a + 1] = wasmi.num.LittleEndian.pack_i8(wasmi.num.int2i8(v.into_i64()))
        #         continue
        #     if opcode == wasmi.spec.op.I64_STORE16:
        #         self.mem[a:a + 2] = wasmi.num.LittleEndian.pack_i16(wasmi.num.int2i16(v.into_i64()))
        #         continue
        #     if opcode == wasmi.spec.op.I64_STORE32:
        #         self.mem[a:a + 4] = wasmi.num.LittleEndian.pack_i32(wasmi.num.int2i32(v.into_i64()))
        #         continue
        # if opcode == wasmi.spec.op.CURRENT_MEMORY:
        #     pc += 1
        #     ctx.stack.add_i32(self.mem_len)
        #     continue
        # if opcode == wasmi.spec.op.GROW_MEMORY:
        #     pc += 1
        #     cur_len = self.mem_len
        #     n = ctx.stack.pop_i32()
        #     self.mem_len += n
        #     self.mem.extend([0 for _ in range(n * 64 * 1024)])
        #     ctx.stack.add_i32(cur_len)
        #     continue
        # if opcode >= wasmi.spec.op.I32_CONST and opcode <= wasmi.spec.op.F64_CONST:
        #     if opcode == wasmi.spec.op.I32_CONST:
        #         n, r, _ = wasmi.common.read_leb(code[pc:], 32, True)
        #         pc += n
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_CONST:
        #         n, r, _ = wasmi.common.read_leb(code[pc:], 64, True)
        #         pc += n
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.F32_CONST:
        #         r = wasmi.common.read_f32(code[pc:])
        #         pc += 4
        #         ctx.stack.add_f32(r)
        #         continue
        #     if opcode == wasmi.spec.op.F64_CONST:
        #         r = wasmi.common.read_f64(code[pc:])
        #         pc += 8
        #         ctx.stack.add_f64(r)
        #         continue
        # if opcode == wasmi.spec.op.I32_EQZ:
        #     ctx.stack.add_i32(ctx.stack.pop_i32() == 0)
        #     continue
        # if opcode >= wasmi.spec.op.I32_EQ and opcode <= wasmi.spec.op.I32_GEU:
        #     b = ctx.stack.pop()
        #     a = ctx.stack.pop()
        #     if opcode == wasmi.spec.op.I32_EQ:
        #         ctx.stack.add_i32(a.into_i32() == b.into_i32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_NE:
        #         ctx.stack.add_i32(a.into_i32() != b.into_i32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_LTS:
        #         ctx.stack.add_i32(a.into_i32() < b.into_i32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_LTU:
        #         ctx.stack.add_i32(a.into_u32() < b.into_u32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_GTS:
        #         ctx.stack.add_i32(a.into_i32() > b.into_i32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_GTU:
        #         ctx.stack.add_i32(a.into_u32() > b.into_u32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_LES:
        #         ctx.stack.add_i32(a.into_i32() <= b.into_i32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_LEU:
        #         ctx.stack.add_i32(a.into_u32() <= b.into_u32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_GES:
        #         ctx.stack.add_i32(a.into_i32() >= b.into_i32())
        #         continue
        #     if opcode == wasmi.spec.op.I32_GEU:
        #         ctx.stack.add_i32(a.into_u32() >= b.into_u32())
        #         continue
        # if opcode == wasmi.spec.op.I64_EQZ:
        #     ctx.stack.add_i32(ctx.stack.pop_i64() == 0)
        #     continue
        # if opcode >= wasmi.spec.op.I64_EQ and opcode <= wasmi.spec.op.I64_GEU:
        #     b = ctx.stack.pop()
        #     a = ctx.stack.pop()
        #     if opcode == wasmi.spec.op.I64_EQ:
        #         ctx.stack.add_i32(a.into_i64() == b.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_NE:
        #         ctx.stack.add_i32(a.into_i64() != b.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_LTS:
        #         ctx.stack.add_i32(a.into_i64() < b.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_LTU:
        #         ctx.stack.add_i32(a.into_u64() < b.into_u64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_GTS:
        #         ctx.stack.add_i32(a.into_i64() > b.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_GTU:
        #         ctx.stack.add_i32(a.into_u64() > b.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_LES:
        #         ctx.stack.add_i32(a.into_i64() <= b.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_LEU:
        #         ctx.stack.add_i32(a.into_u64() <= b.into_u64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_GES:
        #         ctx.stack.add_i32(a.into_i64() >= b.into_i64())
        #         continue
        #     if opcode == wasmi.spec.op.I64_GEU:
        #         ctx.stack.add_i32(a.into_u64() >= b.into_u64())
        #         continue
        # if opcode >= wasmi.spec.op.F32_EQ and opcode <= wasmi.spec.op.F64_GE:
        #     b = ctx.stack.pop()
        #     a = ctx.stack.pop()
        #     if opcode == wasmi.spec.op.F32_EQ:
        #         ctx.stack.add_i32(a.into_f32() == b.into_f32())
        #         continue
        #     if opcode == wasmi.spec.op.F32_NE:
        #         ctx.stack.add_i32(a.into_f32() != b.into_f32())
        #         continue
        #     if opcode == wasmi.spec.op.F32_LT:
        #         ctx.stack.add_i32(a.into_f32() < b.into_f32())
        #         continue
        #     if opcode == wasmi.spec.op.F32_GT:
        #         ctx.stack.add_i32(a.into_f32() > b.into_f32())
        #         continue
        #     if opcode == wasmi.spec.op.F32_LE:
        #         ctx.stack.add_i32(a.into_f32() <= b.into_f32())
        #         continue
        #     if opcode == wasmi.spec.op.F32_GE:
        #         ctx.stack.add_i32(a.into_f32() >= b.into_f32())
        #         continue
        #     if opcode == wasmi.spec.op.F64_EQ:
        #         ctx.stack.add_i32(a.into_f64() == b.into_f64())
        #         continue
        #     if opcode == wasmi.spec.op.F64_NE:
        #         ctx.stack.add_i32(a.into_f64() != b.into_f64())
        #         continue
        #     if opcode == wasmi.spec.op.F64_LT:
        #         ctx.stack.add_i32(a.into_f64() < b.into_f64())
        #         continue
        #     if opcode == wasmi.spec.op.F64_GT:
        #         ctx.stack.add_i32(a.into_f64() > b.into_f64())
        #         continue
        #     if opcode == wasmi.spec.op.F64_LE:
        #         ctx.stack.add_i32(a.into_f64() <= b.into_f64())
        #         continue
        #     if opcode == wasmi.spec.op.F64_GE:
        #         ctx.stack.add_i32(a.into_f64() >= b.into_f64())
        #         continue
        # if opcode >= wasmi.spec.op.I32_CLZ and opcode <= wasmi.spec.op.I32_POPCNT:
        #     v = ctx.stack.pop_i32()
        #     if opcode == wasmi.spec.op.I32_CLZ:
        #         c = 0
        #         while c < 32 and (v & 0x80000000) == 0:
        #             c += 1
        #             v *= 2
        #         ctx.stack.add_i32(c)
        #         continue
        #     if opcode == wasmi.spec.op.I32_CTZ:
        #         c = 0
        #         while c < 32 and (v % 2) == 0:
        #             c += 1
        #             v /= 2
        #         ctx.stack.add_i32(c)
        #         continue
        #     if opcode == wasmi.spec.op.I32_POPCNT:
        #         c = 0
        #         for i in range(32):
        #             if 0x1 & v:
        #                 c += 1
        #             v /= 2
        #         ctx.stack.add_i32(c)
        #         continue
        if opcode >= convention.i32_add and opcode <= convention.i32_rotr:
            b = stack.pop().n
            a = stack.pop().n
            if opcode == convention.i32_add:
                stack.add(Value.from_i32(num.int2i32(a + b)))
                continue
        #     if opcode == wasmi.spec.op.I32_SUB:
        #         r = wasmi.num.int2i32(a - b)
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_MUL:
        #         r = wasmi.num.int2i32(a * b)
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_DIVS:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         if a == 0x80000000 and b == -1:
        #             raise wasmi.error.WAException('integer overflow')
        #         r = wasmi.common.idiv_s(a, b)
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_DIVU:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         r = wasmi.num.int2u32(a) // wasmi.num.int2u32(b)
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_REMS:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         r = wasmi.common.irem_s(a, b)
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_REMU:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         r = wasmi.num.int2u32(a) % wasmi.num.int2u32(b)
        #         continue
        #     if opcode == wasmi.spec.op.I32_AND:
        #         ctx.stack.add_i32(a & b)
        #         continue
        #     if opcode == wasmi.spec.op.I32_OR:
        #         ctx.stack.add_i32(a | b)
        #         continue
        #     if opcode == wasmi.spec.op.I32_XOR:
        #         ctx.stack.add_i32(a ^ b)
        #         continue
        #     if opcode == wasmi.spec.op.I32_SHL:
        #         ctx.stack.add_i32(a << (b % 0x20))
        #         continue
        #     if opcode == wasmi.spec.op.I32_SHRS:
        #         ctx.stack.add_i32(a >> (b % 0x20))
        #         continue
        #     if opcode == wasmi.spec.op.I32_SHRU:
        #         ctx.stack.add_i32(wasmi.num.int2u32(a) >> (b % 0x20))
        #         continue
        #     if opcode == wasmi.spec.op.I32_ROTL:
        #         r = wasmi.common.rotl_u32(a, b)
        #         r = wasmi.num.int2i32(r)
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_ROTR:
        #         r = wasmi.common.rotr_u32(a, b)
        #         r = wasmi.num.int2i32(r)
        #         ctx.stack.add_i32(r)
        #         continue
        # if opcode >= wasmi.spec.op.I64_CLZ and opcode <= wasmi.spec.op.I64_POPCNT:
        #     v = ctx.stack.pop_i64()
        #     if opcode == wasmi.spec.op.I64_CLZ:
        #         if v < 0:
        #             ctx.stack.add_i32(0)
        #             continue
        #         c = 1
        #         while c < 63 and (v & 0x4000000000000000) == 0:
        #             c += 1
        #             v *= 2
        #         ctx.stack.add_i64(c)
        #         continue
        #     if opcode == wasmi.spec.op.I64_CTZ:
        #         c = 0
        #         while c < 64 and (v % 2) == 0:
        #             c += 1
        #             v /= 2
        #         ctx.stack.add_i64(c)
        #         continue
        #     if opcode == wasmi.spec.op.I64_POPCNT:
        #         c = 0
        #         for i in range(64):
        #             if 0x1 & v:
        #                 c += 1
        #             v /= 2
        #         ctx.stack.add_i64(c)
        #         continue
        # if opcode >= wasmi.spec.op.I64_ADD and opcode <= wasmi.spec.op.I64_ROTR:
        #     b = ctx.stack.pop_i64()
        #     a = ctx.stack.pop_i64()
        #     if opcode == wasmi.spec.op.I64_ADD:
        #         r = wasmi.num.int2i64(a + b)
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_SUB:
        #         r = wasmi.num.int2i64(a - b)
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_MUL:
        #         r = wasmi.num.int2i64(a * b)
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_DIVS:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         r = wasmi.common.idiv_s(a, b)
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_DIVU:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         r = wasmi.num.int2u64(a) // wasmi.num.int2u64(b)
        #         r = wasmi.num.int2i64(r)
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_REMS:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         r = wasmi.common.irem_s(a, b)
        #         ctx.stack.add_i64(r)
        #     if opcode == wasmi.spec.op.I64_REMU:
        #         if b == 0:
        #             raise wasmi.error.WAException('integer divide by zero')
        #         r = wasmi.num.int2u64(a) % wasmi.num.int2u64(b)
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_AND:
        #         ctx.stack.add_i64(a & b)
        #         continue
        #     if opcode == wasmi.spec.op.I64_OR:
        #         ctx.stack.add_i64(a | b)
        #         continue
        #     if opcode == wasmi.spec.op.I64_XOR:
        #         ctx.stack.add_i64(a ^ b)
        #         continue
        #     if opcode == wasmi.spec.op.I64_SHL:
        #         ctx.stack.add_i64(a << (b % 0x40))
        #         continue
        #     if opcode == wasmi.spec.op.I64_SHRS:
        #         ctx.stack.add_i64(a >> (b % 0x40))
        #         continue
        #     if opcode == wasmi.spec.op.I64_SHRU:
        #         ctx.stack.add_i64(wasmi.num.int2u64(a) >> (b % 0x40))
        #         continue
        #     if opcode == wasmi.spec.op.I64_ROTL:
        #         r = wasmi.common.rotl_u64(a, b)
        #         r = wasmi.num.int2i64(r)
        #         ctx.stack.add_i64(r)
        #         continue
        #     if opcode == wasmi.spec.op.I64_ROTR:
        #         r = wasmi.common.rotr_u64(a, b)
        #         r = wasmi.num.int2i64(r)
        #         ctx.stack.add_i64(r)
        #         continue
        # if opcode >= wasmi.spec.op.F32_ABS and opcode <= wasmi.spec.op.F32_SQRT:
        #     v = ctx.stack.pop_f32()
        #     if opcode == wasmi.spec.op.F32_ABS:
        #         ctx.stack.add_f32(abs(v))
        #         continue
        #     if opcode == wasmi.spec.op.F32_NEG:
        #         ctx.stack.add_f32(-v)
        #         continue
        #     if opcode == wasmi.spec.op.F32_CEIL:
        #         ctx.stack.add_f32(math.ceil(v))
        #         continue
        #     if opcode == wasmi.spec.op.F32_FLOOR:
        #         ctx.stack.add_f32(math.floor(v))
        #         continue
        #     if opcode == wasmi.spec.op.F32_TRUNC:
        #         ctx.stack.add_f32(math.trunc(v))
        #         continue
        #     if opcode == wasmi.spec.op.F32_NEAREST:
        #         ceil = math.ceil(v)
        #         if ceil - v >= 0.5:
        #             r = ceil
        #         else:
        #             r = ceil - 1
        #         ctx.stack.add_f32(r)
        #         continue
        #     if opcode == wasmi.spec.op.F32_SQRT:
        #         ctx.stack.add_f32(math.sqrt(v))
        #         continue
        # if opcode >= wasmi.spec.op.F32_ADD and opcode <= wasmi.spec.op.F32_COPYSIGN:
        #     b = ctx.stack.pop_f32()
        #     a = ctx.stack.pop_f32()
        #     if opcode == wasmi.spec.op.F32_ADD:
        #         ctx.stack.add_f32(a + b)
        #         continue
        #     if opcode == wasmi.spec.op.F32_SUB:
        #         ctx.stack.add_f32(a - b)
        #         continue
        #     if opcode == wasmi.spec.op.F32_MUL:
        #         ctx.stack.add_f32(a * b)
        #         continue
        #     if opcode == wasmi.spec.op.F32_DIV:
        #         ctx.stack.add_f32(a / b)
        #         continue
        #     if opcode == wasmi.spec.op.F32_MIN:
        #         ctx.stack.add_f32(min(a, b))
        #         continue
        #     if opcode == wasmi.spec.op.F32_MAX:
        #         ctx.stack.add_f32(max(a, b))
        #         continue
        #     if opcode == wasmi.spec.op.F32_COPYSIGN:
        #         ctx.stack.add_f32(math.copysign(a, b))
        #         continue
        # if opcode >= wasmi.spec.op.F64_ABS and opcode <= wasmi.spec.op.F64_SQRT:
        #     v = ctx.stack.pop_f64()
        #     if opcode == wasmi.spec.op.F64_ABS:
        #         ctx.stack.add_f64(abs(v))
        #         continue
        #     if opcode == wasmi.spec.op.F64_NEG:
        #         ctx.stack.add_f64(-v)
        #         continue
        #     if opcode == wasmi.spec.op.F64_CEIL:
        #         ctx.stack.add_f64(math.ceil(v))
        #         continue
        #     if opcode == wasmi.spec.op.F64_FLOOR:
        #         ctx.stack.add_f64(math.floor(v))
        #         continue
        #     if opcode == wasmi.spec.op.F64_TRUNC:
        #         ctx.stack.add_f64(math.trunc(v))
        #         continue
        #     if opcode == wasmi.spec.op.F64_NEAREST:
        #         ceil = math.ceil(v)
        #         if ceil - v >= 0.5:
        #             r = ceil
        #         else:
        #             r = ceil - 1
        #         ctx.stack.add_f64(r)
        #         continue
        #     if opcode == wasmi.spec.op.F64_SQRT:
        #         ctx.stack.add_f64(math.sqrt(v))
        #         continue
        # if opcode >= wasmi.spec.op.F64_ADD and opcode <= wasmi.spec.op.F64_COPYSIGN:
        #     b = ctx.stack.pop_f64()
        #     a = ctx.stack.pop_f64()
        #     if opcode == wasmi.spec.op.F64_ADD:
        #         ctx.stack.add_f64(a + b)
        #         continue
        #     if opcode == wasmi.spec.op.F64_SUB:
        #         ctx.stack.add_f64(a - b)
        #         continue
        #     if opcode == wasmi.spec.op.F64_MUL:
        #         ctx.stack.add_f64(a * b)
        #         continue
        #     if opcode == wasmi.spec.op.F64_DIV:
        #         ctx.stack.add_f64(a / b)
        #         continue
        #     if opcode == wasmi.spec.op.F64_MIN:
        #         ctx.stack.add_f64(min(a, b))
        #         continue
        #     if opcode == wasmi.spec.op.F64_MAX:
        #         ctx.stack.add_f64(max(a, b))
        #         continue
        #     if opcode == wasmi.spec.op.F64_COPYSIGN:
        #         ctx.stack.add_f64(math.copysign(a, b))
        #         continue
        # if opcode >= wasmi.spec.op.I32_WRAP_I64 and opcode <= wasmi.spec.op.F64_PROMOTE_F32:
        #     v = ctx.stack.pop()
        #     if opcode == wasmi.spec.op.I32_WRAP_I64:
        #         r = wasmi.num.int2i32(v.into_i64())
        #         ctx.stack.add_i32(r)
        #         continue
        #     if opcode == wasmi.spec.op.I32_TRUNC_SF32:
        #         v = v.into_f32()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         if v > 2**31 - 1 or v < -2**32:
        #             raise wasmi.error.WAException('integer overflow')
        #         ctx.stack.add_i32(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.I32_TRUNC_UF32:
        #         v = v.into_f32()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         if v > 2 ** 32 - 1 or v < -1:
        #             raise wasmi.error.WAException('integer overflow')
        #         ctx.stack.add_i32(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.I32_TRUNC_SF64:
        #         v = v.into_f64()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         if v > 2**31 - 1 or v < -2**31:
        #             raise wasmi.error.WAException('integer overflow')
        #         ctx.stack.add_i32(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.I32_TRUNC_UF64:
        #         v = v.into_f64()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         if v > 2**32 - 1 or v < -1:
        #             raise wasmi.error.WAException('integer overflow')
        #         ctx.stack.add_i32(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.I64_EXTEND_SI32:
        #         v = v.into_i32()
        #         ctx.stack.add_i64(v)
        #         continue
        #     if opcode == wasmi.spec.op.I64_EXTEND_UI32:
        #         v = v.into_u32()
        #         ctx.stack.add_i64(v)
        #         continue
        #     if opcode == wasmi.spec.op.I64_TRUNC_SF32:
        #         v = v.into_f32()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         if v > 2**63 - 1 or v < -2**63:
        #             raise wasmi.error.WAException('integer overflow')
        #         ctx.stack.add_i64(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.I64_TRUNC_UF32:
        #         v = v.into_f32()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         if v > 2**63 - 1 or v < -1:
        #             raise wasmi.error.WAException('integer overflow')
        #         ctx.stack.add_i64(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.I64_TRUNC_SF64:
        #         v = v.into_f64()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         ctx.stack.add_i64(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.I64_TRUNC_UF64:
        #         v = v.into_f64()
        #         if math.isnan(v):
        #             raise wasmi.error.WAException("invalid conversion to integer")
        #         if v < -1:
        #             raise wasmi.error.WAException('integer overflow')
        #         ctx.stack.add_i64(int(v))
        #         continue
        #     if opcode == wasmi.spec.op.F32_CONVERT_SI32:
        #         v = v.into_i32()
        #         ctx.stack.add_f32(v)
        #         continue
        #     if opcode == wasmi.spec.op.F32_CONVERT_UI32:
        #         v = v.into_u32()
        #         ctx.stack.add_f32(r)
        #         continue
        #     if opcode == wasmi.spec.op.F32_CONVERT_SI64:
        #         v = v.into_i64()
        #         ctx.stack.add_f32(v)
        #         continue
        #     if opcode == wasmi.spec.op.F32_CONVERT_UI64:
        #         v = v.into_u64()
        #         ctx.stack.add_f32(v)
        #         continue
        #     if opcode == wasmi.spec.op.F32_DEMOTE_F64:
        #         v = v.into_f64()
        #         ctx.stack.add_f32(v)
        #         continue
        #     if opcode == wasmi.spec.op.F64_CONVERT_SI32:
        #         v = v.into_i32()
        #         ctx.stack.add_f64(v)
        #         continue
        #     if opcode == wasmi.spec.op.F64_CONVERT_UI32:
        #         v = v.into_u32()
        #         ctx.stack.add_f64(v)
        #         continue
        #     if opcode == wasmi.spec.op.F64_CONVERT_SI64:
        #         v = v.into_i64()
        #         ctx.stack.add_f64(v)
        #         continue
        #     if opcode == wasmi.spec.op.F64_CONVERT_UI64:
        #         v = v.into_u64()
        #         ctx.stack.add_f64(v)
        #         continue
        #     if opcode == wasmi.spec.op.F64_PROMOTE_F32:
        #         v = v.into_f32()
        #         ctx.stack.add_f64(v)
        #         continue
        # if opcode >= wasmi.spec.op.I32_REINTERPRET_F32 and opcode <= wasmi.spec.op.F64_REINTERPRET_I64:
        #     if opcode == wasmi.spec.op.I32_REINTERPRET_F32:
        #         ctx.stack.add_i32(wasmi.num.f322i32(ctx.stack.pop().into_f32()))
        #         continue
        #     if opcode == wasmi.spec.op.I64_REINTERPRET_F64:
        #         ctx.stack.add_i64(wasmi.num.f642i64(ctx.stack.pop().into_f64()))
        #         continue
        #     if opcode == wasmi.spec.op.F32_REINTERPRET_I32:
        #         ctx.stack.add_f32(wasmi.num.i322f32(ctx.stack.pop().into_i32()))
        #         continue
        #     if opcode == wasmi.spec.op.F64_REINTERPRET_I64:
        #         ctx.stack.add_f64(wasmi.num.i642f64(ctx.stack.pop().into_i64()))
        #         continue

        # elif opcode == convention.i32_const:
        #     stack.add(Value.from_i32(i.immediate_arguments))
        # elif opcode == convention.i64_const:
        #     stack.add(Value.from_i64(i.immediate_arguments))
        # elif opcode == convention.f32_const:
        #     stack.add(Value.from_f32(i.immediate_arguments))
        # elif opcode == convention.f64_const:
        #     stack.add(Value.from_f64(i.immediate_arguments))
        # elif opcode == convention.get_global:
        #     stack.add(store.globals[module.globaladdrs[i.immediate_arguments]])
        # elif opcode == convention.end:
        #     break
    return [stack.pop() for _ in rets]
