import typing

from . import binary
from . import convention
from . import instruction
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
        self.function_type = function_type
        self.module = module
        self.code = code


class HostFunc:
    # A host function is a function expressed outside WebAssembly but passed to a module as an import. The definition
    # and behavior of host functions are outside the scope of this specification. For the purpose of this
    # specification, it is assumed that when invoked, a host function behaves non-deterministically, but within certain
    # constraints that ensure the integrity of the runtime.
    def __init__(self, function_type: binary.FunctionType, hostcode: typing.Callable):
        self.function_type = function_type
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
        if len(self.data) // convention.memory_page_size + n > self.size:
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
    def __init__(self):
        self.arity: int = 0x00
        self.instr: typing.List[binary.Instruction] = []


class Frame:
    def __init__(self, module: ModuleInstance, local_list: typing.List[Value]):
        self.module = module
        self.local_list = local_list


class Activation:
    # Activation frames carry the return arity of the respective function, hold the values of its locals (including
    # arguments) in the order corresponding to their static local indices, and a reference to the function’s own module
    # instance:
    #
    # activation ::= framen{frame}
    # frame ::= {locals val∗, module moduleinst}
    def __init__(self, frame: Frame):
        self.frame = frame


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
        self.data: typing.List[typing.Union[Value, Label, Activation]] = []

    def pop(self):
        return self.data.pop()

    def add(self, v: typing.Union[Value, Label, Activation]):
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


class Machine:
    # Execution behavior is defined in terms of an abstract machine that models the program state. It includes a stack,
    # which records operand values and control constructs, and an abstract store containing global state.
    def __init__(self):
        self.module: ModuleInstance = ModuleInstance()
        self.stack: Stack = Stack()
        self.store: Store = Store()

    def instantiate(self, module: binary.Module, imps: typing.Dict[str, typing.Dict[str, typing.Any]] = None):
        self.module.type_list = module.type_list
        imps = imps if imps else {}
        for e in module.import_list:
            if e.module not in imps or e.name not in imps[e.module]:
                raise Exception(f'pywasm: missing import {e.module}.{e.name}')
            if isinstance(e.desc, binary.TypeIndex):
                a = HostFunc(self.module.type_list[e.desc], imps[e.module][e.name])
                addr = self.store.allocate_host_function(a)
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
        # self.allocate(module, extern_value_list, [])

    def allocate(
        self,
        module: binary.Module,
        extern_value_list: typing.List[ExternValue],
        global_values: typing.List[Value],
    ):
        # Imports
        # self.funcaddrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_func])
        # self.tableaddrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_table])
        # self.memaddrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_mem])
        # self.globaladdrs.extend([e.addr for e in externvals if e.extern_type == convention.extern_global])

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
        for i, e in enumerate(module.export_list):
            export_inst = ExportInstance(e.name, e.desc)
            self.module.export_list.append(export_inst)

    def invocate(self):
        pass
