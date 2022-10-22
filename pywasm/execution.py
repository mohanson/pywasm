import typing

import numpy

from . import binary
from . import convention
from . import instruction
from . import log
from . import num
from . import option

# ======================================================================================================================
# Execution Runtime Structure
# ======================================================================================================================


class Value:
    # Values are represented by themselves.
    def __init__(self):
        self.type: binary.ValueType
        self.data: bytearray = bytearray(8)

    def __repr__(self):
        return f'{self.type} {self.val()}'

    @classmethod
    def new(cls, type: binary.ValueType, data: typing.Union[int, float]):
        return {
            convention.i32: Value.from_i32,
            convention.i64: Value.from_i64,
            convention.f32: lambda x: Value.from_f32(num.f32(x)),
            convention.f64: lambda x: Value.from_f64(num.f64(x)),
        }[type](data)

    @classmethod
    def raw(cls, type: binary.ValueType, data: bytearray):
        o = Value()
        o.type = type
        o.data = data
        return o

    def val(self) -> typing.Union[num.i32, num.i64, num.f32, num.f64]:
        return {
            convention.i32: self.i32,
            convention.i64: self.i64,
            convention.f32: self.f32,
            convention.f64: self.f64,
        }[self.type]()

    def i32(self) -> num.i32:
        return num.LittleEndian.i32(self.data[0:4])

    def i64(self) -> num.i64:
        return num.LittleEndian.i64(self.data[0:8])

    def u32(self) -> num.u32:
        return num.LittleEndian.u32(self.data[0:4])

    def u64(self) -> num.u64:
        return num.LittleEndian.u64(self.data[0:8])

    def f32(self) -> num.f32:
        return num.LittleEndian.f32(self.data[0:4])

    def f64(self) -> num.f64:
        return num.LittleEndian.f64(self.data[0:8])

    @classmethod
    def from_i32(cls, n: num.i32):
        o = Value()
        o.type = binary.ValueType(convention.i32)
        o.data[0:4] = num.LittleEndian.pack_i32(num.int2i32(n))
        return o

    @classmethod
    def from_i64(cls, n: num.i64):
        o = Value()
        o.type = binary.ValueType(convention.i64)
        o.data[0:8] = num.LittleEndian.pack_i64(num.int2i64(n))
        return o

    @classmethod
    def from_u32(cls, n: num.u32):
        o = Value()
        o.type = binary.ValueType(convention.i32)
        o.data[0:4] = num.LittleEndian.pack_u32(num.int2u32(n))
        return o

    @classmethod
    def from_u64(cls, n: num.u64):
        o = Value()
        o.type = binary.ValueType(convention.i64)
        o.data[0:8] = num.LittleEndian.pack_u64(num.int2u64(n))
        return o

    @classmethod
    def from_f32(cls, n: num.f32):
        assert isinstance(n, num.f32)
        o = Value()
        o.type = binary.ValueType(convention.f32)
        o.data[0:4] = num.LittleEndian.pack_f32(n)
        return o

    @classmethod
    def from_f32_u32(cls, n: num.u32):
        o = Value.from_u32(n)
        o.type = binary.ValueType(convention.f32)
        return o

    @classmethod
    def from_f64(cls, n: num.f64):
        assert isinstance(n, num.f64)
        o = Value()
        o.type = binary.ValueType(convention.f64)
        o.data[0:8] = num.LittleEndian.pack_f64(n)
        return o

    @classmethod
    def from_f64_u64(cls, n: num.u64):
        o = Value.from_u64(n)
        o.type = binary.ValueType(convention.f64)
        return o


class Result:
    # A result is the outcome of a computation. It is either a sequence of values or a trap.
    def __init__(self, data: typing.List[Value]):
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
        self.type_list: typing.List[binary.FunctionType] = []
        self.function_addr_list: typing.List[FunctionAddress] = []
        self.table_addr_list: typing.List[TableAddress] = []
        self.memory_addr_list: typing.List[MemoryAddress] = []
        self.global_addr_list: typing.List[GlobalAddress] = []
        self.export_list: typing.List[ExportInstance] = []


class WasmFunc:
    def __init__(self, function_type: binary.FunctionType, module: ModuleInstance, code: binary.Function):
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
    def __init__(self, function_type: binary.FunctionType, hostcode: typing.Callable):
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
    def __init__(self, element_type: int, limits: binary.Limits):
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
    def __init__(self, type: binary.MemoryType):
        self.type = type
        self.data = bytearray()
        self.size = 0
        self.grow(type.limits.n)

    def grow(self, n: int):
        if self.type.limits.m and self.size + n > self.type.limits.m:
            raise Exception('pywasm: out of memory limit')
        # If len is larger than 2**16, then fail
        if self.size + n > convention.memory_page:
            raise Exception('pywasm: out of memory limit')
        self.data.extend([0x00 for _ in range(n * convention.memory_page_size)])
        self.size += n


class GlobalInstance:
    # A global instance is the runtime representation of a global variable. It holds an individual value and a flag
    # indicating whether it is mutable.
    #
    # globalinst ::= {value val, mut mut}
    #
    # The value of mutable globals can be mutated through variable instructions or by external means provided by the
    # embedder.
    def __init__(self, value: Value, mut: binary.Mut):
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

    def allocate_wasm_function(self, module: ModuleInstance, function: binary.Function) -> FunctionAddress:
        function_address = FunctionAddress(len(self.function_list))
        function_type = module.type_list[function.type_index]
        wasmfunc = WasmFunc(function_type, module, function)
        self.function_list.append(wasmfunc)
        return function_address

    def allocate_host_function(self, hostfunc: HostFunc) -> FunctionAddress:
        function_address = FunctionAddress(len(self.function_list))
        self.function_list.append(hostfunc)
        return function_address

    def allocate_table(self, table_type: binary.TableType) -> TableAddress:
        table_address = TableAddress(len(self.table_list))
        table_instance = TableInstance(convention.funcref, table_type.limits)
        self.table_list.append(table_instance)
        return table_address

    def allocate_memory(self, memory_type: binary.MemoryType) -> MemoryAddress:
        memory_address = MemoryAddress(len(self.memory_list))
        memory_instance = MemoryInstance(memory_type)
        self.memory_list.append(memory_instance)
        return memory_address

    def allocate_global(self, global_type: binary.GlobalType, value: Value) -> GlobalAddress:
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
                 local_list: typing.List[Value],
                 expr: binary.Expression,
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
        self.data: typing.List[typing.Union[Value, Label, Frame]] = []

    def len(self):
        return len(self.data)

    def append(self, v: typing.Union[Value, Label, Frame]):
        self.data.append(v)

    def pop(self):
        return self.data.pop()


