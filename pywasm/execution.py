import math
import struct
import typing

from . import core
from . import log
from . import opcode
from . import option

from .core import Val

memory_page_size = 64 * 1024
memory_page = 2**16
call_stack_depth = 128


# ======================================================================================================================
# Execution Runtime Structure
# ======================================================================================================================


class Result:
    # A result is the outcome of a computation. It is either a sequence of values or a trap.
    def __init__(self, data: typing.List[Val]):
        self.data = data

    def __repr__(self):
        return self.data.__repr__()


class FunctionAddress(int):
    def __repr__(self):
        return f'FunctionAddress({super().__repr__()})'


class TableAddress(int):
    def __repr__(self):
        return f'TableAddress({super().__repr__()})'


class MemoryAddress(int):
    def __repr__(self):
        return f'MemoryAddress({super().__repr__()})'


class GlobalAddress(int):
    def __repr__(self):
        return f'GlobalAddress({super().__repr__()})'


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
        self.type_list: typing.List[core.FuncType] = []
        self.function_addr_list: typing.List[FunctionAddress] = []
        self.table_addr_list: typing.List[TableAddress] = []
        self.memory_addr_list: typing.List[MemoryAddress] = []
        self.global_addr_list: typing.List[GlobalAddress] = []
        self.export_list: typing.List[ExportInstance] = []


class WasmFunc:
    def __init__(self, function_type: core.FuncType, module: ModuleInstance, code: core.Function):
        self.type = function_type
        self.module = module
        self.code = code

    def __repr__(self):
        return f'wasm_func({self.type})'


class HostFunc:
    # A host function is a function expressed outside WebAssembly but passed to a module as an import. The definition
    # and behavior of host functions are outside the scope of this specification. For the purpose of this
    # specification, it is assumed that when invoked, a host function behaves non-deterministically, but within certain
    # constraints that ensure the integrity of the runtime.
    def __init__(self, function_type: core.FuncType, hostcode: typing.Callable):
        self.type = function_type
        self.hostcode = hostcode

    def __repr__(self):
        return self.hostcode.__name__


# A function instance is the runtime representation of a function. It effectively is a closure of the original
# function over the runtime module instance of its originating module. The module instance is used to resolve
# references to other definitions during execution of the function.
#
# funcinst ::= {type functype,module moduleinst,code func}
#            | {type functype,hostcode hostfunc}
# hostfunc ::= ...
FunctionInstance = typing.Union[WasmFunc, HostFunc]


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
    def __init__(self, element_type: int, limits: core.Limits):
        self.element_type = element_type
        self.element_list: typing.List[typing.Optional[FunctionAddress]] = [None for _ in range(limits.n)]
        self.limits = limits


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
    def __init__(self, type: core.MemType):
        self.type = type
        self.data = bytearray()
        self.size = 0
        self.grow(type.limits.n)

    def grow(self, n: int):
        if self.type.limits.m and self.size + n > self.type.limits.m:
            raise Exception('pywasm: out of memory limit')
        # If len is larger than 2**16, then fail
        if self.size + n > memory_page:
            raise Exception('pywasm: out of memory limit')
        self.data.extend([0x00 for _ in range(n * memory_page_size)])
        self.size += n


class GlobalInstance:
    # A global instance is the runtime representation of a global variable. It holds an individual value and a flag
    # indicating whether it is mutable.
    #
    # globalinst ::= {value val, mut mut}
    #
    # The value of mutable globals can be mutated through variable instructions or by external means provided by the
    # embedder.
    def __init__(self, value: Val, mut: core.Mut):
        self.value = value
        self.mut = mut


# An external value is the runtime representation of an entity that can be imported or exported. It is an address
# denoting either a function instance, table instance, memory instance, or global instances in the shared store.
#
# externval ::= func funcaddr
#             | table tableaddr
#             | mem memaddr
#             | global globaladdr
ExternValue = typing.Union[FunctionAddress, TableAddress, MemoryAddress, GlobalAddress]


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
        self.function_list: typing.List[FunctionInstance] = []
        self.table_list: typing.List[TableInstance] = []
        self.memory_list: typing.List[MemoryInstance] = []
        self.global_list: typing.List[GlobalInstance] = []

        # For compatibility with older 0.4.x versions
        self.mems = self.memory_list

    def allocate_wasm_function(self, module: ModuleInstance, function: core.Function) -> FunctionAddress:
        function_address = FunctionAddress(len(self.function_list))
        function_type = module.type_list[function.type_index]
        wasmfunc = WasmFunc(function_type, module, function)
        self.function_list.append(wasmfunc)
        return function_address

    def allocate_host_function(self, hostfunc: HostFunc) -> FunctionAddress:
        function_address = FunctionAddress(len(self.function_list))
        self.function_list.append(hostfunc)
        return function_address

    def allocate_table(self, table_type: core.TableType) -> TableAddress:
        table_address = TableAddress(len(self.table_list))
        table_instance = TableInstance(core.ElemType.funcref(), table_type.limits)
        self.table_list.append(table_instance)
        return table_address

    def allocate_memory(self, memory_type: core.MemType) -> MemoryAddress:
        memory_address = MemoryAddress(len(self.memory_list))
        memory_instance = MemoryInstance(memory_type)
        self.memory_list.append(memory_instance)
        return memory_address

    def allocate_global(self, global_type: core.GlobalType, value: Val) -> GlobalAddress:
        global_address = GlobalAddress(len(self.global_list))
        global_instance = GlobalInstance(value, global_type.mut)
        self.global_list.append(global_instance)
        return global_address


class ExportInstance:
    # An export instance is the runtime representation of an export. It defines the export's name and the associated
    # external value.
    #
    # exportinst ::= {name name, value externval}
    def __init__(self, name: str, value: ExternValue):
        self.name = name
        self.value = value

    def __repr__(self):
        return f'export_instance({self.name}, {self.value})'


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
        return f'label({self.arity})'


class Frame:
    # Activation frames carry the return arity n of the respective function, hold the values of its locals
    # (including arguments) in the order corresponding to their static local indices, and a reference to the function's
    # own module instance.

    def __init__(self, module: ModuleInstance,
                 local_list: typing.List[Val],
                 expr: core.Expr,
                 arity: int):
        self.module = module
        self.local_list = local_list
        self.expr = expr
        self.arity = arity

    def __repr__(self):
        return f'frame({self.arity}, {self.local_list})'


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
        self.data: typing.List[typing.Union[Val, Label, Frame]] = []

    def len(self):
        return len(self.data)

    def append(self, v: typing.Union[Val, Label, Frame]):
        self.data.append(v)

    def pop(self):
        return self.data.pop()


# ======================================================================================================================
# Execution Runtime Import Matching
# ======================================================================================================================


def match_limits(a: core.Limits, b: core.Limits) -> bool:
    if a.n >= b.n:
        if b.m == 0:
            return 1
        if a.m != 0 and b.m != 0:
            if a.m < b.m:
                return 1
    return 0


def match_function(a: core.FuncType, b: core.FuncType) -> bool:
    return a.args.data == b.args.data and a.rets.data == b.rets.data


