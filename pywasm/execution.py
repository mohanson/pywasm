import typing

from . import binary
from . import convention
from . import instruction
from . import log
from . import num

# ======================================================================================================================
# Execution Runtime Structure
# ======================================================================================================================


class Value:
    # Values are represented by themselves.
    def __init__(self):
        self.type: binary.ValueType = binary.ValueType()
        self.data: bytearray = bytearray(8)

    def __repr__(self):
        return f'{self.type} {self.val()}'

    def val(self) -> typing.Union[num.i32, num.i64, num.f32, num.f64]:
        return {
            convention.i32: self.i32,
            convention.i64: self.i64,
            convention.f32: self.f32,
            convention.f64: self.f64
        }[self.type]()

    def i32(self) -> num.i32:
        assert self.type == convention.i32
        return num.LittleEndian.i32(self.data[0:4])

    def i64(self) -> num.i64:
        assert self.type == convention.i64
        return num.LittleEndian.i64(self.data[0:8])

    def f32(self) -> num.f32:
        assert self.type == convention.f32
        return num.LittleEndian.f32(self.data[0:4])

    def f64(self) -> num.f64:
        assert self.type == convention.f64
        return num.LittleEndian.f64(self.data[0:8])

    @classmethod
    def from_i32(cls, n: num.i32):
        o = Value()
        o.type = binary.ValueType(convention.i32)
        o.data[0:4] = num.LittleEndian.pack_i32(n)
        return o

    @classmethod
    def from_i64(cls, n: num.i64):
        o = Value()
        o.type = binary.ValueType(convention.i64)
        o.data[0:8] = num.LittleEndian.pack_i64(n)
        return o

    @classmethod
    def from_f32(cls, n: num.f32):
        o = Value()
        o.type = binary.ValueType(convention.f32)
        o.data[0:4] = num.LittleEndian.pack_f32(n)
        return o

    @classmethod
    def from_f64(cls, n: num.f64):
        o = Value()
        o.type = binary.ValueType(convention.f64)
        o.data[0:8] = num.LittleEndian.pack_f64(n)
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
        self.element_list: typing.List[FunctionAddress] = [FunctionAddress() for _ in range(limits.n)]
        self.size = limits.m


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
    def __init__(self, size: int):
        self.size = size
        self.data = bytearray()

    def grow(self, n: int):
        if self.size and len(self.data) // convention.memory_page_size + n > self.size:
            raise Exception('pywasm: out of memory limit')
        self.data.extend([0x00 for _ in range(n * convention.memory_page_size)])


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
        memory_instance = MemoryInstance(memory_type.limits.m)
        memory_instance.grow(memory_type.limits.n)
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


class Label:
    # Labels carry an argument arity n and their associated branch target, which is expressed syntactically as an
    # instruction sequence:
    #
    # label ::= labeln{instr∗}
    #
    # Intuitively, instr∗ is the continuation to execute when the branch is taken, in place of the original control
    # construct.
    def __init__(self, opcode: int, instruction_list: typing.List[binary.Instruction], arity: int):
        # Mark which instruction is replaced by Label, usefull in loop
        self.opcode = opcode
        self.instruction_list = instruction_list
        self.arity = arity
        self.value_stack = Stack()


class Frame:
    # Activation frames carry the return arity n of the respective function, hold the values of its locals
    # (including arguments) in the order corresponding to their static local indices, and a reference to the function's
    # own module instance.

    def __init__(self, module: ModuleInstance,
                 local_list: typing.List[Value],
                 instruction_list: typing.List[binary.Instruction],
                 arity: int):
        self.module = module
        self.local_list = local_list
        self.instruction_list = instruction_list
        self.arity = arity
        self.label_stack = Stack()
        self.value_stack = Stack()

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

    def pop(self):
        return self.data.pop()

    def add(self, v: typing.Union[Value, Label, Frame]):
        self.data.append(v)

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
    return a.args.data == b.args and a.rets == b.rets


def match_table(a: binary.TableType, b: binary.TableType) -> bool:
    return match_limits(a.limits, b.limits) and a.element_type == b.element_type


def match_memory(a: binary.MemoryType, b: binary.MemoryType) -> bool:
    return match_limits(a.limits, b.limits)


