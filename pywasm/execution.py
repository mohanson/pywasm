import math
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
        self.size = limits.minimum
        self.data = bytearray([0x00 for _ in range(limits.minimum * 64 * 1024)])

    def grow(self, n: int):
        if self.limits.maximum and self.size + n > self.limits.maximum:
            raise Exception('pywasm: out of memory limit')
        self.data.extend([0 for _ in range(n * 64 * 1024)])
        self.size += n


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

    def __repr__(self):
        return str(self.n)

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
    def __init__(self, arity: int, continuation: int):
        self.arity = arity
        self.continuation = continuation

    def __repr__(self):
        return '|'


class Frame:
    # Activation frames carry the return arity of the respective function, hold the values of its locals (including
    # arguments) in the order corresponding to their static local indices, and a reference to the function’s own module
    # instance:
    #
    # activation ::= framen{frame}
    # frame ::= {locals val∗, module moduleinst}
    def __init__(self, module: 'ModuleInstance', locs: typing.List[Value], arity: int, continuation: int):
        self.module = module
        self.locals = locs
        self.arity = arity
        self.continuation = continuation

    def __repr__(self):
        return '*'


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

    def __repr__(self):
        return self.data.__repr__()

    def add(self, e):
        self.data.append(e)

    def ext(self, e: typing.List):
        for i in e:
            self.add(i)

    def pop(self):
        return self.data.pop()

    def len(self):
        return len(self.data)

    def top(self):
        return self.data[-1]

    def status(self):
        for i in range(len(self.data)):
            i = -1 - i
            if isinstance(self.data[i], Label):
                return Label
            if isinstance(self.data[i], Frame):
                return Frame


class Ctx:
    # This exposes the specified memory of the WebAssembly instance.
    def __init__(self, mems: typing.List[MemoryInstance]):
        self.mems = mems


def import_matching_limits(limits1: structure.Limits, limits2: structure.Limits):
    n1 = limits1.minimum
    m1 = limits1.maximum
    n2 = limits2.minimum
    m2 = limits2.maximum
    if m2 is None or (m1 is not None and m1 <= m2):
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
        self.types = module.types
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
                assert import_matching_limits(b, a.limits)
            elif e.extern_type == convention.extern_global:
                a = store.globals[e.addr]
                b = module.imports[i].desc
                assert a.value.valtype == b.valtype
        # Let vals be the vector of global initialization values determined by module and externvaln
        auxmod = ModuleInstance()
        auxmod.globaladdrs = [e.addr for e in externvals if e.extern_type == convention.extern_global]
        stack = Stack()
        frame = Frame(auxmod, [], 1, -1)
        stack.add(frame)
        vals = []
        for glob in module.globals:
            v = exec_expr(store, frame, stack, glob.expr)[0]
            vals.append(v)
        assert isinstance(stack.pop(), Frame)

        # Allocation
        self.allocate(module, store, externvals, vals)

        # Push the frame F to the stack
        frame = Frame(self, [], 1, -1)
        stack.add(frame)
        # For each element segment in module.elem, do:
        for e in module.elem:
            offset = exec_expr(store, frame, stack, e.expr)[0]
            assert offset.valtype == convention.i32
            t = store.tables[self.tableaddrs[e.tableidx]]
            for i, e in enumerate(e.init):
                t.elem[offset.n + i] = e
        # For each data segment in module.data, do:
        for e in module.data:
            offset = exec_expr(store, frame, stack, e.expr)[0]
            assert offset.valtype == convention.i32
            m = store.mems[self.memaddrs[e.memidx]]
            end = offset.n + len(e.init)
            assert end <= len(m.data)
            m.data[offset.n: offset.n + len(e.init)] = e.init
        # Assert: due to validation, the frame F is now on the top of the stack.
        assert isinstance(stack.pop(), Frame)
        assert stack.len() == 0
        # If the start function module.start is not empty, invoke the function instance
        if module.start is not None:
            log.debugln(f'Running start function {module.start}:')
            call(self, module.start, store, stack)

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
                raise Exception('pywasm: mismatch valtype')
            globalinst = GlobalInstance(val, glob.globaltype.mut)
            store.globals.append(globalinst)
            self.globaladdrs.append(len(store.globals) - 1)
        # For each export in module.exports, do:
        for i, export in enumerate(module.exports):
            externval = ExternValue(export.kind, export.desc)
            exportinst = ExportInstance(export.name, externval)
            self.exports.append(exportinst)


