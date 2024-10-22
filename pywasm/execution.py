import math
import struct
import typing

from . import core
from . import log
from . import opcode
from . import option

from .core import ValInst

call_stack_depth = 128


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
        self.function_list: typing.List[core.FuncInst | core.FuncHost] = []
        self.table_list: typing.List[core.TableInst] = []
        self.memory_list: typing.List[core.MemInst] = []
        self.global_list: typing.List[core.GlobalInst] = []

        # For compatibility with older 0.4.x versions
        self.mems = self.memory_list

    def allocate_wasm_function(self, module: core.ModuleInst, function: core.FuncDesc) -> int:
        function_address = len(self.function_list)
        function_type = module.type[function.type]
        wasmfunc = core.FuncInst(function_type, module, function)
        self.function_list.append(wasmfunc)
        return function_address

    def allocate_host_function(self, hostfunc: core.FuncHost) -> int:
        function_address = len(self.function_list)
        self.function_list.append(hostfunc)
        return function_address

    def allocate_table(self, table_type: core.TableType) -> int:
        table_address = len(self.table_list)
        table_instance = core.TableInst(table_type)
        self.table_list.append(table_instance)
        return table_address

    def allocate_memory(self, memory_type: core.MemType) -> int:
        memory_address = len(self.memory_list)
        memory_instance = core.MemInst(memory_type)
        self.memory_list.append(memory_instance)
        return memory_address

    def allocate_global(self, global_type: core.GlobalType, value: ValInst) -> int:
        global_address = len(self.global_list)
        global_instance = core.GlobalInst(value, global_type.mut)
        self.global_list.append(global_instance)
        return global_address


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

    def __init__(
        self,
        module: core.ModuleInst,
        local_list: core.LocalsInst,
        expr: core.Expr,
        arity: int
    ):
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
        self.data: typing.List[typing.Union[ValInst, Label, Frame]] = []

    def len(self):
        return len(self.data)

    def append(self, v: typing.Union[ValInst, Label, Frame]):
        self.data.append(v)

    def pop(self):
        return self.data.pop()


def match_function(a: core.FuncType, b: core.FuncType) -> bool:
    return a.args.data == b.args.data and a.rets.data == b.rets.data


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

    def call(self, function_addr: int, function_args: typing.List[ValInst]) -> core.ResultInst:
        function = self.store.function_list[function_addr]
        log.debugln(f'call {function}({function_args})')
        for e, t in zip(function_args, function.type.args.data):
            assert e.type == t
        assert len(function.type.rets.data) < 2

        if function.kind == 0x00:
            local_list = core.LocalsInst(function_args)
            for e in function.code.locals:
                for _ in range(e.n):
                    local_list.data.append(ValInst(e.type, bytearray(8)))
            frame = Frame(
                module=function.module,
                local_list=local_list,
                expr=function.code.expr,
                arity=len(function.type.rets.data),
            )
            self.set_frame(frame)
            return self.exec()
        if function.kind == 0x01:
            r = function.hostcode(self.store, *[e.into_auto() for e in function_args])
            l = len(function.type.rets.data)
            if l == 0:
                return core.ResultInst([])
            if l == 1:
                return core.ResultInst([ValInst.from_auto(function.type.rets.data[0], r)])
            return [ValInst.from_auto(e, r[i]) for i, e in enumerate(function.type.rets.data)]
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
        return core.ResultInst(r)