def match_memory(a: core.MemType, b: core.MemType) -> bool:
    return match_limits(a.limits, b.limits)


# ======================================================================================================================
# Abstract Machine
# ======================================================================================================================

class Configuration:
    # A configuration consists of the current store and an executing thread.
    # A thread is a computation over instructions that operates relative to a current frame referring to the module
    # instance in which the computation runs, i.e., where the current function originates from.
    #
    # config ::= store;thread
    # thread ::= frame;instr∗
    def __init__(self, store: Store):
        self.store = store
        self.frame: typing.Optional[Frame] = None
        self.stack = Stack()
        self.depth = 0
        self.pc = 0
        self.opts: option.Option = option.Option()

    def get_label(self, i: int) -> Label:
        l = self.stack.len()
        x = i
        for a in range(l):
            j = l - a - 1
            v = self.stack.data[j]
            if isinstance(v, Label):
                if x == 0:
                    return v
                x -= 1

    def set_frame(self, frame: Frame):
        self.frame = frame
        self.stack.append(frame)
        self.stack.append(Label(frame.arity, len(frame.expr.data) - 1))

    def call(self, function_addr: FunctionAddress, function_args: typing.List[Val]) -> Result:
        function = self.store.function_list[function_addr]
        log.debugln(f'call {function}({function_args})')
        for e, t in zip(function_args, function.type.args.data):
            assert e.type == t
        assert len(function.type.rets.data) < 2

        if isinstance(function, WasmFunc):
            local_list = [Val(e, bytearray(8)) for e in function.code.local_list]
            frame = Frame(
                module=function.module,
                local_list=function_args + local_list,
                expr=function.code.expr,
                arity=len(function.type.rets.data),
            )
            self.set_frame(frame)
            return self.exec()
        if isinstance(function, HostFunc):
            r = function.hostcode(self.store, *[e.into_auto() for e in function_args])
            l = len(function.type.rets.data)
            if l == 0:
                return Result([])
            if l == 1:
                return Result([Val.from_auto(function.type.rets.data[0], r)])
            return [Val.from_auto(e, r[i]) for i, e in enumerate(function.type.rets.data)]
        raise Exception(f'pywasm: unknown function type: {function}')

    def exec(self):
        instruction_list = self.frame.expr.data
        instruction_list_len = len(instruction_list)
        while self.pc < instruction_list_len:
            i = instruction_list[self.pc]
            if self.opts.cycle_limit > 0:
                c = self.opts.cycle + self.opts.instruction_cycle_func(i)
                if c > self.opts.cycle_limit:
                    raise Exception(f'pywasm: out of cycles')
                self.opts.cycle = c
            ArithmeticLogicUnit.exec(self, i)
            self.pc += 1
        r = [self.stack.pop() for _ in range(self.frame.arity)][::-1]
        l = self.stack.pop()
        assert l == self.frame
        return Result(r)


# ======================================================================================================================
# Instruction Set
# ======================================================================================================================