def hostfunc_call(
    _: ModuleInstance,
    address: int,
    store: Store,
    stack: Stack,
):
    f: HostFunc = store.funcs[address]
    valn = [stack.pop() for _ in f.functype.args][::-1]
    ctx = Ctx(store.mems)
    r = f.hostcode(ctx, *[e.n for e in valn])
    return [Value(f.functype.rets[0], r)]


def wasmfunc_call(
    module: ModuleInstance,
    address: int,
    store: Store,
    stack: Stack,
):
    f: WasmFunc = store.funcs[address]
    code = f.code.expr.data
    valn = [stack.pop() for _ in f.functype.args][::-1]
    val0 = []
    for e in f.code.locals:
        if e == convention.i32:
            val0.append(Value.from_i32(0))
        elif e == convention.i64:
            val0.append(Value.from_i64(0))
        elif e == convention.f32:
            val0.append(Value.from_f32(0))
        else:
            val0.append(Value.from_f64(0))
    frame = Frame(module, valn + val0, len(f.functype.rets), len(code))
    stack.add(frame)
    stack.add(Label(len(f.functype.rets), len(code)))
    # An expression is evaluated relative to a current frame pointing to its containing module instance.
    r = exec_expr(store, frame, stack, f.code.expr)
    # Exit
    if not isinstance(stack.pop(), Frame):
        raise Exception('pywasm: signature mismatch in call')
    return r


def call(
    module: ModuleInstance,
    address: int,
    store: Store,
    stack: Stack,
):
    f = store.funcs[address]
    assert len(f.functype.rets) <= 1
    for i, t in enumerate(f.functype.args[::-1]):
        ia = t
        ib = stack.data[-1 - i]
        if ia != ib.valtype:
            raise Exception('pywasm: signature mismatch in call')
    if isinstance(f, WasmFunc):
        return wasmfunc_call(module, address, store, stack)
    if isinstance(f, HostFunc):
        return hostfunc_call(module, address, store, stack)
    raise KeyError


def spec_br(l: int, stack: Stack) -> int:
    # Let L be the l-th label appearing on the stack, starting from the top and counting from zero.
    L = [i for i in stack.data if isinstance(i, Label)][::-1][l]
    n = L.arity
    v = [stack.pop() for _ in range(n)][::-1]

    s = 0
    while True:
        e = stack.pop()
        if isinstance(e, Label):
            s += 1
            if s == l + 1:
                break
    stack.ext(v)
    return L.continuation - 1