def match_global(a: binary.GlobalType, b: binary.GlobalType) -> bool:
    return a.mut == b.mut and a.value_type == b.value_type


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
        self.frame_stack = Stack()

    def current_frame(self) -> Frame:
        return self.frame_stack.data[-1]

    def current_label(self) -> Label:
        return self.current_frame().label_stack.data[-1]

    def execute(self) -> Result:
        frame: Frame = self.frame_stack.data[-1]
        for e in frame.instruction_list:
            ArithmeticLogicUnit.exec(self, e)
        r = []
        for _ in range(frame.arity):
            r.append(frame.value_stack.pop())
        return Result(r)


# ======================================================================================================================
# Instruction Set
# ======================================================================================================================


class ArithmeticLogicUnit:

    @staticmethod
    def exec(config: Configuration, i: binary.Instruction):
        log.debugln(i)
        func = {
            instruction.unreachable: ArithmeticLogicUnit.unreachable,
            instruction.nop: ArithmeticLogicUnit.nop,
            instruction.block: ArithmeticLogicUnit.block,
            instruction.loop: ArithmeticLogicUnit.loop,
            instruction.if_: ArithmeticLogicUnit.if_,
            instruction.br: ArithmeticLogicUnit.br,
            instruction.br_if: ArithmeticLogicUnit.br_if,
            instruction.br_table: ArithmeticLogicUnit.br_table,
            instruction.return_: ArithmeticLogicUnit.return_,
            instruction.call: ArithmeticLogicUnit.call,
            instruction.call_indirect: ArithmeticLogicUnit.call_indirect,
            instruction.drop: ArithmeticLogicUnit.drop,
            instruction.select: ArithmeticLogicUnit.select,
            instruction.get_local: ArithmeticLogicUnit.get_local,
            instruction.set_local: ArithmeticLogicUnit.set_local,
            instruction.tee_local: ArithmeticLogicUnit.tee_local,
            instruction.get_global: ArithmeticLogicUnit.get_global,
            instruction.set_global: ArithmeticLogicUnit.set_global,
            instruction.i32_load: ArithmeticLogicUnit.i32_load,
            instruction.i64_load: ArithmeticLogicUnit.i64_load,
            instruction.f32_load: ArithmeticLogicUnit.f32_load,
            instruction.f64_load: ArithmeticLogicUnit.f64_load,
            instruction.i32_load8_s: ArithmeticLogicUnit.i32_load8_s,
            instruction.i32_load8_u: ArithmeticLogicUnit.i32_load8_u,
            instruction.i32_load16_s: ArithmeticLogicUnit.i32_load16_s,
            instruction.i32_load16_u: ArithmeticLogicUnit.i32_load16_u,
            instruction.i64_load8_s: ArithmeticLogicUnit.i64_load8_s,
            instruction.i64_load8_u: ArithmeticLogicUnit.i64_load8_u,
            instruction.i64_load16_s: ArithmeticLogicUnit.i64_load16_s,
            instruction.i64_load16_u: ArithmeticLogicUnit.i64_load16_u,
            instruction.i64_load32_s: ArithmeticLogicUnit.i64_load32_s,
            instruction.i64_load32_u: ArithmeticLogicUnit.i64_load32_u,
            instruction.i32_store: ArithmeticLogicUnit.i32_store,
            instruction.i64_store: ArithmeticLogicUnit.i64_store,
            instruction.f32_store: ArithmeticLogicUnit.f32_store,
            instruction.f64_store: ArithmeticLogicUnit.f64_store,
            instruction.i32_store8: ArithmeticLogicUnit.i32_store8,
            instruction.i32_store16: ArithmeticLogicUnit.i32_store16,
            instruction.i64_store8: ArithmeticLogicUnit.i64_store8,
            instruction.i64_store16: ArithmeticLogicUnit.i64_store16,
            instruction.i64_store32: ArithmeticLogicUnit.i64_store32,
            instruction.current_memory: ArithmeticLogicUnit.current_memory,
            instruction.grow_memory: ArithmeticLogicUnit.grow_memory,
            instruction.i32_const: ArithmeticLogicUnit.i32_const,
            instruction.i64_const: ArithmeticLogicUnit.i64_const,
            instruction.f32_const: ArithmeticLogicUnit.f32_const,
            instruction.f64_const: ArithmeticLogicUnit.f64_const,
            instruction.i32_eqz: ArithmeticLogicUnit.i32_eqz,
            instruction.i32_eq: ArithmeticLogicUnit.i32_eq,
            instruction.i32_ne: ArithmeticLogicUnit.i32_ne,
            instruction.i32_lts: ArithmeticLogicUnit.i32_lts,
            instruction.i32_ltu: ArithmeticLogicUnit.i32_ltu,
            instruction.i32_gts: ArithmeticLogicUnit.i32_gts,
            instruction.i32_gtu: ArithmeticLogicUnit.i32_gtu,
            instruction.i32_les: ArithmeticLogicUnit.i32_les,
            instruction.i32_leu: ArithmeticLogicUnit.i32_leu,
            instruction.i32_ges: ArithmeticLogicUnit.i32_ges,
            instruction.i32_geu: ArithmeticLogicUnit.i32_geu,
            instruction.i64_eqz: ArithmeticLogicUnit.i64_eqz,
            instruction.i64_eq: ArithmeticLogicUnit.i64_eq,
            instruction.i64_ne: ArithmeticLogicUnit.i64_ne,
            instruction.i64_lts: ArithmeticLogicUnit.i64_lts,
            instruction.i64_ltu: ArithmeticLogicUnit.i64_ltu,
            instruction.i64_gts: ArithmeticLogicUnit.i64_gts,
            instruction.i64_gtu: ArithmeticLogicUnit.i64_gtu,
            instruction.i64_les: ArithmeticLogicUnit.i64_les,
            instruction.i64_leu: ArithmeticLogicUnit.i64_leu,
            instruction.i64_ges: ArithmeticLogicUnit.i64_ges,
            instruction.i64_geu: ArithmeticLogicUnit.i64_geu,
            instruction.f32_eq: ArithmeticLogicUnit.f32_eq,
            instruction.f32_ne: ArithmeticLogicUnit.f32_ne,
            instruction.f32_lt: ArithmeticLogicUnit.f32_lt,
            instruction.f32_gt: ArithmeticLogicUnit.f32_gt,
            instruction.f32_le: ArithmeticLogicUnit.f32_le,
            instruction.f32_ge: ArithmeticLogicUnit.f32_ge,
            instruction.f64_eq: ArithmeticLogicUnit.f64_eq,
            instruction.f64_ne: ArithmeticLogicUnit.f64_ne,
            instruction.f64_lt: ArithmeticLogicUnit.f64_lt,
            instruction.f64_gt: ArithmeticLogicUnit.f64_gt,
            instruction.f64_le: ArithmeticLogicUnit.f64_le,
            instruction.f64_ge: ArithmeticLogicUnit.f64_ge,
            instruction.i32_clz: ArithmeticLogicUnit.i32_clz,
            instruction.i32_ctz: ArithmeticLogicUnit.i32_ctz,
            instruction.i32_popcnt: ArithmeticLogicUnit.i32_popcnt,
            instruction.i32_add: ArithmeticLogicUnit.i32_add,
            instruction.i32_sub: ArithmeticLogicUnit.i32_sub,
            instruction.i32_mul: ArithmeticLogicUnit.i32_mul,
            instruction.i32_divs: ArithmeticLogicUnit.i32_divs,
            instruction.i32_divu: ArithmeticLogicUnit.i32_divu,
            instruction.i32_rems: ArithmeticLogicUnit.i32_rems,
            instruction.i32_remu: ArithmeticLogicUnit.i32_remu,
            instruction.i32_and: ArithmeticLogicUnit.i32_and,
            instruction.i32_or: ArithmeticLogicUnit.i32_or,
            instruction.i32_xor: ArithmeticLogicUnit.i32_xor,
            instruction.i32_shl: ArithmeticLogicUnit.i32_shl,
            instruction.i32_shrs: ArithmeticLogicUnit.i32_shrs,
            instruction.i32_shru: ArithmeticLogicUnit.i32_shru,
            instruction.i32_rotl: ArithmeticLogicUnit.i32_rotl,
            instruction.i32_rotr: ArithmeticLogicUnit.i32_rotr,
            instruction.i64_clz: ArithmeticLogicUnit.i64_clz,
            instruction.i64_ctz: ArithmeticLogicUnit.i64_ctz,
            instruction.i64_popcnt: ArithmeticLogicUnit.i64_popcnt,
            instruction.i64_add: ArithmeticLogicUnit.i64_add,
            instruction.i64_sub: ArithmeticLogicUnit.i64_sub,
            instruction.i64_mul: ArithmeticLogicUnit.i64_mul,
            instruction.i64_divs: ArithmeticLogicUnit.i64_divs,
            instruction.i64_divu: ArithmeticLogicUnit.i64_divu,
            instruction.i64_rems: ArithmeticLogicUnit.i64_rems,
            instruction.i64_remu: ArithmeticLogicUnit.i64_remu,
            instruction.i64_and: ArithmeticLogicUnit.i64_and,
            instruction.i64_or: ArithmeticLogicUnit.i64_or,
            instruction.i64_xor: ArithmeticLogicUnit.i64_xor,
            instruction.i64_shl: ArithmeticLogicUnit.i64_shl,
            instruction.i64_shrs: ArithmeticLogicUnit.i64_shrs,
            instruction.i64_shru: ArithmeticLogicUnit.i64_shru,
            instruction.i64_rotl: ArithmeticLogicUnit.i64_rotl,
            instruction.i64_rotr: ArithmeticLogicUnit.i64_rotr,
            instruction.f32_abs: ArithmeticLogicUnit.f32_abs,
            instruction.f32_neg: ArithmeticLogicUnit.f32_neg,
            instruction.f32_ceil: ArithmeticLogicUnit.f32_ceil,
            instruction.f32_floor: ArithmeticLogicUnit.f32_floor,
            instruction.f32_trunc: ArithmeticLogicUnit.f32_trunc,
            instruction.f32_nearest: ArithmeticLogicUnit.f32_nearest,
            instruction.f32_sqrt: ArithmeticLogicUnit.f32_sqrt,
            instruction.f32_add: ArithmeticLogicUnit.f32_add,
            instruction.f32_sub: ArithmeticLogicUnit.f32_sub,
            instruction.f32_mul: ArithmeticLogicUnit.f32_mul,
            instruction.f32_div: ArithmeticLogicUnit.f32_div,
            instruction.f32_min: ArithmeticLogicUnit.f32_min,
            instruction.f32_max: ArithmeticLogicUnit.f32_max,
            instruction.f32_copysign: ArithmeticLogicUnit.f32_copysign,
            instruction.f64_abs: ArithmeticLogicUnit.f64_abs,
            instruction.f64_neg: ArithmeticLogicUnit.f64_neg,
            instruction.f64_ceil: ArithmeticLogicUnit.f64_ceil,
            instruction.f64_floor: ArithmeticLogicUnit.f64_floor,
            instruction.f64_trunc: ArithmeticLogicUnit.f64_trunc,
            instruction.f64_nearest: ArithmeticLogicUnit.f64_nearest,
            instruction.f64_sqrt: ArithmeticLogicUnit.f64_sqrt,
            instruction.f64_add: ArithmeticLogicUnit.f64_add,
            instruction.f64_sub: ArithmeticLogicUnit.f64_sub,
            instruction.f64_mul: ArithmeticLogicUnit.f64_mul,
            instruction.f64_div: ArithmeticLogicUnit.f64_div,
            instruction.f64_min: ArithmeticLogicUnit.f64_min,
            instruction.f64_max: ArithmeticLogicUnit.f64_max,
            instruction.f64_copysign: ArithmeticLogicUnit.f64_copysign,
            instruction.i32_wrap_i64: ArithmeticLogicUnit.i32_wrap_i64,
            instruction.i32_trunc_sf32: ArithmeticLogicUnit.i32_trunc_sf32,
            instruction.i32_trunc_uf32: ArithmeticLogicUnit.i32_trunc_uf32,
            instruction.i32_trunc_sf64: ArithmeticLogicUnit.i32_trunc_sf64,
            instruction.i32_trunc_uf64: ArithmeticLogicUnit.i32_trunc_uf64,
            instruction.i64_extend_si32: ArithmeticLogicUnit.i64_extend_si32,
            instruction.i64_extend_ui32: ArithmeticLogicUnit.i64_extend_ui32,
            instruction.i64_trunc_sf32: ArithmeticLogicUnit.i64_trunc_sf32,
            instruction.i64_trunc_uf32: ArithmeticLogicUnit.i64_trunc_uf32,
            instruction.i64_trunc_sf64: ArithmeticLogicUnit.i64_trunc_sf64,
            instruction.i64_trunc_uf64: ArithmeticLogicUnit.i64_trunc_uf64,
            instruction.f32_convert_si32: ArithmeticLogicUnit.f32_convert_si32,
            instruction.f32_convert_ui32: ArithmeticLogicUnit.f32_convert_ui32,
            instruction.f32_convert_si64: ArithmeticLogicUnit.f32_convert_si64,
            instruction.f32_convert_ui64: ArithmeticLogicUnit.f32_convert_ui64,
            instruction.f32_demote_f64: ArithmeticLogicUnit.f32_demote_f64,
            instruction.f64_convert_si32: ArithmeticLogicUnit.f64_convert_si32,
            instruction.f64_convert_ui32: ArithmeticLogicUnit.f64_convert_ui32,
            instruction.f64_convert_si64: ArithmeticLogicUnit.f64_convert_si64,
            instruction.f64_convert_ui64: ArithmeticLogicUnit.f64_convert_ui64,
            instruction.f64_promote_f32: ArithmeticLogicUnit.f64_promote_f32,
            instruction.i32_reinterpret_f32: ArithmeticLogicUnit.i32_reinterpret_f32,
            instruction.i64_reinterpret_f64: ArithmeticLogicUnit.i64_reinterpret_f64,
            instruction.f32_reinterpret_i32: ArithmeticLogicUnit.f32_reinterpret_i32,
            instruction.f64_reinterpret_i64: ArithmeticLogicUnit.f64_reinterpret_i64,
        }[i.opcode]
        func(config, i)

    @staticmethod
    def unreachable(config: Configuration, i: binary.Instruction):
        raise Exception('pywasm: unreachable')

    @staticmethod
    def nop(config: Configuration, i: binary.Instruction):
        pass

    @staticmethod
    def block(config: Configuration, i: binary.Instruction):
        arity = 1
        label = Label(i.opcode, i.args[1], arity)
        config.current_frame().label_stack.add(label)
        for e in i.args[1]:
            ArithmeticLogicUnit.exec(config, e)
        config.current_frame().label_stack.pop()
        for _ in range(arity):
            v = label.value_stack.pop()
            if config.current_frame().label_stack.len():
                config.current_label().value_stack.add(v)
            else:
                config.current_frame().value_stack.add(v)

    @staticmethod
    def loop(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def if_(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def br(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def br_if(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def br_table(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def return_(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def call(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def call_indirect(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def drop(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def select(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def get_local(config: Configuration, i: binary.Instruction):
        value = config.current_frame().local_list[i.args[0]]
        config.current_label().value_stack.add(value)

    @staticmethod
    def set_local(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def tee_local(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def get_global(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def set_global(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_load(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_load(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_load(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_load(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_load8_s(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_load8_u(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_load16_s(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_load16_u(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_load8_s(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_load8_u(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_load16_s(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_load16_u(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_load32_s(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_load32_u(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_store(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_store(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_store(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_store(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_store8(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_store16(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_store8(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_store16(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_store32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def current_memory(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def grow_memory(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_const(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_const(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_const(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_const(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_eqz(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_eq(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_ne(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_lts(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_ltu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_gts(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_gtu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_les(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_leu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_ges(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_geu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_eqz(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_eq(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_ne(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_lts(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_ltu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_gts(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_gtu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_les(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_leu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_ges(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_geu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_eq(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_ne(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_lt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_gt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_le(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_ge(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_eq(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_ne(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_lt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_gt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_le(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_ge(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_clz(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_ctz(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_popcnt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_add(config: Configuration, i: binary.Instruction):
        b = config.current_label().value_stack.pop().i32()
        a = config.current_label().value_stack.pop().i32()
        c = Value.from_i32(a + b)
        config.current_label().value_stack.add(c)

    @staticmethod
    def i32_sub(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_mul(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_divs(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_divu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_rems(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_remu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_and(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_or(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_xor(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_shl(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_shrs(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_shru(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_rotl(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_rotr(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_clz(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_ctz(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_popcnt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_add(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_sub(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_mul(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_divs(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_divu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_rems(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_remu(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_and(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_or(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_xor(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_shl(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_shrs(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_shru(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_rotl(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_rotr(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_abs(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_neg(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_ceil(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_floor(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_trunc(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_nearest(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_sqrt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_add(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_sub(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_mul(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_div(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_min(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_max(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_copysign(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_abs(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_neg(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_ceil(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_floor(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_trunc(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_nearest(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_sqrt(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_add(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_sub(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_mul(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_div(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_min(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_max(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_copysign(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_wrap_i64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_trunc_sf32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_trunc_uf32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_trunc_sf64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_trunc_uf64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_extend_si32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_extend_ui32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_trunc_sf32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_trunc_uf32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_trunc_sf64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_trunc_uf64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_convert_si32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_convert_ui32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_convert_si64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_convert_ui64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_demote_f64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_convert_si32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_convert_ui32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_convert_si64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_convert_ui64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_promote_f32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i32_reinterpret_f32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def i64_reinterpret_f64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f32_reinterpret_i32(config: Configuration, i: binary.Instruction):
        raise NotImplementedError

    @staticmethod
    def f64_reinterpret_i64(config: Configuration, i: binary.Instruction):
        raise NotImplementedError


class Machine:
    # Execution behavior is defined in terms of an abstract machine that models the program state. It includes a stack,
    # which records operand values and control constructs, and an abstract store containing global state.
    def __init__(self):
        self.module: ModuleInstance = ModuleInstance()
        self.stack: Stack = Stack()
        self.store: Store = Store()

    # def init_elem(self):
    #     pass

    # def init_data(self):
    #     pass

    def instantiate(self, module: binary.Module, imps: typing.Dict[str, typing.Dict[str, typing.Any]] = None):
        log.debugln('instantiate')
        self.module.type_list = module.type_list
        imps = imps if imps else {}
        extern_value_list: typing.List[ExternValue] = []
        for e in module.import_list:
            if e.module not in imps or e.name not in imps[e.module]:
                raise Exception(f'pywasm: missing import {e.module}.{e.name}')
            if isinstance(e.desc, binary.TypeIndex):
                a = HostFunc(self.module.type_list[e.desc], imps[e.module][e.name])
                addr = self.store.allocate_host_function(a)
                extern_value_list.append(addr)
                continue
            if isinstance(e.desc, binary.TableType):
                raise NotImplementedError
            if isinstance(e.desc, binary.MemoryType):
                raise NotImplementedError
            if isinstance(e.desc, binary.GlobalType):
                raise NotImplementedError

        # [TODO] If module is not valid, then panic

        # [TODO] Assert: module is valid with external types classifying its imports

        # [TODO] If the number m of imports is not equal to the number n of provided external values, then fail

        # [TODO] For each external value and external type, do:
        # If externval is not valid with an external type in store S, then fail
        # If externtype does not match externtype, then fail

        # [TODO] Let vals be the vector of global initialization values determined by module and externvaln

        # Let moduleinst be a new module instance allocated from module in store S with imports externval and global
        # initializer values, and let S be the extended store produced by module allocation.
        self.allocate(module, extern_value_list, [])

    def allocate(
        self,
        module: binary.Module,
        extern_value_list: typing.List[ExternValue],
        global_values: typing.List[Value],
    ):
        log.debugln('allocate')
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

        # [TODO] For each global in module.globals, do:

        # For each export in module.exports, do:
        for e in module.export_list:
            export_inst = ExportInstance(e.name, e.desc)
            self.module.export_list.append(export_inst)

    def invocate(self, function_addr: FunctionAddress, function_args: typing.List[Value]) -> Result:
        function = self.store.function_list[function_addr]
        log.debugln(f'invocate {function}({function_args})')
        for e, t in zip(function_args, function.type.args.data):
            assert e.type == t
        assert len(function.type.rets.data) < 2

        conf = Configuration(self.store)
        if isinstance(function, WasmFunc):
            local_list = [Value() for _ in function.code.local_list]
            body = binary.Instruction()
            body.opcode = instruction.block
            if len(function.type.rets.data) == 1:
                body.args = [binary.BlockType(function.type.rets.data[0]),  function.code.expr.data]
            else:
                body.args = [binary.BlockType(convention.empty), function.code.expr.data]
            frame = Frame(
                module=function.module,
                local_list=function_args + local_list,
                instruction_list=[body],
                arity=len(function.type.rets.data),
            )
            conf.frame_stack.add(frame)
            return conf.execute()
        else:
            raise Exception(f'pywasm: unknown function type: {type(function)}')