class ArithmeticLogicUnit:

    @staticmethod
    def exec(config: Configuration, i: core.Instruction):
        if log.lvl > 0:
            log.println('|', i)
        func = _INSTRUCTION_TABLE[i.opcode]
        func(config, i)

    @staticmethod
    def unreachable(config: Configuration, i: core.Instruction):
        raise Exception('pywasm: unreachable')

    @staticmethod
    def nop(config: Configuration, i: core.Instruction):
        pass

    @staticmethod
    def block(config: Configuration, i: core.Instruction):
        arity = i.args[0].type
        assert arity < 2
        continuation = config.frame.expr.position[config.pc][1]
        config.stack.append(Label(arity, continuation))

    @staticmethod
    def loop(config: Configuration, i: core.Instruction):
        arity = i.args[0].type
        assert arity < 2
        continuation = config.frame.expr.position[config.pc][0]
        config.stack.append(Label(arity, continuation))

    @staticmethod
    def if_then(config: Configuration, i: core.Instruction):
        c = config.stack.pop().into_i32()
        arity = i.args[0].type
        assert arity < 2
        continuation = config.frame.expr.position[config.pc][1]
        config.stack.append(Label(arity, continuation))
        if c == 0:
            if len(config.frame.expr.position[config.pc]) == 3:
                config.pc = config.frame.expr.position[config.pc][2]
            else:
                config.pc = config.frame.expr.position[config.pc][1]
                config.stack.pop()

    @staticmethod
    def else_fi(config: Configuration, i: core.Instruction):
        L = config.get_label(0)
        v = [config.stack.pop() for _ in range(L.arity)][::-1]
        while True:
            if isinstance(config.stack.pop(), Label):
                break
        for e in v:
            config.stack.append(e)
        config.pc = config.frame.expr.position[config.pc][1]

    @staticmethod
    def end(config: Configuration, i: core.Instruction):
        L = config.get_label(0)
        v = [config.stack.pop() for _ in range(L.arity)][::-1]
        while True:
            if isinstance(config.stack.pop(), Label):
                break
        for e in v:
            config.stack.append(e)

    @staticmethod
    def br_label(config: Configuration, l: int):
        # Let L be the l-th label appearing on the stack, starting from the top and counting from zero.
        L = config.get_label(l)
        # Pop the values n from the stack.
        v = [config.stack.pop() for _ in range(L.arity)][::-1]
        # Repeat l+1 times
        #     While the top of the stack is a value, pop the value from the stack
        #     Assert: due to validation, the top of the stack now is a label
        #     Pop the label from the stack
        s = 0
        # For loops we keep the label which represents the loop on the stack since the continuation of a loop is
        # beginning back at the beginning of the loop itself.
        if L.continuation < config.pc:
            n = l
        else:
            n = l + 1
        while s != n:
            e = config.stack.pop()
            if isinstance(e, Label):
                s += 1
        # Push the values n to the stack
        for e in v:
            config.stack.append(e)
        # Jump to the continuation of L
        config.pc = L.continuation

    @staticmethod
    def br(config: Configuration, i: core.Instruction):
        l = i.args[0]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def br_if(config: Configuration, i: core.Instruction):
        if config.stack.pop().into_i32() == 0:
            return
        l = i.args[0]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def br_table(config: Configuration, i: core.Instruction):
        a = i.args[0]
        l = i.args[1]
        c = config.stack.pop().into_i32()
        if c >= 0 and c < len(a):
            l = a[c]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def return_call(config: Configuration, i: core.Instruction):
        v = [config.stack.pop() for _ in range(config.frame.arity)][::-1]
        while True:
            e = config.stack.pop()
            if isinstance(e, Frame):
                config.stack.append(e)
                break
        for e in v:
            config.stack.append(e)
        # Jump to the instruction after the original call that pushed the frame
        config.pc = len(config.frame.expr.data) - 1

    @staticmethod
    def call_function_addr(config: Configuration, function_addr: FunctionAddress):
        if config.depth > call_stack_depth:
            raise Exception('pywasm: call stack exhausted')

        function: FunctionInstance = config.store.function_list[function_addr]
        function_type = function.type
        function_args = [config.stack.pop() for _ in function_type.args.data][::-1]

        subcnf = Configuration(config.store)
        subcnf.depth = config.depth + 1
        subcnf.opts = config.opts
        r = subcnf.call(function_addr, function_args)
        for e in r.data:
            config.stack.append(e)

    @staticmethod
    def call(config: Configuration, i: core.Instruction):
        function_addr: int = i.args[0]
        ArithmeticLogicUnit.call_function_addr(config, function_addr)

    @staticmethod
    def call_indirect(config: Configuration, i: core.Instruction):
        if i.args[1] != 0x00:
            raise Exception("pywasm: zero byte malformed in call_indirect")
        ta = config.frame.module.table_addr_list[0]
        tab = config.store.table_list[ta]
        idx = config.stack.pop().into_i32()
        if not 0 <= idx < len(tab.element_list):
            raise Exception('pywasm: undefined element')
        function_addr = tab.element_list[idx]
        if function_addr is None:
            raise Exception('pywasm: uninitialized element')
        ArithmeticLogicUnit.call_function_addr(config, function_addr)

    @staticmethod
    def drop(config: Configuration, i: core.Instruction):
        config.stack.pop()

    @staticmethod
    def select(config: Configuration, i: core.Instruction):
        c = config.stack.pop().into_i32()
        b = config.stack.pop()
        a = config.stack.pop()
        if c:
            config.stack.append(a)
        else:
            config.stack.append(b)

    @staticmethod
    def local_get(config: Configuration, i: core.Instruction):
        r = config.frame.local_list[i.args[0]]
        o = Val(r.type, r.data.copy())
        config.stack.append(o)

    @staticmethod
    def local_set(config: Configuration, i: core.Instruction):
        r = config.stack.pop()
        config.frame.local_list[i.args[0]] = r

    @staticmethod
    def local_tee(config: Configuration, i: core.Instruction):
        r = config.stack.data[-1]
        o = Val(r.type, r.data.copy())
        config.frame.local_list[i.args[0]] = o

    @staticmethod
    def global_get(config: Configuration, i: core.Instruction):
        a = config.frame.module.global_addr_list[i.args[0]]
        glob = config.store.global_list[a]
        r = glob.value
        config.stack.append(r)

    @staticmethod
    def global_set(config: Configuration, i: core.Instruction):
        a = config.frame.module.global_addr_list[i.args[0]]
        glob = config.store.global_list[a]
        assert glob.mut == core.Mut.var()
        glob.value = config.stack.pop()

    @staticmethod
    def mem_load(config: Configuration, i: core.Instruction, size: int) -> bytearray:
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        offset = i.args[1]
        addr = config.stack.pop().into_i32() + offset
        if addr < 0 or addr + size > len(memory.data):
            raise Exception('pywasm: out of bounds memory access')
        return memory.data[addr:addr + size]

    @staticmethod
    def i32_load(config: Configuration, i: core.Instruction):
        r = Val.from_i32(struct.unpack('<i', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load(config: Configuration, i: core.Instruction):
        r = Val.from_i64(struct.unpack('<q', ArithmeticLogicUnit.mem_load(config, i, 8))[0])
        config.stack.append(r)

    @staticmethod
    def f32_load(config: Configuration, i: core.Instruction):
        r = Val.from_f32(struct.unpack('<f', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def f64_load(config: Configuration, i: core.Instruction):
        r = Val.from_f64(struct.unpack('<d', ArithmeticLogicUnit.mem_load(config, i, 8))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load8_s(config: Configuration, i: core.Instruction):
        r = Val.from_i32(struct.unpack('<b', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load8_u(config: Configuration, i: core.Instruction):
        r = Val.from_i32(struct.unpack('<B', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load16_s(config: Configuration, i: core.Instruction):
        r = Val.from_i32(struct.unpack('<h', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load16_u(config: Configuration, i: core.Instruction):
        r = Val.from_i32(struct.unpack('<H', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load8_s(config: Configuration, i: core.Instruction):
        r = Val.from_i64(struct.unpack('<b', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load8_u(config: Configuration, i: core.Instruction):
        r = Val.from_i64(struct.unpack('<B', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load16_s(config: Configuration, i: core.Instruction):
        r = Val.from_i64(struct.unpack('<h', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load16_u(config: Configuration, i: core.Instruction):
        r = Val.from_i64(struct.unpack('<H', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load32_s(config: Configuration, i: core.Instruction):
        r = Val.from_i64(struct.unpack('<i', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load32_u(config: Configuration, i: core.Instruction):
        r = Val.from_i64(struct.unpack('<I', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def mem_store(config: Configuration, i: core.Instruction, size: int):
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        r = config.stack.pop()
        offset = i.args[1]
        addr = config.stack.pop().into_i32() + offset
        if addr < 0 or addr + size > len(memory.data):
            raise Exception('pywasm: out of bounds memory access')
        memory.data[addr:addr + size] = r.data[0:size]

    @staticmethod
    def i32_store(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def i64_store(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 8)

    @staticmethod
    def f32_store(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def f64_store(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 8)

    @staticmethod
    def i32_store8(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 1)

    @staticmethod
    def i32_store16(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 2)

    @staticmethod
    def i64_store8(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def i64_store16(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 2)

    @staticmethod
    def i64_store32(config: Configuration, i: core.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def memory_size(config: Configuration, i: core.Instruction):
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        r = Val.from_i32(memory.size)
        config.stack.append(r)

    @staticmethod
    def memory_grow(config: Configuration, i: core.Instruction):
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        size = memory.size
        r = config.stack.pop().into_i32()
        if config.opts.pages_limit > 0 and memory.size + r > config.opts.pages_limit:
            raise Exception('pywasm: out of memory limit')
        try:
            memory.grow(r)
            config.stack.append(Val.from_i32(size))
        except Exception:
            config.stack.append(Val.from_i32(-1))

    @staticmethod
    def i32_const(config: Configuration, i: core.Instruction):
        config.stack.append(i.args[0])

    @staticmethod
    def i64_const(config: Configuration, i: core.Instruction):
        config.stack.append(i.args[0])

    @staticmethod
    def f32_const(config: Configuration, i: core.Instruction):
        config.stack.append(i.args[0])

    @staticmethod
    def f64_const(config: Configuration, i: core.Instruction):
        config.stack.append(i.args[0])

    @staticmethod
    def i32_eqz(config: Configuration, i: core.Instruction):
        config.stack.append(Val.from_i32(config.stack.pop().into_i32() == 0))

    @staticmethod
    def i32_eq(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(Val.from_i32(a == b))

    @staticmethod
    def i32_ne(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(Val.from_i32(a != b))

    @staticmethod
    def i32_lt_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(Val.from_i32(a < b))

    @staticmethod
    def i32_lt_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(Val.from_i32(a < b))

    @staticmethod
    def i32_gt_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(Val.from_i32(a > b))

    @staticmethod
    def i32_gt_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(Val.from_i32(a > b))

    @staticmethod
    def i32_le_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(Val.from_i32(a <= b))

    @staticmethod
    def i32_le_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(Val.from_i32(a <= b))

    @staticmethod
    def i32_ge_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(Val.from_i32(int(a >= b)))

    @staticmethod
    def i32_ge_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(Val.from_i32(int(a >= b)))

    @staticmethod
    def i64_eqz(config: Configuration, i: core.Instruction):
        config.stack.append(Val.from_i32(config.stack.pop().into_i64() == 0))

    @staticmethod
    def i64_eq(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(Val.from_i32(a == b))

    @staticmethod
    def i64_ne(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(Val.from_i32(a != b))

    @staticmethod
    def i64_lt_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(Val.from_i32(a < b))

    @staticmethod
    def i64_lt_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(Val.from_i32(a < b))

    @staticmethod
    def i64_gt_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(Val.from_i32(a > b))

    @staticmethod
    def i64_gt_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(Val.from_i32(a > b))

    @staticmethod
    def i64_le_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(Val.from_i32(a <= b))

    @staticmethod
    def i64_le_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(Val.from_i32(a <= b))

    @staticmethod
    def i64_ge_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(Val.from_i32(a >= b))

    @staticmethod
    def i64_ge_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(Val.from_i32(a >= b))

    @staticmethod
    def f32_eq(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(Val.from_i32(a == b))

    @staticmethod
    def f32_ne(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(Val.from_i32(a != b))

    @staticmethod
    def f32_lt(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(Val.from_i32(a < b))

    @staticmethod
    def f32_gt(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(Val.from_i32(a > b))

    @staticmethod
    def f32_le(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(Val.from_i32(a <= b))

    @staticmethod
    def f32_ge(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(Val.from_i32(a >= b))

    @staticmethod
    def f64_eq(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(Val.from_i32(a == b))

    @staticmethod
    def f64_ne(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(Val.from_i32(a != b))

    @staticmethod
    def f64_lt(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(Val.from_i32(a < b))

    @staticmethod
    def f64_gt(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(Val.from_i32(a > b))

    @staticmethod
    def f64_le(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(Val.from_i32(a <= b))

    @staticmethod
    def f64_ge(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(Val.from_i32(a >= b))

    @staticmethod
    def i32_clz(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i32()
        c = 0
        while c < 32 and (a & 0x80000000) == 0:
            c += 1
            a = a << 1
        config.stack.append(Val.from_i32(c))

    @staticmethod
    def i32_ctz(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i32()
        c = 0
        while c < 32 and (a & 0x01) == 0:
            c += 1
            a = a >> 1
        config.stack.append(Val.from_i32(c))

    @staticmethod
    def i32_popcnt(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i32()
        c = 0
        for _ in range(32):
            if a & 0x01:
                c += 1
            a = a >> 1
        config.stack.append(Val.from_i32(c))

    @staticmethod
    def i32_add(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a + b)
        config.stack.append(c)

    @staticmethod
    def i32_sub(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a - b)
        config.stack.append(c)

    @staticmethod
    def i32_mul(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a * b)
        config.stack.append(c)

    @staticmethod
    def i32_div_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        if b == -1 and a == -2**31:
            raise Exception('pywasm: integer overflow')
        # Integer division that rounds towards 0 (like C)
        r = Val.from_i32(a // b if a * b > 0 else (a + (-a % b)) // b)
        config.stack.append(r)

    @staticmethod
    def i32_div_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Val.from_i32(a // b)
        config.stack.append(r)

    @staticmethod
    def i32_rem_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        # Integer remainder that rounds towards 0 (like C)
        r = Val.from_i32(a % b if a * b > 0 else -(-a % b))
        config.stack.append(r)

    @staticmethod
    def i32_rem_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Val.from_i32(a % b)
        config.stack.append(r)

    @staticmethod
    def i32_and(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a & b)
        config.stack.append(c)

    @staticmethod
    def i32_or(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a | b)
        config.stack.append(c)

    @staticmethod
    def i32_xor(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a ^ b)
        config.stack.append(c)

    @staticmethod
    def i32_shl(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a << (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_shr_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = Val.from_i32(a >> (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_shr_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        c = Val.from_i32(a >> (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_rotl(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_u32()
        c = Val.from_i32((((a << (b % 0x20)) & 0xffffffff) | (a >> (0x20 - (b % 0x20)))))
        config.stack.append(c)

    @staticmethod
    def i32_rotr(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_u32()
        c = Val.from_i32(((a >> (b % 0x20)) | ((a << (0x20 - (b % 0x20))) & 0xffffffff)))
        config.stack.append(c)

    @staticmethod
    def i64_clz(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i64()
        c = 0
        while c < 64 and (a & 0x8000000000000000) == 0:
            c += 1
            a = a << 1
        config.stack.append(Val.from_i64(c))

    @staticmethod
    def i64_ctz(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i64()
        c = 0
        while c < 64 and (a & 0x01) == 0:
            c += 1
            a = a >> 1
        config.stack.append(Val.from_i64(c))

    @staticmethod
    def i64_popcnt(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i64()
        c = 0
        for _ in range(64):
            if a & 0x01:
                c += 1
            a = a >> 1
        config.stack.append(Val.from_i64(c))

    @staticmethod
    def i64_add(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a + b)
        config.stack.append(c)

    @staticmethod
    def i64_sub(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a - b)
        config.stack.append(c)

    @staticmethod
    def i64_mul(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a * b)
        config.stack.append(c)

    @staticmethod
    def i64_div_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        if b == -1 and a == -2**63:
            raise Exception('pywasm: integer overflow')
        r = Val.from_i64(a // b if a * b > 0 else (a + (-a % b)) // b)
        config.stack.append(r)

    @staticmethod
    def i64_div_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Val.from_i64(a // b)
        config.stack.append(r)

    @staticmethod
    def i64_rem_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        # Integer remainder that rounds towards 0 (like C)
        r = Val.from_i64(a % b if a * b > 0 else -(-a % b))
        config.stack.append(r)

    @staticmethod
    def i64_rem_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Val.from_i64(a % b)
        config.stack.append(r)

    @staticmethod
    def i64_and(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a & b)
        config.stack.append(c)

    @staticmethod
    def i64_or(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a | b)
        config.stack.append(c)

    @staticmethod
    def i64_xor(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a & b)
        config.stack.append(c)

    @staticmethod
    def i64_shl(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a << (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_shr_s(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = Val.from_i64(a >> (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_shr_u(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        c = Val.from_i64(a >> (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_rotl(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_u64()
        c = Val.from_i64((((a << (b % 0x40)) & 0xffffffffffffffff) | (a >> (0x40 - (b % 0x40)))))
        config.stack.append(c)

    @staticmethod
    def i64_rotr(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_u64()
        c = Val.from_i64(((a >> (b % 0x40)) | ((a << (0x40 - (b % 0x40))) & 0xffffffffffffffff)))
        config.stack.append(c)

    @staticmethod
    def f32_abs(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        a.data[3] = a.data[3] & 0x7f
        config.stack.append(a)

    @staticmethod
    def f32_neg(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        if a.data[3] & 0x80 != 0x00:
            a.data[3] = a.data[3] & 0x7f
        else:
            a.data[3] = a.data[3] | 0x80
        config.stack.append(a)

    @staticmethod
    def f32_ceil(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        try:
            r = Val.from_f32(float(math.ceil(a)))
        except OverflowError:
            r = Val.from_f32(a)
        except ValueError:
            r = Val.from_f32(a)
        config.stack.append(r)

    @staticmethod
    def f32_floor(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        try:
            r = Val.from_f32(float(math.floor(a)))
        except OverflowError:
            r = Val.from_f32(a)
        except ValueError:
            r = Val.from_f32(a)
        config.stack.append(r)

    @staticmethod
    def f32_trunc(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        try:
            r = Val.from_f32(float(math.trunc(a)))
        except OverflowError:
            r = Val.from_f32(a)
        except ValueError:
            r = Val.from_f32(a)
        config.stack.append(r)

    @staticmethod
    def f32_nearest(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        try:
            r = Val.from_f32(float(round(a)))
        except OverflowError:
            r = Val.from_f32(math.inf)
        except ValueError:
            r = Val.from_f32(math.nan)
        config.stack.append(r)

    @staticmethod
    def f32_sqrt(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        try:
            r = Val.from_f32(math.sqrt(a))
        except ValueError:
            r = Val.from_f32(math.nan)
        config.stack.append(r)

    @staticmethod
    def f32_add(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = Val.from_f32(a + b)
        config.stack.append(r)

    @staticmethod
    def f32_sub(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = Val.from_f32(a - b)
        config.stack.append(r)

    @staticmethod
    def f32_mul(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = Val.from_f32(a * b)
        config.stack.append(r)

    @staticmethod
    def f32_div(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        try:
            c = a / b
        except ZeroDivisionError:
            if math.copysign(a, b) == a:
                sign = +1
            else:
                sign = -1
            if a == 0:
                c = sign * math.nan
            elif math.isnan(a):
                c = sign * math.nan
            else:
                c = sign * math.inf
        r = Val.from_f32(c)
        config.stack.append(r)

    @staticmethod
    def f32_min(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(Val.from_f32(math.nan))
        else:
            config.stack.append(Val.from_f32(a if a < b else b))

    @staticmethod
    def f32_max(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(Val.from_f32(math.nan))
        else:
            config.stack.append(Val.from_f32(a if a > b else b))

    @staticmethod
    def f32_copysign(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = Val.from_f32(math.copysign(a, b))
        config.stack.append(r)

    @staticmethod
    def f64_abs(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        a.data[7] = a.data[7] & 0x7f
        config.stack.append(a)

    @staticmethod
    def f64_neg(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        if a.data[7] & 0x80 != 0x00:
            a.data[7] = a.data[7] & 0x7f
        else:
            a.data[7] = a.data[7] | 0x80
        config.stack.append(a)

    @staticmethod
    def f64_ceil(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        try:
            r = Val.from_f64(float(math.ceil(a)))
        except OverflowError:
            r = Val.from_f64(a)
        except ValueError:
            r = Val.from_f64(a)
        config.stack.append(r)

    @staticmethod
    def f64_floor(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        try:
            r = Val.from_f64(float(math.floor(a)))
        except OverflowError:
            r = Val.from_f64(a)
        except ValueError:
            r = Val.from_f64(a)
        config.stack.append(r)

    @staticmethod
    def f64_trunc(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        try:
            r = Val.from_f64(float(math.trunc(a)))
        except OverflowError:
            r = Val.from_f64(a)
        except ValueError:
            r = Val.from_f64(a)
        config.stack.append(r)

    @staticmethod
    def f64_nearest(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        try:
            r = Val.from_f64(float(round(a)))
        except OverflowError:
            r = Val.from_f64(math.inf)
        except ValueError:
            r = Val.from_f64(math.nan)
        config.stack.append(r)

    @staticmethod
    def f64_sqrt(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        try:
            r = Val.from_f64(math.sqrt(a))
        except ValueError:
            r = Val.from_f64(math.nan)
        config.stack.append(r)

    @staticmethod
    def f64_add(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = Val.from_f64(a + b)
        config.stack.append(r)

    @staticmethod
    def f64_sub(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = Val.from_f64(a - b)
        config.stack.append(r)

    @staticmethod
    def f64_mul(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = Val.from_f64(a * b)
        config.stack.append(r)

    @staticmethod
    def f64_div(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        try:
            c = a / b
        except ZeroDivisionError:
            if math.copysign(a, b) == a:
                sign = +1
            else:
                sign = -1
            if a == 0:
                c = sign * math.nan
            elif math.isnan(a):
                c = sign * math.nan
            else:
                c = sign * math.inf
        r = Val.from_f64(c)
        config.stack.append(r)

    @staticmethod
    def f64_min(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(Val.from_f64(math.nan))
        else:
            config.stack.append(Val.from_f64(a if a < b else b))

    @staticmethod
    def f64_max(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(Val.from_f64(math.nan))
        else:
            config.stack.append(Val.from_f64(a if a > b else b))

    @staticmethod
    def f64_copysign(config: Configuration, i: core.Instruction):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = Val.from_f64(math.copysign(a, b))
        config.stack.append(r)

    @staticmethod
    def i32_wrap_i64(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i64()
        config.stack.append(Val.from_i32(a))

    @staticmethod
    def i32_trunc_f32_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        if a > (1 << 31) - 1 or a < -(1 << 31):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_f32_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        if a > (1 << 32) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_f64_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        if a > (1 << 31) - 1 or a < -(1 << 31):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_f64_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        if a > (1 << 32) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i64_extend_i32_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i32()
        r = Val.from_i64(a)
        config.stack.append(r)

    @staticmethod
    def i64_extend_i32_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_u32()
        r = Val.from_i64(a)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f32_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        if a > (1 << 63) - 1 or a < -(1 << 63):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f32_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        if a > (1 << 64) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f64_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        if a > (1 << 63) - 1 or a < -(1 << 63):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f64_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        if a > (1 << 64) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Val.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def f32_convert_i32_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i32()
        r = Val.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_i32_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_u32()
        r = Val.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_i64_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i64()
        r = Val.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_i64_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_u64()
        r = Val.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_demote_f64(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f64()
        r = Val.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i32_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i32()
        r = Val.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i32_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_u32()
        r = Val.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i64_s(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_i64()
        r = Val.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i64_u(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_u64()
        r = Val.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_promote_f32(config: Configuration, i: core.Instruction):
        a = config.stack.pop().into_f32()
        r = Val.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def i32_reinterpret_f32(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        a.type = core.ValType.i32()
        config.stack.append(a)

    @staticmethod
    def i64_reinterpret_f64(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        a.type = core.ValType.i64()
        config.stack.append(a)

    @staticmethod
    def f32_reinterpret_i32(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        a.type = core.ValType.f32()
        config.stack.append(a)

    @staticmethod
    def f64_reinterpret_i64(config: Configuration, i: core.Instruction):
        a = config.stack.pop()
        a.type = core.ValType.f64()
        config.stack.append(a)


def _make_instruction_table():
    table = [None for i in range(max(opcode.name) + 1)]

    table[opcode.unreachable] = ArithmeticLogicUnit.unreachable
    table[opcode.nop] = ArithmeticLogicUnit.nop
    table[opcode.block] = ArithmeticLogicUnit.block
    table[opcode.loop] = ArithmeticLogicUnit.loop
    table[opcode.if_then] = ArithmeticLogicUnit.if_then
    table[opcode.else_fi] = ArithmeticLogicUnit.else_fi
    table[opcode.end] = ArithmeticLogicUnit.end
    table[opcode.br] = ArithmeticLogicUnit.br
    table[opcode.br_if] = ArithmeticLogicUnit.br_if
    table[opcode.br_table] = ArithmeticLogicUnit.br_table
    table[opcode.return_call] = ArithmeticLogicUnit.return_call
    table[opcode.call] = ArithmeticLogicUnit.call
    table[opcode.call_indirect] = ArithmeticLogicUnit.call_indirect
    table[opcode.drop] = ArithmeticLogicUnit.drop
    table[opcode.select] = ArithmeticLogicUnit.select
    table[opcode.local_get] = ArithmeticLogicUnit.local_get
    table[opcode.local_set] = ArithmeticLogicUnit.local_set
    table[opcode.local_tee] = ArithmeticLogicUnit.local_tee
    table[opcode.global_get] = ArithmeticLogicUnit.global_get
    table[opcode.global_set] = ArithmeticLogicUnit.global_set
    table[opcode.i32_load] = ArithmeticLogicUnit.i32_load
    table[opcode.i64_load] = ArithmeticLogicUnit.i64_load
    table[opcode.f32_load] = ArithmeticLogicUnit.f32_load
    table[opcode.f64_load] = ArithmeticLogicUnit.f64_load
    table[opcode.i32_load8_s] = ArithmeticLogicUnit.i32_load8_s
    table[opcode.i32_load8_u] = ArithmeticLogicUnit.i32_load8_u
    table[opcode.i32_load16_s] = ArithmeticLogicUnit.i32_load16_s
    table[opcode.i32_load16_u] = ArithmeticLogicUnit.i32_load16_u
    table[opcode.i64_load8_s] = ArithmeticLogicUnit.i64_load8_s
    table[opcode.i64_load8_u] = ArithmeticLogicUnit.i64_load8_u
    table[opcode.i64_load16_s] = ArithmeticLogicUnit.i64_load16_s
    table[opcode.i64_load16_u] = ArithmeticLogicUnit.i64_load16_u
    table[opcode.i64_load32_s] = ArithmeticLogicUnit.i64_load32_s
    table[opcode.i64_load32_u] = ArithmeticLogicUnit.i64_load32_u
    table[opcode.i32_store] = ArithmeticLogicUnit.i32_store
    table[opcode.i64_store] = ArithmeticLogicUnit.i64_store
    table[opcode.f32_store] = ArithmeticLogicUnit.f32_store
    table[opcode.f64_store] = ArithmeticLogicUnit.f64_store
    table[opcode.i32_store8] = ArithmeticLogicUnit.i32_store8
    table[opcode.i32_store16] = ArithmeticLogicUnit.i32_store16
    table[opcode.i64_store8] = ArithmeticLogicUnit.i64_store8
    table[opcode.i64_store16] = ArithmeticLogicUnit.i64_store16
    table[opcode.i64_store32] = ArithmeticLogicUnit.i64_store32
    table[opcode.memory_size] = ArithmeticLogicUnit.memory_size
    table[opcode.memory_grow] = ArithmeticLogicUnit.memory_grow
    table[opcode.i32_const] = ArithmeticLogicUnit.i32_const
    table[opcode.i64_const] = ArithmeticLogicUnit.i64_const
    table[opcode.f32_const] = ArithmeticLogicUnit.f32_const
    table[opcode.f64_const] = ArithmeticLogicUnit.f64_const
    table[opcode.i32_eqz] = ArithmeticLogicUnit.i32_eqz
    table[opcode.i32_eq] = ArithmeticLogicUnit.i32_eq
    table[opcode.i32_ne] = ArithmeticLogicUnit.i32_ne
    table[opcode.i32_lt_s] = ArithmeticLogicUnit.i32_lt_s
    table[opcode.i32_lt_u] = ArithmeticLogicUnit.i32_lt_u
    table[opcode.i32_gt_s] = ArithmeticLogicUnit.i32_gt_s
    table[opcode.i32_gt_u] = ArithmeticLogicUnit.i32_gt_u
    table[opcode.i32_le_s] = ArithmeticLogicUnit.i32_le_s
    table[opcode.i32_le_u] = ArithmeticLogicUnit.i32_le_u
    table[opcode.i32_ge_s] = ArithmeticLogicUnit.i32_ge_s
    table[opcode.i32_ge_u] = ArithmeticLogicUnit.i32_ge_u
    table[opcode.i64_eqz] = ArithmeticLogicUnit.i64_eqz
    table[opcode.i64_eq] = ArithmeticLogicUnit.i64_eq
    table[opcode.i64_ne] = ArithmeticLogicUnit.i64_ne
    table[opcode.i64_lt_s] = ArithmeticLogicUnit.i64_lt_s
    table[opcode.i64_lt_u] = ArithmeticLogicUnit.i64_lt_u
    table[opcode.i64_gt_s] = ArithmeticLogicUnit.i64_gt_s
    table[opcode.i64_gt_u] = ArithmeticLogicUnit.i64_gt_u
    table[opcode.i64_le_s] = ArithmeticLogicUnit.i64_le_s
    table[opcode.i64_le_u] = ArithmeticLogicUnit.i64_le_u
    table[opcode.i64_ge_s] = ArithmeticLogicUnit.i64_ge_s
    table[opcode.i64_ge_u] = ArithmeticLogicUnit.i64_ge_u
    table[opcode.f32_eq] = ArithmeticLogicUnit.f32_eq
    table[opcode.f32_ne] = ArithmeticLogicUnit.f32_ne
    table[opcode.f32_lt] = ArithmeticLogicUnit.f32_lt
    table[opcode.f32_gt] = ArithmeticLogicUnit.f32_gt
    table[opcode.f32_le] = ArithmeticLogicUnit.f32_le
    table[opcode.f32_ge] = ArithmeticLogicUnit.f32_ge
    table[opcode.f64_eq] = ArithmeticLogicUnit.f64_eq
    table[opcode.f64_ne] = ArithmeticLogicUnit.f64_ne
    table[opcode.f64_lt] = ArithmeticLogicUnit.f64_lt
    table[opcode.f64_gt] = ArithmeticLogicUnit.f64_gt
    table[opcode.f64_le] = ArithmeticLogicUnit.f64_le
    table[opcode.f64_ge] = ArithmeticLogicUnit.f64_ge
    table[opcode.i32_clz] = ArithmeticLogicUnit.i32_clz
    table[opcode.i32_ctz] = ArithmeticLogicUnit.i32_ctz
    table[opcode.i32_popcnt] = ArithmeticLogicUnit.i32_popcnt
    table[opcode.i32_add] = ArithmeticLogicUnit.i32_add
    table[opcode.i32_sub] = ArithmeticLogicUnit.i32_sub
    table[opcode.i32_mul] = ArithmeticLogicUnit.i32_mul
    table[opcode.i32_div_s] = ArithmeticLogicUnit.i32_div_s
    table[opcode.i32_div_u] = ArithmeticLogicUnit.i32_div_u
    table[opcode.i32_rem_s] = ArithmeticLogicUnit.i32_rem_s
    table[opcode.i32_rem_u] = ArithmeticLogicUnit.i32_rem_u
    table[opcode.i32_and] = ArithmeticLogicUnit.i32_and
    table[opcode.i32_or] = ArithmeticLogicUnit.i32_or
    table[opcode.i32_xor] = ArithmeticLogicUnit.i32_xor
    table[opcode.i32_shl] = ArithmeticLogicUnit.i32_shl
    table[opcode.i32_shr_s] = ArithmeticLogicUnit.i32_shr_s
    table[opcode.i32_shr_u] = ArithmeticLogicUnit.i32_shr_u
    table[opcode.i32_rotl] = ArithmeticLogicUnit.i32_rotl
    table[opcode.i32_rotr] = ArithmeticLogicUnit.i32_rotr
    table[opcode.i64_clz] = ArithmeticLogicUnit.i64_clz
    table[opcode.i64_ctz] = ArithmeticLogicUnit.i64_ctz
    table[opcode.i64_popcnt] = ArithmeticLogicUnit.i64_popcnt
    table[opcode.i64_add] = ArithmeticLogicUnit.i64_add
    table[opcode.i64_sub] = ArithmeticLogicUnit.i64_sub
    table[opcode.i64_mul] = ArithmeticLogicUnit.i64_mul
    table[opcode.i64_div_s] = ArithmeticLogicUnit.i64_div_s
    table[opcode.i64_div_u] = ArithmeticLogicUnit.i64_div_u
    table[opcode.i64_rem_s] = ArithmeticLogicUnit.i64_rem_s
    table[opcode.i64_rem_u] = ArithmeticLogicUnit.i64_rem_u
    table[opcode.i64_and] = ArithmeticLogicUnit.i64_and
    table[opcode.i64_or] = ArithmeticLogicUnit.i64_or
    table[opcode.i64_xor] = ArithmeticLogicUnit.i64_xor
    table[opcode.i64_shl] = ArithmeticLogicUnit.i64_shl
    table[opcode.i64_shr_s] = ArithmeticLogicUnit.i64_shr_s
    table[opcode.i64_shr_u] = ArithmeticLogicUnit.i64_shr_u
    table[opcode.i64_rotl] = ArithmeticLogicUnit.i64_rotl
    table[opcode.i64_rotr] = ArithmeticLogicUnit.i64_rotr
    table[opcode.f32_abs] = ArithmeticLogicUnit.f32_abs
    table[opcode.f32_neg] = ArithmeticLogicUnit.f32_neg
    table[opcode.f32_ceil] = ArithmeticLogicUnit.f32_ceil
    table[opcode.f32_floor] = ArithmeticLogicUnit.f32_floor
    table[opcode.f32_trunc] = ArithmeticLogicUnit.f32_trunc
    table[opcode.f32_nearest] = ArithmeticLogicUnit.f32_nearest
    table[opcode.f32_sqrt] = ArithmeticLogicUnit.f32_sqrt
    table[opcode.f32_add] = ArithmeticLogicUnit.f32_add
    table[opcode.f32_sub] = ArithmeticLogicUnit.f32_sub
    table[opcode.f32_mul] = ArithmeticLogicUnit.f32_mul
    table[opcode.f32_div] = ArithmeticLogicUnit.f32_div
    table[opcode.f32_min] = ArithmeticLogicUnit.f32_min
    table[opcode.f32_max] = ArithmeticLogicUnit.f32_max
    table[opcode.f32_copysign] = ArithmeticLogicUnit.f32_copysign
    table[opcode.f64_abs] = ArithmeticLogicUnit.f64_abs
    table[opcode.f64_neg] = ArithmeticLogicUnit.f64_neg
    table[opcode.f64_ceil] = ArithmeticLogicUnit.f64_ceil
    table[opcode.f64_floor] = ArithmeticLogicUnit.f64_floor
    table[opcode.f64_trunc] = ArithmeticLogicUnit.f64_trunc
    table[opcode.f64_nearest] = ArithmeticLogicUnit.f64_nearest
    table[opcode.f64_sqrt] = ArithmeticLogicUnit.f64_sqrt
    table[opcode.f64_add] = ArithmeticLogicUnit.f64_add
    table[opcode.f64_sub] = ArithmeticLogicUnit.f64_sub
    table[opcode.f64_mul] = ArithmeticLogicUnit.f64_mul
    table[opcode.f64_div] = ArithmeticLogicUnit.f64_div
    table[opcode.f64_min] = ArithmeticLogicUnit.f64_min
    table[opcode.f64_max] = ArithmeticLogicUnit.f64_max
    table[opcode.f64_copysign] = ArithmeticLogicUnit.f64_copysign
    table[opcode.i32_wrap_i64] = ArithmeticLogicUnit.i32_wrap_i64
    table[opcode.i32_trunc_f32_s] = ArithmeticLogicUnit.i32_trunc_f32_s
    table[opcode.i32_trunc_f32_u] = ArithmeticLogicUnit.i32_trunc_f32_u
    table[opcode.i32_trunc_f64_s] = ArithmeticLogicUnit.i32_trunc_f64_s
    table[opcode.i32_trunc_f64_u] = ArithmeticLogicUnit.i32_trunc_f64_u
    table[opcode.i64_extend_i32_s] = ArithmeticLogicUnit.i64_extend_i32_s
    table[opcode.i64_extend_i32_u] = ArithmeticLogicUnit.i64_extend_i32_u
    table[opcode.i64_trunc_f32_s] = ArithmeticLogicUnit.i64_trunc_f32_s
    table[opcode.i64_trunc_f32_u] = ArithmeticLogicUnit.i64_trunc_f32_u
    table[opcode.i64_trunc_f64_s] = ArithmeticLogicUnit.i64_trunc_f64_s
    table[opcode.i64_trunc_f64_u] = ArithmeticLogicUnit.i64_trunc_f64_u
    table[opcode.f32_convert_i32_s] = ArithmeticLogicUnit.f32_convert_i32_s
    table[opcode.f32_convert_i32_u] = ArithmeticLogicUnit.f32_convert_i32_u
    table[opcode.f32_convert_i64_s] = ArithmeticLogicUnit.f32_convert_i64_s
    table[opcode.f32_convert_i64_u] = ArithmeticLogicUnit.f32_convert_i64_u
    table[opcode.f32_demote_f64] = ArithmeticLogicUnit.f32_demote_f64
    table[opcode.f64_convert_i32_s] = ArithmeticLogicUnit.f64_convert_i32_s
    table[opcode.f64_convert_i32_u] = ArithmeticLogicUnit.f64_convert_i32_u
    table[opcode.f64_convert_i64_s] = ArithmeticLogicUnit.f64_convert_i64_s
    table[opcode.f64_convert_i64_u] = ArithmeticLogicUnit.f64_convert_i64_u
    table[opcode.f64_promote_f32] = ArithmeticLogicUnit.f64_promote_f32
    table[opcode.i32_reinterpret_f32] = ArithmeticLogicUnit.i32_reinterpret_f32
    table[opcode.i64_reinterpret_f64] = ArithmeticLogicUnit.i64_reinterpret_f64
    table[opcode.f32_reinterpret_i32] = ArithmeticLogicUnit.f32_reinterpret_i32
    table[opcode.f64_reinterpret_i64] = ArithmeticLogicUnit.f64_reinterpret_i64

    return table


_INSTRUCTION_TABLE = _make_instruction_table()


class Machine:
    # Execution behavior is defined in terms of an abstract machine that models the program state. It includes a stack,
    # which records operand values and control constructs, and an abstract store containing global state.
    def __init__(self):
        self.module: ModuleInstance = ModuleInstance()
        self.store: Store = Store()
        self.opts: option.Option = option.Option()

    def instantiate(self, module: core.Module, extern_value_list: typing.List[ExternValue]):
        self.module.type_list = module.type_list

        # [TODO] If module is not valid, then panic

        # Assert: module is valid with external types classifying its imports
        for e in extern_value_list:
            if isinstance(e, FunctionAddress):
                assert e < len(self.store.function_list)
            if isinstance(e, TableAddress):
                assert e < len(self.store.table_list)
            if isinstance(e, MemoryAddress):
                assert e < len(self.store.memory_list)
            if isinstance(e, GlobalAddress):
                assert e < len(self.store.global_list)

        # If the number m of imports is not equal to the number n of provided external values, then fail
        assert len(module.import_list) == len(extern_value_list)

        # For each external value and external type, do:
        # If externval is not valid with an external type in store S, then fail
        # If externtype does not match externtype, then fail
        for i, e in enumerate(extern_value_list):
            if isinstance(e, FunctionAddress):
                a = self.store.function_list[e].type
                b = module.type_list[module.import_list[i].desc]
                assert match_function(a, b)
            if isinstance(e, TableAddress):
                a = self.store.table_list[e].limits
                b = module.import_list[i].desc.limits
                assert match_limits(a, b)
            if isinstance(e, MemoryAddress):
                a = self.store.memory_list[e].type
                b = module.import_list[i].desc
                assert match_memory(a, b)
            if isinstance(e, GlobalAddress):
                assert module.import_list[i].desc.type == self.store.global_list[e].value.type
                assert module.import_list[i].desc.mut == self.store.global_list[e].mut

        # Let vals be the vector of global initialization values determined by module and externvaln
        global_values: typing.List[Val] = []
        aux = ModuleInstance()
        aux.global_addr_list = [e for e in extern_value_list if isinstance(e, GlobalAddress)]
        for e in module.global_list:
            log.debugln(f'init global value')
            frame = Frame(aux, [], e.init, 1)
            config = Configuration(self.store)
            config.opts = self.opts
            config.set_frame(frame)
            r = config.exec().data[0]
            global_values.append(r)

        # Let moduleinst be a new module instance allocated from module in store S with imports externval and global
        # initializer values, and let S be the extended store produced by module allocation.
        self.allocate(module, extern_value_list, global_values)

        for element_segment in module.element_list:
            log.debugln('init elem')
            # Let F be the frame, push the frame F to the stack
            frame = Frame(self.module, [], element_segment.offset, 1)
            config = Configuration(self.store)
            config.opts = self.opts
            config.set_frame(frame)
            r = config.exec().data[0]
            offset = r.into_auto()
            table_addr = self.module.table_addr_list[element_segment.table]
            table_instance = self.store.table_list[table_addr]
            for i, e in enumerate(element_segment.init):
                table_instance.element_list[offset + i] = e

        for data_segment in module.data_list:
            log.debugln('init data')
            frame = Frame(self.module, [], data_segment.offset, 1)
            config = Configuration(self.store)
            config.opts = self.opts
            config.set_frame(frame)
            r = config.exec().data[0]
            offset = r.into_auto()
            memory_addr = self.module.memory_addr_list[data_segment.data]
            memory_instance = self.store.memory_list[memory_addr]
            memory_instance.data[offset: offset + len(data_segment.init)] = data_segment.init

        # [TODO] Assert: due to validation, the frame F is now on the top of the stack.

        # If the start function module.start is not empty, invoke the function instance
        if module.start is not None:
            log.debugln(f'running start function {module.start}')
            self.invocate(self.module.function_addr_list[module.start.func], [])

    def allocate(
        self,
        module: core.Module,
        extern_value_list: typing.List[ExternValue],
        global_values: typing.List[Val],
    ):
        # Let funcaddr be the list of function addresses extracted from externval, concatenated with funcaddr
        # Let tableaddr be the list of table addresses extracted from externval, concatenated with tableaddr
        # Let memaddr be the list of memory addresses extracted from externval, concatenated with memaddr
        # Let globaladdr be the list of global addresses extracted from externval, concatenated with globaladdr
        for e in extern_value_list:
            if isinstance(e, FunctionAddress):
                self.module.function_addr_list.append(e)
            if isinstance(e, TableAddress):
                self.module.table_addr_list.append(e)
            if isinstance(e, MemoryAddress):
                self.module.memory_addr_list.append(e)
            if isinstance(e, GlobalAddress):
                self.module.global_addr_list.append(e)

        # For each function func in module.funcs, do:
        for e in module.function_list:
            function_addr = self.store.allocate_wasm_function(self.module, e)
            self.module.function_addr_list.append(function_addr)

        # For each table in module.tables, do:
        for e in module.table_list:
            table_addr = self.store.allocate_table(e)
            self.module.table_addr_list.append(table_addr)

        # For each memory module.mems, do:
        for e in module.memory_list:
            memory_addr = self.store.allocate_memory(e.type)
            self.module.memory_addr_list.append(memory_addr)

        # For each global in module.globals, do:
        for i, e in enumerate(module.global_list):
            global_addr = self.store.allocate_global(e.type, global_values[i])
            self.module.global_addr_list.append(global_addr)

        # For each export in module.exports, do:
        for e in module.export_list:
            if e.type == 0x00:
                addr = self.module.function_addr_list[e.desc]
            if e.type == 0x01:
                addr = self.module.table_addr_list[e.desc]
            if e.type == 0x02:
                addr = self.module.memory_addr_list[e.desc]
            if e.type == 0x03:
                addr = self.module.global_addr_list[e.desc]
            export_inst = ExportInstance(e.name, addr)
            self.module.export_list.append(export_inst)

    def invocate(self, function_addr: FunctionAddress, function_args: typing.List[Val]) -> Result:
        config = Configuration(self.store)
        config.opts = self.opts
        return config.call(function_addr, function_args)