# ======================================================================================================================
# Execution Runtime Import Matching
# ======================================================================================================================


def match_limits(a: binary.Limits, b: binary.Limits) -> bool:
    if a.n >= b.n:
        if b.m == 0:
            return 1
        if a.m != 0 and b.m != 0:
            if a.m < b.m:
                return 1
    return 0


def match_function(a: binary.FunctionType, b: binary.FunctionType) -> bool:
    return a.args.data == b.args.data and a.rets.data == b.rets.data


def match_memory(a: binary.MemoryType, b: binary.MemoryType) -> bool:
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

    def call(self, function_addr: FunctionAddress, function_args: typing.List[Value]) -> Result:
        function = self.store.function_list[function_addr]
        log.debugln(f'call {function}({function_args})')
        for e, t in zip(function_args, function.type.args.data):
            assert e.type == t
        assert len(function.type.rets.data) < 2

        if isinstance(function, WasmFunc):
            local_list = [Value.new(e, 0) for e in function.code.local_list]
            frame = Frame(
                module=function.module,
                local_list=function_args + local_list,
                expr=function.code.expr,
                arity=len(function.type.rets.data),
            )
            self.set_frame(frame)
            return self.exec()
        if isinstance(function, HostFunc):
            r = function.hostcode(self.store, *[e.val() for e in function_args])
            l = len(function.type.rets.data)
            if l == 0:
                return Result([])
            if l == 1:
                return Result([Value.new(function.type.rets.data[0], r)])
            return [Value.new(e, r[i]) for i, e in enumerate(function.type.rets.data)]
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
    def exec(config: Configuration, i: binary.Instruction):
        if log.lvl > 0:
            log.println('|', i)
        func = _INSTRUCTION_TABLE[i.opcode]
        func(config, i)

    @staticmethod
    def unreachable(config: Configuration, i: binary.Instruction):
        raise Exception('pywasm: unreachable')

    @staticmethod
    def nop(config: Configuration, i: binary.Instruction):
        pass

    @staticmethod
    def block(config: Configuration, i: binary.Instruction):
        if i.args[0] == convention.empty:
            arity = 0
        else:
            arity = 1
        continuation = config.frame.expr.position[config.pc][1]
        config.stack.append(Label(arity, continuation))

    @staticmethod
    def loop(config: Configuration, i: binary.Instruction):
        if i.args[0] == convention.empty:
            arity = 0
        else:
            arity = 1
        continuation = config.frame.expr.position[config.pc][0]
        config.stack.append(Label(arity, continuation))

    @staticmethod
    def if_(config: Configuration, i: binary.Instruction):
        c = config.stack.pop().i32()
        if i.args[0] == convention.empty:
            arity = 0
        else:
            arity = 1
        continuation = config.frame.expr.position[config.pc][1]
        config.stack.append(Label(arity, continuation))
        if c == 0:
            if len(config.frame.expr.position[config.pc]) == 3:
                config.pc = config.frame.expr.position[config.pc][2]
            else:
                config.pc = config.frame.expr.position[config.pc][1]
                config.stack.pop()

    @staticmethod
    def else_(config: Configuration, i: binary.Instruction):
        L = config.get_label(0)
        v = [config.stack.pop() for _ in range(L.arity)][::-1]
        while True:
            if isinstance(config.stack.pop(), Label):
                break
        for e in v:
            config.stack.append(e)
        config.pc = config.frame.expr.position[config.pc][1]

    @staticmethod
    def end(config: Configuration, i: binary.Instruction):
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
    def br(config: Configuration, i: binary.Instruction):
        l = i.args[0]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def br_if(config: Configuration, i: binary.Instruction):
        if config.stack.pop().i32() == 0:
            return
        l = i.args[0]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def br_table(config: Configuration, i: binary.Instruction):
        a = i.args[0]
        l = i.args[1]
        c = config.stack.pop().i32()
        if c >= 0 and c < len(a):
            l = a[c]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def return_(config: Configuration, i: binary.Instruction):
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
        if config.depth > convention.call_stack_depth:
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
    def call(config: Configuration, i: binary.Instruction):
        function_addr: binary.FunctionIndex = i.args[0]
        ArithmeticLogicUnit.call_function_addr(config, function_addr)

    @staticmethod
    def call_indirect(config: Configuration, i: binary.Instruction):
        if i.args[1] != 0x00:
            raise Exception("pywasm: zero byte malformed in call_indirect")
        ta = config.frame.module.table_addr_list[0]
        tab = config.store.table_list[ta]
        idx = config.stack.pop().i32()
        if not 0 <= idx < len(tab.element_list):
            raise Exception('pywasm: undefined element')
        function_addr = tab.element_list[idx]
        if function_addr is None:
            raise Exception('pywasm: uninitialized element')
        ArithmeticLogicUnit.call_function_addr(config, function_addr)

    @staticmethod
    def drop(config: Configuration, i: binary.Instruction):
        config.stack.pop()

    @staticmethod
    def select(config: Configuration, i: binary.Instruction):
        c = config.stack.pop().i32()
        b = config.stack.pop()
        a = config.stack.pop()
        if c:
            config.stack.append(a)
        else:
            config.stack.append(b)

    @staticmethod
    def get_local(config: Configuration, i: binary.Instruction):
        r = config.frame.local_list[i.args[0]]
        o = Value()
        o.type = r.type
        o.data = r.data.copy()
        config.stack.append(o)

    @staticmethod
    def set_local(config: Configuration, i: binary.Instruction):
        r = config.stack.pop()
        config.frame.local_list[i.args[0]] = r

    @staticmethod
    def tee_local(config: Configuration, i: binary.Instruction):
        r = config.stack.data[-1]
        o = Value()
        o.type = r.type
        o.data = r.data.copy()
        config.frame.local_list[i.args[0]] = o

    @staticmethod
    def get_global(config: Configuration, i: binary.Instruction):
        a = config.frame.module.global_addr_list[i.args[0]]
        glob = config.store.global_list[a]
        r = glob.value
        config.stack.append(r)

    @staticmethod
    def set_global(config: Configuration, i: binary.Instruction):
        a = config.frame.module.global_addr_list[i.args[0]]
        glob = config.store.global_list[a]
        assert glob.mut == convention.var
        glob.value = config.stack.pop()

    @staticmethod
    def mem_load(config: Configuration, i: binary.Instruction, size: int) -> bytearray:
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        offset = i.args[1]
        addr = config.stack.pop().i32() + offset
        if addr < 0 or addr + size > len(memory.data):
            raise Exception('pywasm: out of bounds memory access')
        return memory.data[addr:addr + size]

    @staticmethod
    def i32_load(config: Configuration, i: binary.Instruction):
        r = Value.from_i32(num.LittleEndian.i32(ArithmeticLogicUnit.mem_load(config, i, 4)))
        config.stack.append(r)

    @staticmethod
    def i64_load(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(num.LittleEndian.i64(ArithmeticLogicUnit.mem_load(config, i, 8)))
        config.stack.append(r)

    @staticmethod
    def f32_load(config: Configuration, i: binary.Instruction):
        r = Value.from_f32(num.LittleEndian.f32(ArithmeticLogicUnit.mem_load(config, i, 4)))
        config.stack.append(r)

    @staticmethod
    def f64_load(config: Configuration, i: binary.Instruction):
        r = Value.from_f64(num.LittleEndian.f64(ArithmeticLogicUnit.mem_load(config, i, 8)))
        config.stack.append(r)

    @staticmethod
    def i32_load8_s(config: Configuration, i: binary.Instruction):
        r = Value.from_i32(num.LittleEndian.i8(ArithmeticLogicUnit.mem_load(config, i, 1)))
        config.stack.append(r)

    @staticmethod
    def i32_load8_u(config: Configuration, i: binary.Instruction):
        r = Value.from_i32(ArithmeticLogicUnit.mem_load(config, i, 1)[0])
        config.stack.append(r)

    @staticmethod
    def i32_load16_s(config: Configuration, i: binary.Instruction):
        r = Value.from_i32(num.LittleEndian.i16(ArithmeticLogicUnit.mem_load(config, i, 2)))
        config.stack.append(r)

    @staticmethod
    def i32_load16_u(config: Configuration, i: binary.Instruction):
        r = Value.from_i32(num.LittleEndian.u16(ArithmeticLogicUnit.mem_load(config, i, 2)))
        config.stack.append(r)

    @staticmethod
    def i64_load8_s(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(num.LittleEndian.i8(ArithmeticLogicUnit.mem_load(config, i, 1)))
        config.stack.append(r)

    @staticmethod
    def i64_load8_u(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(ArithmeticLogicUnit.mem_load(config, i, 1)[0])
        config.stack.append(r)

    @staticmethod
    def i64_load16_s(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(num.LittleEndian.i16(ArithmeticLogicUnit.mem_load(config, i, 2)))
        config.stack.append(r)

    @staticmethod
    def i64_load16_u(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(num.LittleEndian.u16(ArithmeticLogicUnit.mem_load(config, i, 2)))
        config.stack.append(r)

    @staticmethod
    def i64_load32_s(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(num.LittleEndian.i32(ArithmeticLogicUnit.mem_load(config, i, 4)))
        config.stack.append(r)

    @staticmethod
    def i64_load32_u(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(num.LittleEndian.u32(ArithmeticLogicUnit.mem_load(config, i, 4)))
        config.stack.append(r)

    @staticmethod
    def mem_store(config: Configuration, i: binary.Instruction, size: int):
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        r = config.stack.pop()
        offset = i.args[1]
        addr = config.stack.pop().i32() + offset
        if addr < 0 or addr + size > len(memory.data):
            raise Exception('pywasm: out of bounds memory access')
        memory.data[addr:addr + size] = r.data[0:size]

    @staticmethod
    def i32_store(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def i64_store(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 8)

    @staticmethod
    def f32_store(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def f64_store(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 8)

    @staticmethod
    def i32_store8(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 1)

    @staticmethod
    def i32_store16(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 2)

    @staticmethod
    def i64_store8(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def i64_store16(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 2)

    @staticmethod
    def i64_store32(config: Configuration, i: binary.Instruction):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def current_memory(config: Configuration, i: binary.Instruction):
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        r = Value.from_i32(memory.size)
        config.stack.append(r)

    @staticmethod
    def grow_memory(config: Configuration, i: binary.Instruction):
        memory_addr = config.frame.module.memory_addr_list[0]
        memory = config.store.memory_list[memory_addr]
        size = memory.size
        r = config.stack.pop().i32()
        if config.opts.pages_limit > 0 and memory.size + r > config.opts.pages_limit:
            raise Exception('pywasm: out of memory limit')
        try:
            memory.grow(r)
            config.stack.append(Value.from_i32(size))
        except Exception:
            config.stack.append(Value.from_i32(-1))

    @staticmethod
    def i32_const(config: Configuration, i: binary.Instruction):
        config.stack.append(Value.from_i32(i.args[0]))

    @staticmethod
    def i64_const(config: Configuration, i: binary.Instruction):
        config.stack.append(Value.from_i64(i.args[0]))

    @staticmethod
    def f32_const(config: Configuration, i: binary.Instruction):
        r = Value.from_i32(i.args[0])
        r.type = binary.ValueType(convention.f32)
        config.stack.append(r)

    @staticmethod
    def f64_const(config: Configuration, i: binary.Instruction):
        r = Value.from_i64(i.args[0])
        r.type = binary.ValueType(convention.f64)
        config.stack.append(r)

    @staticmethod
    def i32_eqz(config: Configuration, i: binary.Instruction):
        config.stack.append(Value.from_i32(config.stack.pop().i32() == 0))

    @staticmethod
    def i32_eq(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        config.stack.append(Value.from_i32(a == b))

    @staticmethod
    def i32_ne(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        config.stack.append(Value.from_i32(a != b))

    @staticmethod
    def i32_lts(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        config.stack.append(Value.from_i32(a < b))

    @staticmethod
    def i32_ltu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u32()
        a = config.stack.pop().u32()
        config.stack.append(Value.from_i32(a < b))

    @staticmethod
    def i32_gts(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        config.stack.append(Value.from_i32(a > b))

    @staticmethod
    def i32_gtu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u32()
        a = config.stack.pop().u32()
        config.stack.append(Value.from_i32(a > b))

    @staticmethod
    def i32_les(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        config.stack.append(Value.from_i32(a <= b))

    @staticmethod
    def i32_leu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u32()
        a = config.stack.pop().u32()
        config.stack.append(Value.from_i32(a <= b))

    @staticmethod
    def i32_ges(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        config.stack.append(Value.from_i32(int(a >= b)))

    @staticmethod
    def i32_geu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u32()
        a = config.stack.pop().u32()
        config.stack.append(Value.from_i32(int(a >= b)))

    @staticmethod
    def i64_eqz(config: Configuration, i: binary.Instruction):
        config.stack.append(Value.from_i32(config.stack.pop().i64() == 0))

    @staticmethod
    def i64_eq(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        config.stack.append(Value.from_i32(a == b))

    @staticmethod
    def i64_ne(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        config.stack.append(Value.from_i32(a != b))

    @staticmethod
    def i64_lts(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        config.stack.append(Value.from_i32(a < b))

    @staticmethod
    def i64_ltu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u64()
        a = config.stack.pop().u64()
        config.stack.append(Value.from_i32(a < b))

    @staticmethod
    def i64_gts(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        config.stack.append(Value.from_i32(a > b))

    @staticmethod
    def i64_gtu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u64()
        a = config.stack.pop().u64()
        config.stack.append(Value.from_i32(a > b))

    @staticmethod
    def i64_les(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        config.stack.append(Value.from_i32(a <= b))

    @staticmethod
    def i64_leu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u64()
        a = config.stack.pop().u64()
        config.stack.append(Value.from_i32(a <= b))

    @staticmethod
    def i64_ges(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        config.stack.append(Value.from_i32(a >= b))

    @staticmethod
    def i64_geu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u64()
        a = config.stack.pop().u64()
        config.stack.append(Value.from_i32(a >= b))

    @staticmethod
    def f32_eq(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        config.stack.append(Value.from_i32(a == b))

    @staticmethod
    def f32_ne(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        config.stack.append(Value.from_i32(a != b))

    @staticmethod
    def f32_lt(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        config.stack.append(Value.from_i32(a < b))

    @staticmethod
    def f32_gt(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        config.stack.append(Value.from_i32(a > b))

    @staticmethod
    def f32_le(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        config.stack.append(Value.from_i32(a <= b))

    @staticmethod
    def f32_ge(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        config.stack.append(Value.from_i32(a >= b))

    @staticmethod
    def f64_eq(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        config.stack.append(Value.from_i32(a == b))

    @staticmethod
    def f64_ne(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        config.stack.append(Value.from_i32(a != b))

    @staticmethod
    def f64_lt(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        config.stack.append(Value.from_i32(a < b))

    @staticmethod
    def f64_gt(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        config.stack.append(Value.from_i32(a > b))

    @staticmethod
    def f64_le(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        config.stack.append(Value.from_i32(a <= b))

    @staticmethod
    def f64_ge(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        config.stack.append(Value.from_i32(a >= b))

    @staticmethod
    def i32_clz(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i32()
        c = 0
        while c < 32 and (a & 0x80000000) == 0:
            c += 1
            a = a << 1
        config.stack.append(Value.from_i32(c))

    @staticmethod
    def i32_ctz(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i32()
        c = 0
        while c < 32 and (a & 0x01) == 0:
            c += 1
            a = a >> 1
        config.stack.append(Value.from_i32(c))

    @staticmethod
    def i32_popcnt(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i32()
        c = 0
        for _ in range(32):
            if a & 0x01:
                c += 1
            a = a >> 1
        config.stack.append(Value.from_i32(c))

    @staticmethod
    def i32_add(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a + b)
        config.stack.append(c)

    @staticmethod
    def i32_sub(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a - b)
        config.stack.append(c)

    @staticmethod
    def i32_mul(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a * b)
        config.stack.append(c)

    @staticmethod
    def i32_divs(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        if b == -1 and a == -2**31:
            raise Exception('pywasm: integer overflow')
        # Integer division that rounds towards 0 (like C)
        r = Value.from_i32(a // b if a * b > 0 else (a + (-a % b)) // b)
        config.stack.append(r)

    @staticmethod
    def i32_divu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u32()
        a = config.stack.pop().u32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Value.from_i32(a // b)
        config.stack.append(r)

    @staticmethod
    def i32_rems(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        # Integer remainder that rounds towards 0 (like C)
        r = Value.from_i32(a % b if a * b > 0 else -(-a % b))
        config.stack.append(r)

    @staticmethod
    def i32_remu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u32()
        a = config.stack.pop().u32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Value.from_i32(a % b)
        config.stack.append(r)

    @staticmethod
    def i32_and(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a & b)
        config.stack.append(c)

    @staticmethod
    def i32_or(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a | b)
        config.stack.append(c)

    @staticmethod
    def i32_xor(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a ^ b)
        config.stack.append(c)

    @staticmethod
    def i32_shl(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a << (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_shrs(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().i32()
        c = Value.from_i32(a >> (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_shru(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u32()
        a = config.stack.pop().u32()
        c = Value.from_i32(a >> (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_rotl(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().u32()
        c = Value.from_i32((((a << (b % 0x20)) & 0xffffffff) | (a >> (0x20 - (b % 0x20)))))
        config.stack.append(c)

    @staticmethod
    def i32_rotr(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i32()
        a = config.stack.pop().u32()
        c = Value.from_i32(((a >> (b % 0x20)) | ((a << (0x20 - (b % 0x20))) & 0xffffffff)))
        config.stack.append(c)

    @staticmethod
    def i64_clz(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i64()
        c = 0
        while c < 64 and (a & 0x8000000000000000) == 0:
            c += 1
            a = a << 1
        config.stack.append(Value.from_i64(c))

    @staticmethod
    def i64_ctz(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i64()
        c = 0
        while c < 64 and (a & 0x01) == 0:
            c += 1
            a = a >> 1
        config.stack.append(Value.from_i64(c))

    @staticmethod
    def i64_popcnt(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i64()
        c = 0
        for _ in range(64):
            if a & 0x01:
                c += 1
            a = a >> 1
        config.stack.append(Value.from_i64(c))

    @staticmethod
    def i64_add(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a + b)
        config.stack.append(c)

    @staticmethod
    def i64_sub(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a - b)
        config.stack.append(c)

    @staticmethod
    def i64_mul(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a * b)
        config.stack.append(c)

    @staticmethod
    def i64_divs(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        if b == -1 and a == -2**63:
            raise Exception('pywasm: integer overflow')
        r = Value.from_i64(a // b if a * b > 0 else (a + (-a % b)) // b)
        config.stack.append(r)

    @staticmethod
    def i64_divu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u64()
        a = config.stack.pop().u64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Value.from_i64(a // b)
        config.stack.append(r)

    @staticmethod
    def i64_rems(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        # Integer remainder that rounds towards 0 (like C)
        r = Value.from_i64(a % b if a * b > 0 else -(-a % b))
        config.stack.append(r)

    @staticmethod
    def i64_remu(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u64()
        a = config.stack.pop().u64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = Value.from_i64(a % b)
        config.stack.append(r)

    @staticmethod
    def i64_and(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a & b)
        config.stack.append(c)

    @staticmethod
    def i64_or(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a | b)
        config.stack.append(c)

    @staticmethod
    def i64_xor(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a & b)
        config.stack.append(c)

    @staticmethod
    def i64_shl(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a << (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_shrs(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().i64()
        c = Value.from_i64(a >> (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_shru(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().u64()
        a = config.stack.pop().u64()
        c = Value.from_i64(a >> (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_rotl(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().u64()
        c = Value.from_i64((((a << (b % 0x40)) & 0xffffffffffffffff) | (a >> (0x40 - (b % 0x40)))))
        config.stack.append(c)

    @staticmethod
    def i64_rotr(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().i64()
        a = config.stack.pop().u64()
        c = Value.from_i64(((a >> (b % 0x40)) | ((a << (0x40 - (b % 0x40))) & 0xffffffffffffffff)))
        config.stack.append(c)

    @staticmethod
    def f32_abs(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        a.data[3] = a.data[3] & 0x7f
        config.stack.append(a)

    @staticmethod
    def f32_neg(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        if a.data[3] & 0x80 != 0x00:
            a.data[3] = a.data[3] & 0x7f
        else:
            a.data[3] = a.data[3] | 0x80
        config.stack.append(a)

    @staticmethod
    def f32_ceil(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        r = Value.from_f32(numpy.ceil(a))
        config.stack.append(r)

    @staticmethod
    def f32_floor(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        r = Value.from_f32(numpy.floor(a))
        config.stack.append(r)

    @staticmethod
    def f32_trunc(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        r = Value.from_f32(numpy.trunc(a))
        config.stack.append(r)

    @staticmethod
    def f32_nearest(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        r = Value.from_f32(numpy.round(a))
        config.stack.append(r)

    @staticmethod
    def f32_sqrt(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        r = Value.from_f32(numpy.sqrt(a))
        config.stack.append(r)

    @staticmethod
    def f32_add(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        r = Value.from_f32(a + b)
        config.stack.append(r)

    @staticmethod
    def f32_sub(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        r = Value.from_f32(a - b)
        config.stack.append(r)

    @staticmethod
    def f32_mul(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        r = Value.from_f32(a * b)
        config.stack.append(r)

    @staticmethod
    def f32_div(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        r = Value.from_f32(a / b)
        config.stack.append(r)

    @staticmethod
    def f32_min(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        if a == b == 0 and (numpy.signbit(a) or numpy.signbit(b)):
            return config.stack.append(Value.from_f32_u32(convention.f32_negative_zero))
        config.stack.append(Value.from_f32(numpy.min([a, b])))

    @staticmethod
    def f32_max(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        if a == b == 0 and not (numpy.signbit(a) and numpy.signbit(b)):
            return config.stack.append(Value.from_f32_u32(convention.f32_positive_zero))
        config.stack.append(Value.from_f32(numpy.max([a, b])))

    @staticmethod
    def f32_copysign(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f32()
        a = config.stack.pop().f32()
        r = Value.from_f32(numpy.copysign(a, b))
        config.stack.append(r)

    @staticmethod
    def f64_abs(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        a.data[7] = a.data[7] & 0x7f
        config.stack.append(a)

    @staticmethod
    def f64_neg(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        if a.data[7] & 0x80 != 0x00:
            a.data[7] = a.data[7] & 0x7f
        else:
            a.data[7] = a.data[7] | 0x80
        config.stack.append(a)

    @staticmethod
    def f64_ceil(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        r = Value.from_f64(numpy.ceil(a))
        config.stack.append(r)

    @staticmethod
    def f64_floor(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        r = Value.from_f64(numpy.floor(a))
        config.stack.append(r)

    @staticmethod
    def f64_trunc(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        r = Value.from_f64(numpy.trunc(a))
        config.stack.append(r)

    @staticmethod
    def f64_nearest(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        r = Value.from_f64(numpy.round(a))
        config.stack.append(r)

    @staticmethod
    def f64_sqrt(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        r = Value.from_f64(numpy.sqrt(a))
        config.stack.append(r)

    @staticmethod
    def f64_add(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        r = Value.from_f64(a + b)
        config.stack.append(r)

    @staticmethod
    def f64_sub(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        r = Value.from_f64(a - b)
        config.stack.append(r)

    @staticmethod
    def f64_mul(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        r = Value.from_f64(a * b)
        config.stack.append(r)

    @staticmethod
    def f64_div(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        r = Value.from_f64(a / b)
        config.stack.append(r)

    @staticmethod
    def f64_min(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        if a == b == 0 and (numpy.signbit(a) or numpy.signbit(b)):
            return config.stack.append(Value.from_f64_u64(convention.f64_negative_zero))
        config.stack.append(Value.from_f64(numpy.min([a, b])))

    @staticmethod
    def f64_max(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        if a == b == 0 and not (numpy.signbit(a) and numpy.signbit(b)):
            return config.stack.append(Value.from_f64_u64(convention.f64_positive_zero))
        config.stack.append(Value.from_f64(numpy.max([a, b])))

    @staticmethod
    def f64_copysign(config: Configuration, i: binary.Instruction):
        b = config.stack.pop().f64()
        a = config.stack.pop().f64()
        r = Value.from_f64(numpy.copysign(a, b))
        config.stack.append(r)

    @staticmethod
    def i32_wrap_i64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i64()
        config.stack.append(Value.from_i32(a))

    @staticmethod
    def i32_trunc_sf32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        if a > (1 << 31) - 1 or a < -(1 << 31):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_uf32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        if a > (1 << 32) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_sf64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        if a > (1 << 31) - 1 or a < -(1 << 31):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_uf64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        if a > (1 << 32) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i64_extend_si32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i32()
        r = Value.from_i64(a)
        config.stack.append(r)

    @staticmethod
    def i64_extend_ui32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().u32()
        r = Value.from_i64(a)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_sf32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        if a > (1 << 63) - 1 or a < -(1 << 63):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_uf32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        if a > (1 << 64) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_sf64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        if a > (1 << 63) - 1 or a < -(1 << 63):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_uf64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        if a > (1 << 64) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = Value.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def f32_convert_si32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i32()
        r = Value.from_f32(num.f32(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_ui32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().u32()
        r = Value.from_f32(num.f32(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_si64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i64()
        r = Value.from_f32(num.f32(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_ui64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().u64()
        r = Value.from_f32(num.f32(a))
        config.stack.append(r)

    @staticmethod
    def f32_demote_f64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f64()
        r = Value.from_f32(num.f32(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_si32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i32()
        r = Value.from_f64(num.f64(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_ui32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().u32()
        r = Value.from_f64(num.f64(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_si64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().i64()
        r = Value.from_f64(num.f64(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_ui64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().u64()
        r = Value.from_f64(num.f64(a))
        config.stack.append(r)

    @staticmethod
    def f64_promote_f32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop().f32()
        r = Value.from_f64(num.f64(a))
        config.stack.append(r)

    @staticmethod
    def i32_reinterpret_f32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        a.type = binary.ValueType(convention.i32)
        config.stack.append(a)

    @staticmethod
    def i64_reinterpret_f64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        a.type = binary.ValueType(convention.i64)
        config.stack.append(a)

    @staticmethod
    def f32_reinterpret_i32(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        a.type = binary.ValueType(convention.f32)
        config.stack.append(a)

    @staticmethod
    def f64_reinterpret_i64(config: Configuration, i: binary.Instruction):
        a = config.stack.pop()
        a.type = binary.ValueType(convention.f64)
        config.stack.append(a)


def _make_instruction_table():
    table = [None for i in range(max(instruction.opcode) + 1)]

    table[instruction.unreachable] = ArithmeticLogicUnit.unreachable
    table[instruction.nop] = ArithmeticLogicUnit.nop
    table[instruction.block] = ArithmeticLogicUnit.block
    table[instruction.loop] = ArithmeticLogicUnit.loop
    table[instruction.if_] = ArithmeticLogicUnit.if_
    table[instruction.else_] = ArithmeticLogicUnit.else_
    table[instruction.end] = ArithmeticLogicUnit.end
    table[instruction.br] = ArithmeticLogicUnit.br
    table[instruction.br_if] = ArithmeticLogicUnit.br_if
    table[instruction.br_table] = ArithmeticLogicUnit.br_table
    table[instruction.return_] = ArithmeticLogicUnit.return_
    table[instruction.call] = ArithmeticLogicUnit.call
    table[instruction.call_indirect] = ArithmeticLogicUnit.call_indirect
    table[instruction.drop] = ArithmeticLogicUnit.drop
    table[instruction.select] = ArithmeticLogicUnit.select
    table[instruction.get_local] = ArithmeticLogicUnit.get_local
    table[instruction.set_local] = ArithmeticLogicUnit.set_local
    table[instruction.tee_local] = ArithmeticLogicUnit.tee_local
    table[instruction.get_global] = ArithmeticLogicUnit.get_global
    table[instruction.set_global] = ArithmeticLogicUnit.set_global
    table[instruction.i32_load] = ArithmeticLogicUnit.i32_load
    table[instruction.i64_load] = ArithmeticLogicUnit.i64_load
    table[instruction.f32_load] = ArithmeticLogicUnit.f32_load
    table[instruction.f64_load] = ArithmeticLogicUnit.f64_load
    table[instruction.i32_load8_s] = ArithmeticLogicUnit.i32_load8_s
    table[instruction.i32_load8_u] = ArithmeticLogicUnit.i32_load8_u
    table[instruction.i32_load16_s] = ArithmeticLogicUnit.i32_load16_s
    table[instruction.i32_load16_u] = ArithmeticLogicUnit.i32_load16_u
    table[instruction.i64_load8_s] = ArithmeticLogicUnit.i64_load8_s
    table[instruction.i64_load8_u] = ArithmeticLogicUnit.i64_load8_u
    table[instruction.i64_load16_s] = ArithmeticLogicUnit.i64_load16_s
    table[instruction.i64_load16_u] = ArithmeticLogicUnit.i64_load16_u
    table[instruction.i64_load32_s] = ArithmeticLogicUnit.i64_load32_s
    table[instruction.i64_load32_u] = ArithmeticLogicUnit.i64_load32_u
    table[instruction.i32_store] = ArithmeticLogicUnit.i32_store
    table[instruction.i64_store] = ArithmeticLogicUnit.i64_store
    table[instruction.f32_store] = ArithmeticLogicUnit.f32_store
    table[instruction.f64_store] = ArithmeticLogicUnit.f64_store
    table[instruction.i32_store8] = ArithmeticLogicUnit.i32_store8
    table[instruction.i32_store16] = ArithmeticLogicUnit.i32_store16
    table[instruction.i64_store8] = ArithmeticLogicUnit.i64_store8
    table[instruction.i64_store16] = ArithmeticLogicUnit.i64_store16
    table[instruction.i64_store32] = ArithmeticLogicUnit.i64_store32
    table[instruction.current_memory] = ArithmeticLogicUnit.current_memory
    table[instruction.grow_memory] = ArithmeticLogicUnit.grow_memory
    table[instruction.i32_const] = ArithmeticLogicUnit.i32_const
    table[instruction.i64_const] = ArithmeticLogicUnit.i64_const
    table[instruction.f32_const] = ArithmeticLogicUnit.f32_const
    table[instruction.f64_const] = ArithmeticLogicUnit.f64_const
    table[instruction.i32_eqz] = ArithmeticLogicUnit.i32_eqz
    table[instruction.i32_eq] = ArithmeticLogicUnit.i32_eq
    table[instruction.i32_ne] = ArithmeticLogicUnit.i32_ne
    table[instruction.i32_lts] = ArithmeticLogicUnit.i32_lts
    table[instruction.i32_ltu] = ArithmeticLogicUnit.i32_ltu
    table[instruction.i32_gts] = ArithmeticLogicUnit.i32_gts
    table[instruction.i32_gtu] = ArithmeticLogicUnit.i32_gtu
    table[instruction.i32_les] = ArithmeticLogicUnit.i32_les
    table[instruction.i32_leu] = ArithmeticLogicUnit.i32_leu
    table[instruction.i32_ges] = ArithmeticLogicUnit.i32_ges
    table[instruction.i32_geu] = ArithmeticLogicUnit.i32_geu
    table[instruction.i64_eqz] = ArithmeticLogicUnit.i64_eqz
    table[instruction.i64_eq] = ArithmeticLogicUnit.i64_eq
    table[instruction.i64_ne] = ArithmeticLogicUnit.i64_ne
    table[instruction.i64_lts] = ArithmeticLogicUnit.i64_lts
    table[instruction.i64_ltu] = ArithmeticLogicUnit.i64_ltu
    table[instruction.i64_gts] = ArithmeticLogicUnit.i64_gts
    table[instruction.i64_gtu] = ArithmeticLogicUnit.i64_gtu
    table[instruction.i64_les] = ArithmeticLogicUnit.i64_les
    table[instruction.i64_leu] = ArithmeticLogicUnit.i64_leu
    table[instruction.i64_ges] = ArithmeticLogicUnit.i64_ges
    table[instruction.i64_geu] = ArithmeticLogicUnit.i64_geu
    table[instruction.f32_eq] = ArithmeticLogicUnit.f32_eq
    table[instruction.f32_ne] = ArithmeticLogicUnit.f32_ne
    table[instruction.f32_lt] = ArithmeticLogicUnit.f32_lt
    table[instruction.f32_gt] = ArithmeticLogicUnit.f32_gt
    table[instruction.f32_le] = ArithmeticLogicUnit.f32_le
    table[instruction.f32_ge] = ArithmeticLogicUnit.f32_ge
    table[instruction.f64_eq] = ArithmeticLogicUnit.f64_eq
    table[instruction.f64_ne] = ArithmeticLogicUnit.f64_ne
    table[instruction.f64_lt] = ArithmeticLogicUnit.f64_lt
    table[instruction.f64_gt] = ArithmeticLogicUnit.f64_gt
    table[instruction.f64_le] = ArithmeticLogicUnit.f64_le
    table[instruction.f64_ge] = ArithmeticLogicUnit.f64_ge
    table[instruction.i32_clz] = ArithmeticLogicUnit.i32_clz
    table[instruction.i32_ctz] = ArithmeticLogicUnit.i32_ctz
    table[instruction.i32_popcnt] = ArithmeticLogicUnit.i32_popcnt
    table[instruction.i32_add] = ArithmeticLogicUnit.i32_add
    table[instruction.i32_sub] = ArithmeticLogicUnit.i32_sub
    table[instruction.i32_mul] = ArithmeticLogicUnit.i32_mul
    table[instruction.i32_divs] = ArithmeticLogicUnit.i32_divs
    table[instruction.i32_divu] = ArithmeticLogicUnit.i32_divu
    table[instruction.i32_rems] = ArithmeticLogicUnit.i32_rems
    table[instruction.i32_remu] = ArithmeticLogicUnit.i32_remu
    table[instruction.i32_and] = ArithmeticLogicUnit.i32_and
    table[instruction.i32_or] = ArithmeticLogicUnit.i32_or
    table[instruction.i32_xor] = ArithmeticLogicUnit.i32_xor
    table[instruction.i32_shl] = ArithmeticLogicUnit.i32_shl
    table[instruction.i32_shrs] = ArithmeticLogicUnit.i32_shrs
    table[instruction.i32_shru] = ArithmeticLogicUnit.i32_shru
    table[instruction.i32_rotl] = ArithmeticLogicUnit.i32_rotl
    table[instruction.i32_rotr] = ArithmeticLogicUnit.i32_rotr
    table[instruction.i64_clz] = ArithmeticLogicUnit.i64_clz
    table[instruction.i64_ctz] = ArithmeticLogicUnit.i64_ctz
    table[instruction.i64_popcnt] = ArithmeticLogicUnit.i64_popcnt
    table[instruction.i64_add] = ArithmeticLogicUnit.i64_add
    table[instruction.i64_sub] = ArithmeticLogicUnit.i64_sub
    table[instruction.i64_mul] = ArithmeticLogicUnit.i64_mul
    table[instruction.i64_divs] = ArithmeticLogicUnit.i64_divs
    table[instruction.i64_divu] = ArithmeticLogicUnit.i64_divu
    table[instruction.i64_rems] = ArithmeticLogicUnit.i64_rems
    table[instruction.i64_remu] = ArithmeticLogicUnit.i64_remu
    table[instruction.i64_and] = ArithmeticLogicUnit.i64_and
    table[instruction.i64_or] = ArithmeticLogicUnit.i64_or
    table[instruction.i64_xor] = ArithmeticLogicUnit.i64_xor
    table[instruction.i64_shl] = ArithmeticLogicUnit.i64_shl
    table[instruction.i64_shrs] = ArithmeticLogicUnit.i64_shrs
    table[instruction.i64_shru] = ArithmeticLogicUnit.i64_shru
    table[instruction.i64_rotl] = ArithmeticLogicUnit.i64_rotl
    table[instruction.i64_rotr] = ArithmeticLogicUnit.i64_rotr
    table[instruction.f32_abs] = ArithmeticLogicUnit.f32_abs
    table[instruction.f32_neg] = ArithmeticLogicUnit.f32_neg
    table[instruction.f32_ceil] = ArithmeticLogicUnit.f32_ceil
    table[instruction.f32_floor] = ArithmeticLogicUnit.f32_floor
    table[instruction.f32_trunc] = ArithmeticLogicUnit.f32_trunc
    table[instruction.f32_nearest] = ArithmeticLogicUnit.f32_nearest
    table[instruction.f32_sqrt] = ArithmeticLogicUnit.f32_sqrt
    table[instruction.f32_add] = ArithmeticLogicUnit.f32_add
    table[instruction.f32_sub] = ArithmeticLogicUnit.f32_sub
    table[instruction.f32_mul] = ArithmeticLogicUnit.f32_mul
    table[instruction.f32_div] = ArithmeticLogicUnit.f32_div
    table[instruction.f32_min] = ArithmeticLogicUnit.f32_min
    table[instruction.f32_max] = ArithmeticLogicUnit.f32_max
    table[instruction.f32_copysign] = ArithmeticLogicUnit.f32_copysign
    table[instruction.f64_abs] = ArithmeticLogicUnit.f64_abs
    table[instruction.f64_neg] = ArithmeticLogicUnit.f64_neg
    table[instruction.f64_ceil] = ArithmeticLogicUnit.f64_ceil
    table[instruction.f64_floor] = ArithmeticLogicUnit.f64_floor
    table[instruction.f64_trunc] = ArithmeticLogicUnit.f64_trunc
    table[instruction.f64_nearest] = ArithmeticLogicUnit.f64_nearest
    table[instruction.f64_sqrt] = ArithmeticLogicUnit.f64_sqrt
    table[instruction.f64_add] = ArithmeticLogicUnit.f64_add
    table[instruction.f64_sub] = ArithmeticLogicUnit.f64_sub
    table[instruction.f64_mul] = ArithmeticLogicUnit.f64_mul
    table[instruction.f64_div] = ArithmeticLogicUnit.f64_div
    table[instruction.f64_min] = ArithmeticLogicUnit.f64_min
    table[instruction.f64_max] = ArithmeticLogicUnit.f64_max
    table[instruction.f64_copysign] = ArithmeticLogicUnit.f64_copysign
    table[instruction.i32_wrap_i64] = ArithmeticLogicUnit.i32_wrap_i64
    table[instruction.i32_trunc_sf32] = ArithmeticLogicUnit.i32_trunc_sf32
    table[instruction.i32_trunc_uf32] = ArithmeticLogicUnit.i32_trunc_uf32
    table[instruction.i32_trunc_sf64] = ArithmeticLogicUnit.i32_trunc_sf64
    table[instruction.i32_trunc_uf64] = ArithmeticLogicUnit.i32_trunc_uf64
    table[instruction.i64_extend_si32] = ArithmeticLogicUnit.i64_extend_si32
    table[instruction.i64_extend_ui32] = ArithmeticLogicUnit.i64_extend_ui32
    table[instruction.i64_trunc_sf32] = ArithmeticLogicUnit.i64_trunc_sf32
    table[instruction.i64_trunc_uf32] = ArithmeticLogicUnit.i64_trunc_uf32
    table[instruction.i64_trunc_sf64] = ArithmeticLogicUnit.i64_trunc_sf64
    table[instruction.i64_trunc_uf64] = ArithmeticLogicUnit.i64_trunc_uf64
    table[instruction.f32_convert_si32] = ArithmeticLogicUnit.f32_convert_si32
    table[instruction.f32_convert_ui32] = ArithmeticLogicUnit.f32_convert_ui32
    table[instruction.f32_convert_si64] = ArithmeticLogicUnit.f32_convert_si64
    table[instruction.f32_convert_ui64] = ArithmeticLogicUnit.f32_convert_ui64
    table[instruction.f32_demote_f64] = ArithmeticLogicUnit.f32_demote_f64
    table[instruction.f64_convert_si32] = ArithmeticLogicUnit.f64_convert_si32
    table[instruction.f64_convert_ui32] = ArithmeticLogicUnit.f64_convert_ui32
    table[instruction.f64_convert_si64] = ArithmeticLogicUnit.f64_convert_si64
    table[instruction.f64_convert_ui64] = ArithmeticLogicUnit.f64_convert_ui64
    table[instruction.f64_promote_f32] = ArithmeticLogicUnit.f64_promote_f32
    table[instruction.i32_reinterpret_f32] = ArithmeticLogicUnit.i32_reinterpret_f32
    table[instruction.i64_reinterpret_f64] = ArithmeticLogicUnit.i64_reinterpret_f64
    table[instruction.f32_reinterpret_i32] = ArithmeticLogicUnit.f32_reinterpret_i32
    table[instruction.f64_reinterpret_i64] = ArithmeticLogicUnit.f64_reinterpret_i64

    return table


_INSTRUCTION_TABLE = _make_instruction_table()


class Machine:
    # Execution behavior is defined in terms of an abstract machine that models the program state. It includes a stack,
    # which records operand values and control constructs, and an abstract store containing global state.
    def __init__(self):
        self.module: ModuleInstance = ModuleInstance()
        self.store: Store = Store()
        self.opts: option.Option = option.Option()

    def instantiate(self, module: binary.Module, extern_value_list: typing.List[ExternValue]):
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
                assert module.import_list[i].desc.value_type == self.store.global_list[e].value.type
                assert module.import_list[i].desc.mut == self.store.global_list[e].mut

        # Let vals be the vector of global initialization values determined by module and externvaln
        global_values: typing.List[Value] = []
        aux = ModuleInstance()
        aux.global_addr_list = [e for e in extern_value_list if isinstance(e, GlobalAddress)]
        for e in module.global_list:
            log.debugln(f'init global value')
            frame = Frame(aux, [], e.expr, 1)
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
            offset = r.val()
            table_addr = self.module.table_addr_list[element_segment.table_index]
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
            offset = r.val()
            memory_addr = self.module.memory_addr_list[data_segment.memory_index]
            memory_instance = self.store.memory_list[memory_addr]
            memory_instance.data[offset: offset + len(data_segment.init)] = data_segment.init

        # [TODO] Assert: due to validation, the frame F is now on the top of the stack.

        # If the start function module.start is not empty, invoke the function instance
        if module.start is not None:
            log.debugln(f'running start function {module.start}')
            self.invocate(self.module.function_addr_list[module.start.function_idx], [])

    def allocate(
        self,
        module: binary.Module,
        extern_value_list: typing.List[ExternValue],
        global_values: typing.List[Value],
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
            table_addr = self.store.allocate_table(e.type)
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
            if isinstance(e.desc, binary.FunctionIndex):
                addr = self.module.function_addr_list[e.desc]
            if isinstance(e.desc, binary.TableIndex):
                addr = self.module.table_addr_list[e.desc]
            if isinstance(e.desc, binary.MemoryIndex):
                addr = self.module.memory_addr_list[e.desc]
            if isinstance(e.desc, binary.GlobalIndex):
                addr = self.module.global_addr_list[e.desc]
            export_inst = ExportInstance(e.name, addr)
            self.module.export_list.append(export_inst)

    def invocate(self, function_addr: FunctionAddress, function_args: typing.List[Value]) -> Result:
        config = Configuration(self.store)
        config.opts = self.opts
        return config.call(function_addr, function_args)