def exec_expr(
    store: Store,
    frame: Frame,
    stack: Stack,
    expr: structure.Expression,
):
    # An expression is evaluated relative to a current frame pointing to its containing module instance.
    # 1. Jump to the start of the instruction sequence instr∗ of the expression.
    # 2. Execute the instruction sequence.
    # 3. Assert: due to validation, the top of the stack contains a value.
    # 4. Pop the value val from the stack.
    module = frame.module
    if not expr.data:
        raise Exception('pywasm: empty init expr')
    pc = -1
    while True:
        pc += 1
        if pc >= len(expr.data):
            break
        i = expr.data[pc]

        log.debugln(f'{str(i):<18} {stack}')

        if log.lvl >= 2:
            ls = [f'{i}: {convention.valtype[l.valtype][0]} {l.n}' for i, l in enumerate(frame.locals)]
            gs = [f'{i}: {"mut " if g.mut else ""}{convention.valtype[g.value.valtype][0]} {g.value.n}' for i,
                  g in enumerate(store.globals)]
            for n, e in (('locals', ls), ('globals', gs)):
                log.verboseln(f'{" "*18} {str(n)+":":<8} [{", ".join(e)}]')

        opcode = i.code
        if opcode >= convention.unreachable and opcode <= convention.call_indirect:
            if opcode == convention.unreachable:
                raise Exception('pywasm: reached unreachable')
            if opcode == convention.nop:
                continue
            if opcode == convention.block:
                arity = 0 if i.immediate_arguments == convention.empty else 1
                stack.add(Label(arity, expr.composition[pc][-1] + 1))
                continue
            if opcode == convention.loop:
                stack.add(Label(0, expr.composition[pc][0]))
                continue
            if opcode == convention.if_:
                c = stack.pop().n
                arity = 0 if i.immediate_arguments == convention.empty else 1
                stack.add(Label(arity, expr.composition[pc][-1] + 1))
                if c != 0:
                    continue
                if len(expr.composition[pc]) > 2:
                    pc = expr.composition[pc][1]
                    continue
                pc = expr.composition[pc][-1] - 1
                continue
            if opcode == convention.else_:
                for i in range(len(stack.data)):
                    i = -1 - i
                    e = stack.data[i]
                    if isinstance(e, Label):
                        pc = e.continuation - 1
                        del stack.data[i]
                        break
                continue
            if opcode == convention.end:
                # label{instr∗} val* end -> val*
                if stack.status() == Label:
                    for i in range(len(stack.data)):
                        i = -1 - i
                        if isinstance(stack.data[i], Label):
                            del stack.data[i]
                            break
                    continue
                # frame{F} val* end -> val*
                v = [stack.pop() for _ in range(frame.arity)][::-1]
                stack.ext(v)
                continue
            if opcode == convention.br:
                pc = spec_br(i.immediate_arguments, stack)
                continue
            if opcode == convention.br_if:
                if stack.pop().n == 0:
                    continue
                pc = spec_br(i.immediate_arguments, stack)
                continue
            if opcode == convention.br_table:
                a = i.immediate_arguments[0]
                l = i.immediate_arguments[1]
                c = stack.pop().n
                if c >= 0 and c < len(a):
                    l = a[c]
                pc = spec_br(l, stack)
                continue
            if opcode == convention.return_:
                v = [stack.pop() for _ in range(frame.arity)][::-1]
                while True:
                    e = stack.pop()
                    if isinstance(e, Frame):
                        stack.add(e)
                        break
                stack.ext(v)
                break
            if opcode == convention.call:
                r = call(module, module.funcaddrs[i.immediate_arguments], store, stack)
                stack.ext(r)
                continue
            if opcode == convention.call_indirect:
                if i.immediate_arguments[1] != 0x00:
                    raise Exception("pywasm: zero byte malformed in call_indirect")
                idx = stack.pop().n
                tab = store.tables[module.tableaddrs[0]]
                if not 0 <= idx < len(tab.elem):
                    raise Exception('pywasm: undefined element index')
                r = call(module, tab.elem[idx], store, stack)
                stack.ext(r)
                continue
            continue
        if opcode == convention.drop:
            stack.pop()
            continue
        if opcode == convention.select:
            cond = stack.pop().n
            a = stack.pop()
            b = stack.pop()
            if cond:
                stack.add(b)
            else:
                stack.add(a)
            continue
        if opcode == convention.get_local:
            stack.add(frame.locals[i.immediate_arguments])
            continue
        if opcode == convention.set_local:
            if i.immediate_arguments >= len(frame.locals):
                frame.locals.extend(
                    [Value.from_i32(0) for _ in range(i.immediate_arguments - len(frame.locals) + 1)]
                )
            frame.locals[i.immediate_arguments] = stack.pop()
            continue
        if opcode == convention.tee_local:
            frame.locals[i.immediate_arguments] = stack.top()
            continue
        if opcode == convention.get_global:
            stack.add(store.globals[module.globaladdrs[i.immediate_arguments]].value)
            continue
        if opcode == convention.set_global:
            store.globals[module.globaladdrs[i.immediate_arguments]] = GlobalInstance(stack.pop(), True)
            continue
        if opcode >= convention.i32_load and opcode <= convention.grow_memory:
            m = store.mems[module.memaddrs[0]]
            if opcode >= convention.i32_load and opcode <= convention.i64_load32_u:
                a = stack.pop().n + i.immediate_arguments[1]
                if a + convention.opcodes[opcode][2] > len(m.data):
                    raise Exception('pywasm: out of bounds memory access')
                if opcode == convention.i32_load:
                    stack.add(Value.from_i32(num.LittleEndian.i32(m.data[a:a + 4])))
                    continue
                if opcode == convention.i64_load:
                    stack.add(Value.from_i64(num.LittleEndian.i64(m.data[a:a + 8])))
                    continue
                if opcode == convention.f32_load:
                    stack.add(Value.from_f32(num.LittleEndian.f32(m.data[a:a + 4])))
                    continue
                if opcode == convention.f64_load:
                    stack.add(Value.from_f64(num.LittleEndian.f64(m.data[a:a + 8])))
                    continue
                if opcode == convention.i32_load8_s:
                    stack.add(Value.from_i32(num.LittleEndian.i8(m.data[a:a + 1])))
                    continue
                if opcode == convention.i32_load8_u:
                    stack.add(Value.from_i32(num.LittleEndian.u8(m.data[a:a + 1])))
                    continue
                if opcode == convention.i32_load16_s:
                    stack.add(Value.from_i32(num.LittleEndian.i16(m.data[a:a + 2])))
                    continue
                if opcode == convention.i32_load16_u:
                    stack.add(Value.from_i32(num.LittleEndian.u16(m.data[a:a + 2])))
                    continue
                if opcode == convention.i64_load8_s:
                    stack.add(Value.from_i64(num.LittleEndian.i8(m.data[a:a + 1])))
                    continue
                if opcode == convention.i64_load8_u:
                    stack.add(Value.from_i64(num.LittleEndian.u8(m.data[a:a + 1])))
                    continue
                if opcode == convention.i64_load16_s:
                    stack.add(Value.from_i64(num.LittleEndian.i16(m.data[a:a + 2])))
                    continue
                if opcode == convention.i64_load16_u:
                    stack.add(Value.from_i64(num.LittleEndian.u16(m.data[a:a + 2])))
                    continue
                if opcode == convention.i64_load32_s:
                    stack.add(Value.from_i64(num.LittleEndian.i32(m.data[a:a + 4])))
                    continue
                if opcode == convention.i64_load32_u:
                    stack.add(Value.from_i64(num.LittleEndian.u32(m.data[a:a + 4])))
                    continue
                continue
            if opcode >= convention.i32_store and opcode <= convention.i64_store32:
                v = stack.pop().n
                a = stack.pop().n + i.immediate_arguments[1]
                if a + convention.opcodes[opcode][2] > len(m.data):
                    raise Exception('pywasm: out of bounds memory access')
                if opcode == convention.i32_store:
                    m.data[a:a + 4] = num.LittleEndian.pack_i32(v)
                    continue
                if opcode == convention.i64_store:
                    m.data[a:a + 8] = num.LittleEndian.pack_i64(v)
                    continue
                if opcode == convention.f32_store:
                    m.data[a:a + 4] = num.LittleEndian.pack_f32(v)
                    continue
                if opcode == convention.f64_store:
                    m.data[a:a + 8] = num.LittleEndian.pack_f64(v)
                    continue
                if opcode == convention.i32_store8:
                    m.data[a:a + 1] = num.LittleEndian.pack_i8(num.int2i8(v))
                    continue
                if opcode == convention.i32_store16:
                    m.data[a:a + 2] = num.LittleEndian.pack_i16(num.int2i16(v))
                    continue
                if opcode == convention.i64_store8:
                    m.data[a:a + 1] = num.LittleEndian.pack_i8(num.int2i8(v))
                    continue
                if opcode == convention.i64_store16:
                    m.data[a:a + 2] = num.LittleEndian.pack_i16(num.int2i16(v))
                    continue
                if opcode == convention.i64_store32:
                    m.data[a:a + 4] = num.LittleEndian.pack_i32(num.int2i32(v))
                    continue
                continue
            if opcode == convention.current_memory:
                stack.add(Value.from_i32(m.size))
                continue
            if opcode == convention.grow_memory:
                cursize = m.size
                m.grow(stack.pop().n)
                stack.add(Value.from_i32(cursize))
                continue
            continue
        if opcode >= convention.i32_const and opcode <= convention.f64_const:
            if opcode == convention.i32_const:
                stack.add(Value.from_i32(i.immediate_arguments))
                continue
            if opcode == convention.i64_const:
                stack.add(Value.from_i64(i.immediate_arguments))
                continue
            if opcode == convention.f32_const:
                stack.add(Value.from_f32(i.immediate_arguments))
                continue
            if opcode == convention.f64_const:
                stack.add(Value.from_f64(i.immediate_arguments))
                continue
            continue
        if opcode == convention.i32_eqz:
            stack.add(Value.from_i32(int(stack.pop().n == 0)))
            continue
        if opcode >= convention.i32_eq and opcode <= convention.i32_geu:
            b = stack.pop().n
            a = stack.pop().n
            if opcode == convention.i32_eq:
                stack.add(Value.from_i32(int(a == b)))
                continue
            if opcode == convention.i32_ne:
                stack.add(Value.from_i32(int(a != b)))
                continue
            if opcode == convention.i32_lts:
                stack.add(Value.from_i32(int(a < b)))
                continue
            if opcode == convention.i32_ltu:
                stack.add(Value.from_i32(int(num.int2u32(a) < num.int2u32(b))))
                continue
            if opcode == convention.i32_gts:
                stack.add(Value.from_i32(int(a > b)))
                continue
            if opcode == convention.i32_gtu:
                stack.add(Value.from_i32(int(num.int2u32(a) > num.int2u32(b))))
                continue
            if opcode == convention.i32_les:
                stack.add(Value.from_i32(int(a <= b)))
                continue
            if opcode == convention.i32_leu:
                stack.add(Value.from_i32(int(num.int2u32(a) <= num.int2u32(b))))
                continue
            if opcode == convention.i32_ges:
                stack.add(Value.from_i32(int(a >= b)))
                continue
            if opcode == convention.i32_geu:
                stack.add(Value.from_i32(int(num.int2u32(a) >= num.int2u32(b))))
                continue
            continue
        if opcode == convention.i64_eqz:
            stack.add(Value.from_i32(int(stack.pop().n == 0)))
            continue
        if opcode >= convention.i64_eq and opcode <= convention.i64_geu:
            b = stack.pop().n
            a = stack.pop().n
            if opcode == convention.i64_eq:
                stack.add(Value.from_i32(int(a == b)))
                continue
            if opcode == convention.i64_ne:
                stack.add(Value.from_i32(int(a != b)))
                continue
            if opcode == convention.i64_lts:
                stack.add(Value.from_i32(int(a < b)))
                continue
            if opcode == convention.i64_ltu:
                stack.add(Value.from_i32(int(num.int2u64(a) < num.int2u64(b))))
                continue
            if opcode == convention.i64_gts:
                stack.add(Value.from_i32(int(a > b)))
                continue
            if opcode == convention.i64_gtu:
                stack.add(Value.from_i32(int(num.int2u64(a) > num.int2u64(b))))
                continue
            if opcode == convention.i64_les:
                stack.add(Value.from_i32(int(a <= b)))
                continue
            if opcode == convention.i64_leu:
                stack.add(Value.from_i32(int(num.int2u64(a) <= num.int2u64(b))))
                continue
            if opcode == convention.i64_ges:
                stack.add(Value.from_i32(int(a >= b)))
                continue
            if opcode == convention.i64_geu:
                stack.add(Value.from_i32(int(num.int2u64(a) >= num.int2u64(b))))
                continue
            continue
        if opcode >= convention.f32_eq and opcode <= convention.f64_ge:
            b = stack.pop().n
            a = stack.pop().n
            if opcode == convention.f32_eq:
                stack.add(Value.from_i32(int(a == b)))
                continue
            if opcode == convention.f32_ne:
                stack.add(Value.from_i32(int(a != b)))
                continue
            if opcode == convention.f32_lt:
                stack.add(Value.from_i32(int(a < b)))
                continue
            if opcode == convention.f32_gt:
                stack.add(Value.from_i32(int(a > b)))
                continue
            if opcode == convention.f32_le:
                stack.add(Value.from_i32(int(a <= b)))
                continue
            if opcode == convention.f32_ge:
                stack.add(Value.from_i32(int(a >= b)))
                continue
            if opcode == convention.f64_eq:
                stack.add(Value.from_i32(int(a == b)))
                continue
            if opcode == convention.f64_ne:
                stack.add(Value.from_i32(int(a != b)))
                continue
            if opcode == convention.f64_lt:
                stack.add(Value.from_i32(int(a < b)))
                continue
            if opcode == convention.f64_gt:
                stack.add(Value.from_i32(int(a > b)))
                continue
            if opcode == convention.f64_le:
                stack.add(Value.from_i32(int(a <= b)))
                continue
            if opcode == convention.f64_ge:
                stack.add(Value.from_i32(int(a >= b)))
                continue
            continue
        if opcode >= convention.i32_clz and opcode <= convention.i32_popcnt:
            a = stack.pop().n
            if opcode == convention.i32_clz:
                c = 0
                while c < 32 and (a & 0x80000000) == 0:
                    c += 1
                    a *= 2
                stack.add(Value.from_i32(c))
                continue
            if opcode == convention.i32_ctz:
                c = 0
                while c < 32 and (a % 2) == 0:
                    c += 1
                    a /= 2
                stack.add(Value.from_i32(c))
                continue
            if opcode == convention.i32_popcnt:
                c = 0
                for i in range(32):
                    if 0x1 & a:
                        c += 1
                    a //= 2
                stack.add(Value.from_i32(c))
                continue
            continue
        if opcode >= convention.i32_add and opcode <= convention.i32_rotr:
            b = stack.pop().n
            a = stack.pop().n
            if opcode in [
                convention.i32_divs,
                convention.i32_divu,
                convention.i32_rems,
                convention.i32_remu,
            ]:
                if b == 0:
                    raise Exception('pywasm: integer divide by zero')
            if opcode == convention.i32_add:
                stack.add(Value.from_i32(num.int2i32(a + b)))
                continue
            if opcode == convention.i32_sub:
                stack.add(Value.from_i32(num.int2i32(a - b)))
                continue
            if opcode == convention.i32_mul:
                stack.add(Value.from_i32(num.int2i32(a * b)))
                continue
            if opcode == convention.i32_divs:
                if a == 0x80000000 and b == -1:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i32(num.idiv_s(a, b)))
                continue
            if opcode == convention.i32_divu:
                stack.add(Value.from_i32(num.int2i32(num.int2u32(a) // num.int2u32(b))))
                continue
            if opcode == convention.i32_rems:
                stack.add(Value.from_i32(num.irem_s(a, b)))
                continue
            if opcode == convention.i32_remu:
                stack.add(Value.from_i32(num.int2i32(num.int2u32(a) % num.int2u32(b))))
                continue
            if opcode == convention.i32_and:
                stack.add(Value.from_i32(a & b))
                continue
            if opcode == convention.i32_or:
                stack.add(Value.from_i32(a | b))
                continue
            if opcode == convention.i32_xor:
                stack.add(Value.from_i32(a ^ b))
                continue
            if opcode == convention.i32_shl:
                stack.add(Value.from_i32(num.int2i32(a << (b % 0x20))))
                continue
            if opcode == convention.i32_shrs:
                stack.add(Value.from_i32(a >> (b % 0x20)))
                continue
            if opcode == convention.i32_shru:
                stack.add(Value.from_i32(num.int2u32(a) >> (b % 0x20)))
                continue
            if opcode == convention.i32_rotl:
                stack.add(Value.from_i32(num.int2i32(num.rotl_u32(a, b))))
                continue
            if opcode == convention.i32_rotr:
                stack.add(Value.from_i32(num.int2i32(num.rotr_u32(a, b))))
                continue
            continue
        if opcode >= convention.i64_clz and opcode <= convention.i64_popcnt:
            a = stack.pop().n
            if opcode == convention.i64_clz:
                if a < 0:
                    stack.add(Value.from_i32(0))
                    continue
                c = 1
                while c < 63 and (a & 0x4000000000000000) == 0:
                    c += 1
                    a *= 2
                stack.add(Value.from_i64(c))
                continue
            if opcode == convention.i64_ctz:
                c = 0
                while c < 64 and (a % 2) == 0:
                    c += 1
                    a /= 2
                stack.add(Value.from_i64(c))
                continue
            if opcode == convention.i64_popcnt:
                c = 0
                for i in range(64):
                    if 0x1 & a:
                        c += 1
                    a //= 2
                stack.add(Value.from_i64(c))
                continue
            continue
        if opcode >= convention.i64_add and opcode <= convention.i64_rotr:
            b = stack.pop().n
            a = stack.pop().n
            if opcode in [
                convention.i64_divs,
                convention.i64_divu,
                convention.i64_rems,
                convention.i64_remu,
            ]:
                if b == 0:
                    raise Exception('pywasm: integer divide by zero')
            if opcode == convention.i64_add:
                stack.add(Value.from_i64(num.int2i64(a + b)))
                continue
            if opcode == convention.i64_sub:
                stack.add(Value.from_i64(num.int2i64(a - b)))
                continue
            if opcode == convention.i64_mul:
                stack.add(Value.from_i64(num.int2i64(a * b)))
                continue
            if opcode == convention.i64_divs:
                stack.add(Value.from_i64(num.idiv_s(a, b)))
                continue
            if opcode == convention.i64_divu:
                stack.add(Value.from_i64(num.int2i64(num.int2u64(a) // num.int2u64(b))))
                continue
            if opcode == convention.i64_rems:
                stack.add(Value.from_i64(num.irem_s(a, b)))
            if opcode == convention.i64_remu:
                stack.add(Value.from_i64(num.int2u64(a) % num.int2u64(b)))
                continue
            if opcode == convention.i64_and:
                stack.add(Value.from_i64(a & b))
                continue
            if opcode == convention.i64_or:
                stack.add(Value.from_i64(a | b))
                continue
            if opcode == convention.i64_xor:
                stack.add(Value.from_i64(a ^ b))
                continue
            if opcode == convention.i64_shl:
                stack.add(Value.from_i64(num.int2i64(a << (b % 0x40))))
                continue
            if opcode == convention.i64_shrs:
                stack.add(Value.from_i64(a >> (b % 0x40)))
                continue
            if opcode == convention.i64_shru:
                stack.add(Value.from_i64(num.int2u64(a) >> (b % 0x40)))
                continue
            if opcode == convention.i64_rotl:
                stack.add(Value.from_i64(num.int2i64(num.rotl_u64(a, b))))
                continue
            if opcode == convention.i64_rotr:
                stack.add(Value.from_i64(num.int2i64(num.rotr_u64(a, b))))
                continue
            continue
        if opcode >= convention.f32_abs and opcode <= convention.f32_sqrt:
            a = stack.pop().n
            if opcode == convention.f32_abs:
                stack.add(Value.from_f32(abs(a)))
                continue
            if opcode == convention.f32_neg:
                stack.add(Value.from_f32(-a))
                continue
            if opcode == convention.f32_ceil:
                stack.add(Value.from_f32(math.ceil(a)))
                continue
            if opcode == convention.f32_floor:
                stack.add(Value.from_f32(math.floor(a)))
                continue
            if opcode == convention.f32_trunc:
                stack.add(Value.from_f32(math.trunc(a)))
                continue
            if opcode == convention.f32_nearest:
                ceil = math.ceil(a)
                if ceil - a >= 0.5:
                    r = ceil
                else:
                    r = ceil - 1
                stack.add(Value.from_f32(r))
                continue
            if opcode == convention.f32_sqrt:
                stack.add(Value.from_f32(math.sqrt(a)))
                continue
            continue
        if opcode >= convention.f32_add and opcode <= convention.f32_copysign:
            b = stack.pop().n
            a = stack.pop().n
            if opcode == convention.f32_add:
                stack.add(Value.from_f32(a + b))
                continue
            if opcode == convention.f32_sub:
                stack.add(Value.from_f32(a - b))
                continue
            if opcode == convention.f32_mul:
                stack.add(Value.from_f32(a * b))
                continue
            if opcode == convention.f32_div:
                stack.add(Value.from_f32(a / b))
                continue
            if opcode == convention.f32_min:
                stack.add(Value.from_f32(min(a, b)))
                continue
            if opcode == convention.f32_max:
                stack.add(Value.from_f32(max(a, b)))
                continue
            if opcode == convention.f32_copysign:
                stack.add(Value.from_f32(math.copysign(a, b)))
                continue
            continue
        if opcode >= convention.f64_abs and opcode <= convention.f64_sqrt:
            a = stack.pop().n
            if opcode == convention.f64_abs:
                stack.add(Value.from_f64(abs(a)))
                continue
            if opcode == convention.f64_neg:
                stack.add(Value.from_f64(-a))
                continue
            if opcode == convention.f64_ceil:
                stack.add(Value.from_f64(math.ceil(a)))
                continue
            if opcode == convention.f64_floor:
                stack.add(Value.from_f64(math.floor(a)))
                continue
            if opcode == convention.f64_trunc:
                stack.add(Value.from_f64(math.trunc(a)))
                continue
            if opcode == convention.f64_nearest:
                ceil = math.ceil(a)
                if ceil - a >= 0.5:
                    r = ceil
                else:
                    r = ceil - 1
                stack.add(Value.from_f64(r))
                continue
            if opcode == convention.f64_sqrt:
                stack.add(Value.from_f64(math.sqrt(a)))
                continue
            continue
        if opcode >= convention.f64_add and opcode <= convention.f64_copysign:
            b = stack.pop().n
            a = stack.pop().n
            if opcode == convention.f64_add:
                stack.add(Value.from_f64(a + b))
                continue
            if opcode == convention.f64_sub:
                stack.add(Value.from_f64(a - b))
                continue
            if opcode == convention.f64_mul:
                stack.add(Value.from_f64(a * b))
                continue
            if opcode == convention.f64_div:
                stack.add(Value.from_f64(a / b))
                continue
            if opcode == convention.f64_min:
                stack.add(Value.from_f64(min(a, b)))
                continue
            if opcode == convention.f64_max:
                stack.add(Value.from_f64(max(a, b)))
                continue
            if opcode == convention.f64_copysign:
                stack.add(Value.from_f64(math.copysign(a, b)))
                continue
            continue
        if opcode >= convention.i32_wrap_i64 and opcode <= convention.f64_promote_f32:
            a = stack.pop().n
            if opcode in [
                convention.i32_trunc_sf32,
                convention.i32_trunc_uf32,
                convention.i32_trunc_sf64,
                convention.i32_trunc_uf64,
                convention.i64_trunc_sf32,
                convention.i64_trunc_uf32,
                convention.i64_trunc_sf64,
                convention.i64_trunc_uf64,
            ]:
                if math.isnan(a):
                    raise Exception('pywasm: invalid conversion to integer')
            if opcode == convention.i32_wrap_i64:
                stack.add(Value.from_i32(num.int2i32(a)))
                continue
            if opcode == convention.i32_trunc_sf32:
                if a > 2**31 - 1 or a < -2**32:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i32(int(a)))
                continue
            if opcode == convention.i32_trunc_uf32:
                if a > 2**32 - 1 or a < -1:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i32(int(a)))
                continue
            if opcode == convention.i32_trunc_sf64:
                if a > 2**31 - 1 or a < -2**32:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i32(int(a)))
                continue
            if opcode == convention.i32_trunc_uf64:
                if a > 2**32 - 1 or a < -1:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i32(int(a)))
                continue
            if opcode == convention.i64_extend_si32:
                stack.add(Value.from_i64(a))
                continue
            if opcode == convention.i64_extend_ui32:
                stack.add(Value.from_i64(num.int2u32(a)))
                continue
            if opcode == convention.i64_trunc_sf32:
                if a > 2**63 - 1 or a < -2**63:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i64(int(a)))
                continue
            if opcode == convention.i64_trunc_uf32:
                if a > 2**63 - 1 or a < -1:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i64(int(a)))
                continue
            if opcode == convention.i64_trunc_sf64:
                stack.add(Value.from_i64(int(a)))
                continue
            if opcode == convention.i64_trunc_uf64:
                if a < -1:
                    raise Exception('pywasm: integer overflow')
                stack.add(Value.from_i64(int(a)))
                continue
            if opcode == convention.f32_convert_si32:
                stack.add(Value.from_f32(a))
                continue
            if opcode == convention.f32_convert_ui32:
                stack.add(Value.from_f32(num.int2u32(a)))
                continue
            if opcode == convention.f32_convert_si64:
                stack.add(Value.from_f32(a))
                continue
            if opcode == convention.f32_convert_ui64:
                stack.add(Value.from_f32(num.int2u64(a)))
                continue
            if opcode == convention.f32_demote_f64:
                stack.add(Value.from_f32(a))
                continue
            if opcode == convention.f64_convert_si32:
                stack.add(Value.from_f64(a))
                continue
            if opcode == convention.f64_convert_ui32:
                stack.add(Value.from_f64(num.int2u32(a)))
                continue
            if opcode == convention.f64_convert_si64:
                stack.add(Value.from_f64(a))
                continue
            if opcode == convention.f64_convert_ui64:
                stack.add(Value.from_f64(num.int2u64(a)))
                continue
            if opcode == convention.f64_promote_f32:
                stack.add(Value.from_f64(a))
                continue
            continue
        if opcode >= convention.i32_reinterpret_f32 and opcode <= convention.f64_reinterpret_i64:
            a = stack.pop().n
            if opcode == convention.i32_reinterpret_f32:
                stack.add(Value.from_i32(num.f322i32(a)))
                continue
            if opcode == convention.i64_reinterpret_f64:
                stack.add(Value.from_i64(num.f642i64(a)))
                continue
            if opcode == convention.f32_reinterpret_i32:
                stack.add(Value.from_f32(num.i322f32(a)))
                continue
            if opcode == convention.f64_reinterpret_i64:
                stack.add(Value.from_f64(num.i642f64(a)))
                continue
            continue

    return [stack.pop() for _ in range(frame.arity)][::-1]
