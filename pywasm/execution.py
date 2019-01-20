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
    if not expr.data:
        log.panicln('pywasm: empty init expr')
    for i in expr.data:
        opcode = i.code
        if opcode == convention.i32_const:
            stack.add(Value.from_i32(i.immediate_arguments))
        elif opcode == convention.i64_const:
            stack.add(Value.from_i64(i.immediate_arguments))
        elif opcode == convention.f32_const:
            stack.add(Value.from_f32(i.immediate_arguments))
        elif opcode == convention.f64_const:
            stack.add(Value.from_f64(i.immediate_arguments))
        elif opcode == convention.get_global:
            stack.add(store.globals[module.globaladdrs[i.immediate_arguments]])
        elif opcode == convention.end:
            break
        else:
            log.panicln('pywasm: invalid opcode in init expr')
    return [stack.pop() for _ in rets]