class ArithmeticLogicUnit:

    @staticmethod
    def exec(config: Configuration, i: core.Inst):
        if log.lvl > 0:
            log.println('|', i)
        func = _INSTRUCTION_TABLE[i.opcode]
        func(config, i)

    @staticmethod
    def unreachable(config: Configuration, i: core.Inst):
        raise Exception('pywasm: unreachable')

    @staticmethod
    def nop(config: Configuration, i: core.Inst):
        pass

    @staticmethod
    def block(config: Configuration, i: core.Inst):
        arity = i.args[0].type
        assert arity < 2
        continuation = config.frame.expr.jump[config.pc][1]
        config.stack.append(Label(arity, continuation))

    @staticmethod
    def loop(config: Configuration, i: core.Inst):
        arity = i.args[0].type
        assert arity < 2
        continuation = config.frame.expr.jump[config.pc][0]
        config.stack.append(Label(arity, continuation))

    @staticmethod
    def if_then(config: Configuration, i: core.Inst):
        c = config.stack.pop().into_i32()
        arity = i.args[0].type
        assert arity < 2
        continuation = config.frame.expr.jump[config.pc][1]
        config.stack.append(Label(arity, continuation))
        if c == 0:
            if len(config.frame.expr.jump[config.pc]) == 3:
                config.pc = config.frame.expr.jump[config.pc][2]
            else:
                config.pc = config.frame.expr.jump[config.pc][1]
                config.stack.pop()

    @staticmethod
    def else_fi(config: Configuration, i: core.Inst):
        L = config.get_label(0)
        v = [config.stack.pop() for _ in range(L.arity)][::-1]
        while True:
            if isinstance(config.stack.pop(), Label):
                break
        for e in v:
            config.stack.append(e)
        config.pc = config.frame.expr.jump[config.pc][1]

    @staticmethod
    def end(config: Configuration, i: core.Inst):
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
    def br(config: Configuration, i: core.Inst):
        l = i.args[0]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def br_if(config: Configuration, i: core.Inst):
        if config.stack.pop().into_i32() == 0:
            return
        l = i.args[0]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def br_table(config: Configuration, i: core.Inst):
        a = i.args[0]
        l = i.args[1]
        c = config.stack.pop().into_i32()
        if c >= 0 and c < len(a):
            l = a[c]
        return ArithmeticLogicUnit.br_label(config, l)

    @staticmethod
    def return_call(config: Configuration, i: core.Inst):
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
    def call_function_addr(config: Configuration, function_addr: int):
        if config.depth > call_stack_depth:
            raise Exception('pywasm: call stack exhausted')

        function = config.store.function_list[function_addr]
        function_type = function.type
        function_args = [config.stack.pop() for _ in function_type.args.data][::-1]

        subcnf = Configuration(config.store)
        subcnf.depth = config.depth + 1
        subcnf.opts = config.opts
        r = subcnf.call(function_addr, function_args)
        for e in r.data:
            config.stack.append(e)

    @staticmethod
    def call(config: Configuration, i: core.Inst):
        function_addr: int = i.args[0]
        ArithmeticLogicUnit.call_function_addr(config, function_addr)

    @staticmethod
    def call_indirect(config: Configuration, i: core.Inst):
        if i.args[1] != 0x00:
            raise Exception("pywasm: zero byte malformed in call_indirect")
        ta = config.frame.module.tabl[0]
        tab = config.store.table_list[ta]
        idx = config.stack.pop().into_i32()
        if not 0 <= idx < len(tab.elem):
            raise Exception('pywasm: undefined element')
        function_addr = tab.elem[idx]
        if function_addr is None:
            raise Exception('pywasm: uninitialized element')
        ArithmeticLogicUnit.call_function_addr(config, function_addr)

    @staticmethod
    def drop(config: Configuration, i: core.Inst):
        config.stack.pop()

    @staticmethod
    def select(config: Configuration, i: core.Inst):
        c = config.stack.pop().into_i32()
        b = config.stack.pop()
        a = config.stack.pop()
        if c:
            config.stack.append(a)
        else:
            config.stack.append(b)

    @staticmethod
    def local_get(config: Configuration, i: core.Inst):
        r = config.frame.local_list.data[i.args[0]]
        o = ValInst(r.type, r.data.copy())
        config.stack.append(o)

    @staticmethod
    def local_set(config: Configuration, i: core.Inst):
        r = config.stack.pop()
        config.frame.local_list.data[i.args[0]] = r

    @staticmethod
    def local_tee(config: Configuration, i: core.Inst):
        r = config.stack.data[-1]
        o = ValInst(r.type, r.data.copy())
        config.frame.local_list.data[i.args[0]] = o

    @staticmethod
    def global_get(config: Configuration, i: core.Inst):
        a = config.frame.module.glob[i.args[0]]
        glob = config.store.global_list[a]
        r = glob.data
        config.stack.append(r)

    @staticmethod
    def global_set(config: Configuration, i: core.Inst):
        a = config.frame.module.glob[i.args[0]]
        glob = config.store.global_list[a]
        assert glob.mut == 0x01
        glob.data = config.stack.pop()

    @staticmethod
    def mem_load(config: Configuration, i: core.Inst, size: int) -> bytearray:
        memory_addr = config.frame.module.mems[0]
        memory = config.store.memory_list[memory_addr]
        offset = i.args[1]
        addr = config.stack.pop().into_i32() + offset
        if addr < 0 or addr + size > len(memory.data):
            raise Exception('pywasm: out of bounds memory access')
        return memory.data[addr:addr + size]

    @staticmethod
    def i32_load(config: Configuration, i: core.Inst):
        r = ValInst.from_i32(struct.unpack('<i', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load(config: Configuration, i: core.Inst):
        r = ValInst.from_i64(struct.unpack('<q', ArithmeticLogicUnit.mem_load(config, i, 8))[0])
        config.stack.append(r)

    @staticmethod
    def f32_load(config: Configuration, i: core.Inst):
        r = ValInst.from_f32(struct.unpack('<f', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def f64_load(config: Configuration, i: core.Inst):
        r = ValInst.from_f64(struct.unpack('<d', ArithmeticLogicUnit.mem_load(config, i, 8))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load8_s(config: Configuration, i: core.Inst):
        r = ValInst.from_i32(struct.unpack('<b', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load8_u(config: Configuration, i: core.Inst):
        r = ValInst.from_i32(struct.unpack('<B', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load16_s(config: Configuration, i: core.Inst):
        r = ValInst.from_i32(struct.unpack('<h', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i32_load16_u(config: Configuration, i: core.Inst):
        r = ValInst.from_i32(struct.unpack('<H', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load8_s(config: Configuration, i: core.Inst):
        r = ValInst.from_i64(struct.unpack('<b', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load8_u(config: Configuration, i: core.Inst):
        r = ValInst.from_i64(struct.unpack('<B', ArithmeticLogicUnit.mem_load(config, i, 1))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load16_s(config: Configuration, i: core.Inst):
        r = ValInst.from_i64(struct.unpack('<h', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load16_u(config: Configuration, i: core.Inst):
        r = ValInst.from_i64(struct.unpack('<H', ArithmeticLogicUnit.mem_load(config, i, 2))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load32_s(config: Configuration, i: core.Inst):
        r = ValInst.from_i64(struct.unpack('<i', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def i64_load32_u(config: Configuration, i: core.Inst):
        r = ValInst.from_i64(struct.unpack('<I', ArithmeticLogicUnit.mem_load(config, i, 4))[0])
        config.stack.append(r)

    @staticmethod
    def mem_store(config: Configuration, i: core.Inst, size: int):
        memory_addr = config.frame.module.mems[0]
        memory = config.store.memory_list[memory_addr]
        r = config.stack.pop()
        offset = i.args[1]
        addr = config.stack.pop().into_i32() + offset
        if addr < 0 or addr + size > len(memory.data):
            raise Exception('pywasm: out of bounds memory access')
        memory.data[addr:addr + size] = r.data[0:size]

    @staticmethod
    def i32_store(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def i64_store(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 8)

    @staticmethod
    def f32_store(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def f64_store(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 8)

    @staticmethod
    def i32_store8(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 1)

    @staticmethod
    def i32_store16(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 2)

    @staticmethod
    def i64_store8(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def i64_store16(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 2)

    @staticmethod
    def i64_store32(config: Configuration, i: core.Inst):
        ArithmeticLogicUnit.mem_store(config, i, 4)

    @staticmethod
    def memory_size(config: Configuration, i: core.Inst):
        memory_addr = config.frame.module.mems[0]
        memory = config.store.memory_list[memory_addr]
        r = ValInst.from_i32(memory.size)
        config.stack.append(r)

    @staticmethod
    def memory_grow(config: Configuration, i: core.Inst):
        memory_addr = config.frame.module.mems[0]
        memory = config.store.memory_list[memory_addr]
        size = memory.size
        r = config.stack.pop().into_i32()
        if config.opts.pages_limit > 0 and memory.size + r > config.opts.pages_limit:
            raise Exception('pywasm: out of memory limit')
        try:
            memory.grow(r)
            config.stack.append(ValInst.from_i32(size))
        except Exception:
            config.stack.append(ValInst.from_i32(-1))

    @staticmethod
    def i32_const(config: Configuration, i: core.Inst):
        config.stack.append(ValInst.from_i32(i.args[0]))

    @staticmethod
    def i64_const(config: Configuration, i: core.Inst):
        config.stack.append(ValInst.from_i64(i.args[0]))

    @staticmethod
    def f32_const(config: Configuration, i: core.Inst):
        o = ValInst.from_i32(i.args[0])
        o.type = core.ValType.f32()
        config.stack.append(o)

    @staticmethod
    def f64_const(config: Configuration, i: core.Inst):
        o = ValInst.from_i64(i.args[0])
        o.type = core.ValType.f64()
        config.stack.append(o)

    @staticmethod
    def i32_eqz(config: Configuration, i: core.Inst):
        config.stack.append(ValInst.from_i32(config.stack.pop().into_i32() == 0))

    @staticmethod
    def i32_eq(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(ValInst.from_i32(a == b))

    @staticmethod
    def i32_ne(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(ValInst.from_i32(a != b))

    @staticmethod
    def i32_lt_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(ValInst.from_i32(a < b))

    @staticmethod
    def i32_lt_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(ValInst.from_i32(a < b))

    @staticmethod
    def i32_gt_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(ValInst.from_i32(a > b))

    @staticmethod
    def i32_gt_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(ValInst.from_i32(a > b))

    @staticmethod
    def i32_le_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(ValInst.from_i32(a <= b))

    @staticmethod
    def i32_le_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(ValInst.from_i32(a <= b))

    @staticmethod
    def i32_ge_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        config.stack.append(ValInst.from_i32(int(a >= b)))

    @staticmethod
    def i32_ge_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        config.stack.append(ValInst.from_i32(int(a >= b)))

    @staticmethod
    def i64_eqz(config: Configuration, i: core.Inst):
        config.stack.append(ValInst.from_i32(config.stack.pop().into_i64() == 0))

    @staticmethod
    def i64_eq(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(ValInst.from_i32(a == b))

    @staticmethod
    def i64_ne(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(ValInst.from_i32(a != b))

    @staticmethod
    def i64_lt_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(ValInst.from_i32(a < b))

    @staticmethod
    def i64_lt_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(ValInst.from_i32(a < b))

    @staticmethod
    def i64_gt_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(ValInst.from_i32(a > b))

    @staticmethod
    def i64_gt_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(ValInst.from_i32(a > b))

    @staticmethod
    def i64_le_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(ValInst.from_i32(a <= b))

    @staticmethod
    def i64_le_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(ValInst.from_i32(a <= b))

    @staticmethod
    def i64_ge_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        config.stack.append(ValInst.from_i32(a >= b))

    @staticmethod
    def i64_ge_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        config.stack.append(ValInst.from_i32(a >= b))

    @staticmethod
    def f32_eq(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(ValInst.from_i32(a == b))

    @staticmethod
    def f32_ne(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(ValInst.from_i32(a != b))

    @staticmethod
    def f32_lt(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(ValInst.from_i32(a < b))

    @staticmethod
    def f32_gt(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(ValInst.from_i32(a > b))

    @staticmethod
    def f32_le(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(ValInst.from_i32(a <= b))

    @staticmethod
    def f32_ge(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        config.stack.append(ValInst.from_i32(a >= b))

    @staticmethod
    def f64_eq(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(ValInst.from_i32(a == b))

    @staticmethod
    def f64_ne(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(ValInst.from_i32(a != b))

    @staticmethod
    def f64_lt(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(ValInst.from_i32(a < b))

    @staticmethod
    def f64_gt(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(ValInst.from_i32(a > b))

    @staticmethod
    def f64_le(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(ValInst.from_i32(a <= b))

    @staticmethod
    def f64_ge(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        config.stack.append(ValInst.from_i32(a >= b))

    @staticmethod
    def i32_clz(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i32()
        c = 0
        while c < 32 and (a & 0x80000000) == 0:
            c += 1
            a = a << 1
        config.stack.append(ValInst.from_i32(c))

    @staticmethod
    def i32_ctz(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i32()
        c = 0
        while c < 32 and (a & 0x01) == 0:
            c += 1
            a = a >> 1
        config.stack.append(ValInst.from_i32(c))

    @staticmethod
    def i32_popcnt(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i32()
        c = 0
        for _ in range(32):
            if a & 0x01:
                c += 1
            a = a >> 1
        config.stack.append(ValInst.from_i32(c))

    @staticmethod
    def i32_add(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a + b)
        config.stack.append(c)

    @staticmethod
    def i32_sub(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a - b)
        config.stack.append(c)

    @staticmethod
    def i32_mul(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a * b)
        config.stack.append(c)

    @staticmethod
    def i32_div_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        if b == -1 and a == -2**31:
            raise Exception('pywasm: integer overflow')
        # Integer division that rounds towards 0 (like C)
        r = ValInst.from_i32(a // b if a * b > 0 else (a + (-a % b)) // b)
        config.stack.append(r)

    @staticmethod
    def i32_div_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = ValInst.from_i32(a // b)
        config.stack.append(r)

    @staticmethod
    def i32_rem_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        # Integer remainder that rounds towards 0 (like C)
        r = ValInst.from_i32(a % b if a * b > 0 else -(-a % b))
        config.stack.append(r)

    @staticmethod
    def i32_rem_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = ValInst.from_i32(a % b)
        config.stack.append(r)

    @staticmethod
    def i32_and(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a & b)
        config.stack.append(c)

    @staticmethod
    def i32_or(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a | b)
        config.stack.append(c)

    @staticmethod
    def i32_xor(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a ^ b)
        config.stack.append(c)

    @staticmethod
    def i32_shl(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a << (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_shr_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_i32()
        c = ValInst.from_i32(a >> (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_shr_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u32()
        a = config.stack.pop().into_u32()
        c = ValInst.from_i32(a >> (b % 0x20))
        config.stack.append(c)

    @staticmethod
    def i32_rotl(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_u32()
        c = ValInst.from_i32((((a << (b % 0x20)) & 0xffffffff) | (a >> (0x20 - (b % 0x20)))))
        config.stack.append(c)

    @staticmethod
    def i32_rotr(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i32()
        a = config.stack.pop().into_u32()
        c = ValInst.from_i32(((a >> (b % 0x20)) | ((a << (0x20 - (b % 0x20))) & 0xffffffff)))
        config.stack.append(c)

    @staticmethod
    def i64_clz(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i64()
        c = 0
        while c < 64 and (a & 0x8000000000000000) == 0:
            c += 1
            a = a << 1
        config.stack.append(ValInst.from_i64(c))

    @staticmethod
    def i64_ctz(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i64()
        c = 0
        while c < 64 and (a & 0x01) == 0:
            c += 1
            a = a >> 1
        config.stack.append(ValInst.from_i64(c))

    @staticmethod
    def i64_popcnt(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i64()
        c = 0
        for _ in range(64):
            if a & 0x01:
                c += 1
            a = a >> 1
        config.stack.append(ValInst.from_i64(c))

    @staticmethod
    def i64_add(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a + b)
        config.stack.append(c)

    @staticmethod
    def i64_sub(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a - b)
        config.stack.append(c)

    @staticmethod
    def i64_mul(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a * b)
        config.stack.append(c)

    @staticmethod
    def i64_div_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        if b == -1 and a == -2**63:
            raise Exception('pywasm: integer overflow')
        r = ValInst.from_i64(a // b if a * b > 0 else (a + (-a % b)) // b)
        config.stack.append(r)

    @staticmethod
    def i64_div_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = ValInst.from_i64(a // b)
        config.stack.append(r)

    @staticmethod
    def i64_rem_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        # Integer remainder that rounds towards 0 (like C)
        r = ValInst.from_i64(a % b if a * b > 0 else -(-a % b))
        config.stack.append(r)

    @staticmethod
    def i64_rem_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        if b == 0:
            raise Exception('pywasm: integer divide by zero')
        r = ValInst.from_i64(a % b)
        config.stack.append(r)

    @staticmethod
    def i64_and(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a & b)
        config.stack.append(c)

    @staticmethod
    def i64_or(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a | b)
        config.stack.append(c)

    @staticmethod
    def i64_xor(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a & b)
        config.stack.append(c)

    @staticmethod
    def i64_shl(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a << (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_shr_s(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_i64()
        c = ValInst.from_i64(a >> (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_shr_u(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_u64()
        a = config.stack.pop().into_u64()
        c = ValInst.from_i64(a >> (b % 0x40))
        config.stack.append(c)

    @staticmethod
    def i64_rotl(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_u64()
        c = ValInst.from_i64((((a << (b % 0x40)) & 0xffffffffffffffff) | (a >> (0x40 - (b % 0x40)))))
        config.stack.append(c)

    @staticmethod
    def i64_rotr(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_i64()
        a = config.stack.pop().into_u64()
        c = ValInst.from_i64(((a >> (b % 0x40)) | ((a << (0x40 - (b % 0x40))) & 0xffffffffffffffff)))
        config.stack.append(c)

    @staticmethod
    def f32_abs(config: Configuration, i: core.Inst):
        a = config.stack.pop()
        a.data[3] = a.data[3] & 0x7f
        config.stack.append(a)

    @staticmethod
    def f32_neg(config: Configuration, i: core.Inst):
        a = config.stack.pop()
        if a.data[3] & 0x80 != 0x00:
            a.data[3] = a.data[3] & 0x7f
        else:
            a.data[3] = a.data[3] | 0x80
        config.stack.append(a)

    @staticmethod
    def f32_ceil(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        try:
            r = ValInst.from_f32(float(math.ceil(a)))
        except OverflowError:
            r = ValInst.from_f32(a)
        except ValueError:
            r = ValInst.from_f32(a)
        config.stack.append(r)

    @staticmethod
    def f32_floor(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        try:
            r = ValInst.from_f32(float(math.floor(a)))
        except OverflowError:
            r = ValInst.from_f32(a)
        except ValueError:
            r = ValInst.from_f32(a)
        config.stack.append(r)

    @staticmethod
    def f32_trunc(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        try:
            r = ValInst.from_f32(float(math.trunc(a)))
        except OverflowError:
            r = ValInst.from_f32(a)
        except ValueError:
            r = ValInst.from_f32(a)
        config.stack.append(r)

    @staticmethod
    def f32_nearest(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        try:
            r = ValInst.from_f32(float(round(a)))
        except OverflowError:
            r = ValInst.from_f32(math.inf)
        except ValueError:
            r = ValInst.from_f32(math.nan)
        config.stack.append(r)

    @staticmethod
    def f32_sqrt(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        try:
            r = ValInst.from_f32(math.sqrt(a))
        except ValueError:
            r = ValInst.from_f32(math.nan)
        config.stack.append(r)

    @staticmethod
    def f32_add(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = ValInst.from_f32(a + b)
        config.stack.append(r)

    @staticmethod
    def f32_sub(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = ValInst.from_f32(a - b)
        config.stack.append(r)

    @staticmethod
    def f32_mul(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = ValInst.from_f32(a * b)
        config.stack.append(r)

    @staticmethod
    def f32_div(config: Configuration, i: core.Inst):
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
        r = ValInst.from_f32(c)
        config.stack.append(r)

    @staticmethod
    def f32_min(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(ValInst.from_f32(math.nan))
        else:
            config.stack.append(ValInst.from_f32(a if a < b else b))

    @staticmethod
    def f32_max(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(ValInst.from_f32(math.nan))
        else:
            config.stack.append(ValInst.from_f32(a if a > b else b))

    @staticmethod
    def f32_copysign(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f32()
        a = config.stack.pop().into_f32()
        r = ValInst.from_f32(math.copysign(a, b))
        config.stack.append(r)

    @staticmethod
    def f64_abs(config: Configuration, i: core.Inst):
        a = config.stack.pop()
        a.data[7] = a.data[7] & 0x7f
        config.stack.append(a)

    @staticmethod
    def f64_neg(config: Configuration, i: core.Inst):
        a = config.stack.pop()
        if a.data[7] & 0x80 != 0x00:
            a.data[7] = a.data[7] & 0x7f
        else:
            a.data[7] = a.data[7] | 0x80
        config.stack.append(a)

    @staticmethod
    def f64_ceil(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        try:
            r = ValInst.from_f64(float(math.ceil(a)))
        except OverflowError:
            r = ValInst.from_f64(a)
        except ValueError:
            r = ValInst.from_f64(a)
        config.stack.append(r)

    @staticmethod
    def f64_floor(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        try:
            r = ValInst.from_f64(float(math.floor(a)))
        except OverflowError:
            r = ValInst.from_f64(a)
        except ValueError:
            r = ValInst.from_f64(a)
        config.stack.append(r)

    @staticmethod
    def f64_trunc(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        try:
            r = ValInst.from_f64(float(math.trunc(a)))
        except OverflowError:
            r = ValInst.from_f64(a)
        except ValueError:
            r = ValInst.from_f64(a)
        config.stack.append(r)

    @staticmethod
    def f64_nearest(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        try:
            r = ValInst.from_f64(float(round(a)))
        except OverflowError:
            r = ValInst.from_f64(math.inf)
        except ValueError:
            r = ValInst.from_f64(math.nan)
        config.stack.append(r)

    @staticmethod
    def f64_sqrt(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        try:
            r = ValInst.from_f64(math.sqrt(a))
        except ValueError:
            r = ValInst.from_f64(math.nan)
        config.stack.append(r)

    @staticmethod
    def f64_add(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = ValInst.from_f64(a + b)
        config.stack.append(r)

    @staticmethod
    def f64_sub(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = ValInst.from_f64(a - b)
        config.stack.append(r)

    @staticmethod
    def f64_mul(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = ValInst.from_f64(a * b)
        config.stack.append(r)

    @staticmethod
    def f64_div(config: Configuration, i: core.Inst):
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
        r = ValInst.from_f64(c)
        config.stack.append(r)

    @staticmethod
    def f64_min(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(ValInst.from_f64(math.nan))
        else:
            config.stack.append(ValInst.from_f64(a if a < b else b))

    @staticmethod
    def f64_max(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        if math.isnan(a) or math.isnan(b):
            config.stack.append(ValInst.from_f64(math.nan))
        else:
            config.stack.append(ValInst.from_f64(a if a > b else b))

    @staticmethod
    def f64_copysign(config: Configuration, i: core.Inst):
        b = config.stack.pop().into_f64()
        a = config.stack.pop().into_f64()
        r = ValInst.from_f64(math.copysign(a, b))
        config.stack.append(r)

    @staticmethod
    def i32_wrap_i64(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i64()
        config.stack.append(ValInst.from_i32(a))

    @staticmethod
    def i32_trunc_f32_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        if a > (1 << 31) - 1 or a < -(1 << 31):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_f32_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        if a > (1 << 32) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_f64_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        if a > (1 << 31) - 1 or a < -(1 << 31):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i32_trunc_f64_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        if a > (1 << 32) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i32(b)
        config.stack.append(r)

    @staticmethod
    def i64_extend_i32_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i32()
        r = ValInst.from_i64(a)
        config.stack.append(r)

    @staticmethod
    def i64_extend_i32_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_u32()
        r = ValInst.from_i64(a)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f32_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        if a > (1 << 63) - 1 or a < -(1 << 63):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f32_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        if a > (1 << 64) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f64_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        if a > (1 << 63) - 1 or a < -(1 << 63):
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def i64_trunc_f64_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        if a > (1 << 64) - 1 or a <= -1:
            raise Exception('pywasm: integer overflow')
        try:
            b = int(a)
        except:
            raise Exception('pywasm: invalid conversion to integer')
        r = ValInst.from_i64(b)
        config.stack.append(r)

    @staticmethod
    def f32_convert_i32_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i32()
        r = ValInst.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_i32_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_u32()
        r = ValInst.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_i64_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i64()
        r = ValInst.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_convert_i64_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_u64()
        r = ValInst.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f32_demote_f64(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f64()
        r = ValInst.from_f32(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i32_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i32()
        r = ValInst.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i32_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_u32()
        r = ValInst.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i64_s(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_i64()
        r = ValInst.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_convert_i64_u(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_u64()
        r = ValInst.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def f64_promote_f32(config: Configuration, i: core.Inst):
        a = config.stack.pop().into_f32()
        r = ValInst.from_f64(float(a))
        config.stack.append(r)

    @staticmethod
    def i32_reinterpret_f32(config: Configuration, i: core.Inst):
        a = config.stack.pop()
        a.type = core.ValType.i32()
        config.stack.append(a)

    @staticmethod
    def i64_reinterpret_f64(config: Configuration, i: core.Inst):
        a = config.stack.pop()
        a.type = core.ValType.i64()
        config.stack.append(a)

    @staticmethod
    def f32_reinterpret_i32(config: Configuration, i: core.Inst):
        a = config.stack.pop()
        a.type = core.ValType.f32()
        config.stack.append(a)

    @staticmethod
    def f64_reinterpret_i64(config: Configuration, i: core.Inst):
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
        self.module: core.ModuleInst = core.ModuleInst()
        self.store: Store = Store()
        self.opts: option.Option = option.Option()

    def instantiate(self, module: core.ModuleDesc, extern_value_list: typing.List[core.Extern]):
        self.module.type = module.type

        # [TODO] If module is not valid, then panic

        # Assert: module is valid with external types classifying its imports
        for e in extern_value_list:
            if e.type == 0x00:
                assert e.data < len(self.store.function_list)
            if e.type == 0x01:
                assert e.data < len(self.store.table_list)
            if e.type == 0x02:
                assert e.data < len(self.store.memory_list)
            if e.type == 0x03:
                assert e.data < len(self.store.global_list)

        # If the number m of imports is not equal to the number n of provided external values, then fail
        assert len(module.imps) == len(extern_value_list)

        # For each external value and external type, do:
        # If externval is not valid with an external type in store S, then fail
        # If externtype does not match externtype, then fail
        for i, e in enumerate(extern_value_list):
            if e.type == 0x00:
                a = self.store.function_list[e.data].type
                b = module.type[module.imps[i].desc]
                assert match_function(a, b)
            if e.type == 0x01:
                a = self.store.table_list[e.data]
                b = module.imps[i].desc
                assert a.type.limits.suit(b.limits)
            if e.type == 0x02:
                a = self.store.memory_list[e.data].type
                b = module.imps[i].desc
                assert a.limits.suit(b.limits)
            if e.type == 0x03:
                assert module.imps[i].desc.type == self.store.global_list[e.data].data.type
                assert module.imps[i].desc.mut == self.store.global_list[e.data].mut

        # Let vals be the vector of global initialization values determined by module and externvaln
        global_values: typing.List[ValInst] = []
        aux = core.ModuleInst()
        aux.glob = [e for e in extern_value_list if e.type == 0x03]
        for e in module.glob:
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

        for element_segment in module.elem:
            log.debugln('init elem')
            # Let F be the frame, push the frame F to the stack
            frame = Frame(self.module, [], element_segment.offset, 1)
            config = Configuration(self.store)
            config.opts = self.opts
            config.set_frame(frame)
            r = config.exec().data[0]
            offset = r.into_auto()
            table_addr = self.module.tabl[element_segment.data]
            table_instance = self.store.table_list[table_addr]
            for i, e in enumerate(element_segment.init):
                table_instance.elem[offset + i] = e

        for data_segment in module.data:
            log.debugln('init data')
            frame = Frame(self.module, [], data_segment.offset, 1)
            config = Configuration(self.store)
            config.opts = self.opts
            config.set_frame(frame)
            r = config.exec().data[0]
            offset = r.into_auto()
            memory_addr = self.module.mems[data_segment.data]
            memory_instance = self.store.memory_list[memory_addr]
            memory_instance.data[offset: offset + len(data_segment.init)] = data_segment.init

        # [TODO] Assert: due to validation, the frame F is now on the top of the stack.

        # If the start function module.start is not empty, invoke the function instance
        if module.star >= 0:
            log.debugln(f'running start function {module.star}')
            self.invocate(self.module.func[module.star], [])

    def allocate(
        self,
        module: core.ModuleDesc,
        extern_value_list: typing.List[core.Extern],
        global_values: typing.List[ValInst],
    ):
        # Let funcaddr be the list of function addresses extracted from externval, concatenated with funcaddr
        # Let tableaddr be the list of table addresses extracted from externval, concatenated with tableaddr
        # Let memaddr be the list of memory addresses extracted from externval, concatenated with memaddr
        # Let globaladdr be the list of global addresses extracted from externval, concatenated with globaladdr
        for e in extern_value_list:
            if e.type == 0x00:
                self.module.func.append(e.data)
            if e.type == 0x01:
                self.module.tabl.append(e.data)
            if e.type == 0x02:
                self.module.mems.append(e.data)
            if e.type == 0x03:
                self.module.glob.append(e.data)

        # For each function func in module.funcs, do:
        for e in module.func:
            function_addr = self.store.allocate_wasm_function(self.module, e)
            self.module.func.append(function_addr)

        # For each table in module.tables, do:
        for e in module.tabl:
            table_addr = self.store.allocate_table(e)
            self.module.tabl.append(table_addr)

        # For each memory module.mems, do:
        for e in module.mems:
            memory_addr = self.store.allocate_memory(e)
            self.module.mems.append(memory_addr)

        # For each global in module.globals, do:
        for i, e in enumerate(module.glob):
            global_addr = self.store.allocate_global(e.type, global_values[i])
            self.module.glob.append(global_addr)

        # For each export in module.exports, do:
        for e in module.exps:
            if e.type == 0x00:
                addr = self.module.func[e.desc]
                addr = core.Extern(0x00, addr)
            if e.type == 0x01:
                addr = self.module.tabl[e.desc]
                addr = core.Extern(0x01, addr)
            if e.type == 0x02:
                addr = self.module.mems[e.desc]
                addr = core.Extern(0x02, addr)
            if e.type == 0x03:
                addr = self.module.glob[e.desc]
                addr = core.Extern(0x03, addr)
            export_inst = core.ExportInst(e.name, addr)
            self.module.exps.append(export_inst)

    def invocate(self, function_addr: int, function_args: typing.List[ValInst]) -> core.ResultInst:
        config = Configuration(self.store)
        config.opts = self.opts
        return config.call(function_addr, function_args)
