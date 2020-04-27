import typing

from . import convention
from . import instruction
from . import num
from . import structure


class Value:
    # Values are represented by themselves.
    def __init__(self):
        self.type: structure.ValueType = structure.ValueType()
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
        return num.LittleEndian.i32(self.data[0:4])

    def i64(self) -> num.i64:
        return num.LittleEndian.i64(self.data[0:8])

    def f32(self) -> num.f32:
        return num.LittleEndian.f32(self.data[0:4])

    def f64(self) -> num.f64:
        return num.LittleEndian.f64(self.data[0:8])

    @classmethod
    def from_i32(cls, n: num.i32):
        o = Value()
        o.type = structure.ValueType(convention.i32)
        o.data[0:4] = num.LittleEndian.pack_i32(n)
        return o

    @classmethod
    def from_i64(cls, n: num.i64):
        o = Value()
        o.type = structure.ValueType(convention.i64)
        o.data[0:8] = num.LittleEndian.pack_i64(n)
        return o

    @classmethod
    def from_f32(cls, n: num.f32):
        o = Value()
        o.type = structure.ValueType(convention.f32)
        o.data[0:4] = num.LittleEndian.pack_f32(n)
        return o

    @classmethod
    def from_f64(cls, n: num.f64):
        o = Value()
        o.type = structure.ValueType(convention.f64)
        o.data[0:8] = num.LittleEndian.pack_f64(n)
        return o


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
        self.type_list: typing.List[structure.FunctionType] = []
        self.function_addr_list: typing.List[int] = []
        self.table_addr_list: typing.List[int] = []
        self.memory_addr_list: typing.List[int] = []
        self.global_addr_list: typing.List[int] = []
        self.export_list: typing.List[ExportInstance] = []


class Function:
    # The funcs component of a module defines a vector of functions with the following structure:
    #
    # func ::= {type typeidx, locals vec(valtype), body expr}
    #
    # The type of a function declares its signature by reference to a type defined in the module. The parameters of the
    # function are referenced through 0-based local indices in the function’s body; they are mutable.
    #
    # The locals declare a vector of mutable local variables and their types. These variables are referenced through
    # local indices in the function’s body. The index of the first local is the smallest index not referencing a
    # parameter.
    #
    # The body is an instruction sequence that upon termination must produce a stack matching the function type’s
    # result type.
    #
    # Functions are referenced through function indices, starting with the smallest index not referencing
    # a function import.
    def __init__(self):
        self.type_idx: int = 0x00
        self.local_list: typing.List[structure.ValueType] = []
        self.body: structure.Expression = structure.Expression()


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
    def __init__(self, function_type: structure.FunctionType, module: ModuleInstance, code: Function):
        self.function_type = function_type
        self.module = module
        self.code = code


class HostFunc(FunctionInstance):
    # A host function is a function expressed outside WebAssembly but passed to a module as an import. The definition
    # and behavior of host functions are outside the scope of this specification. For the purpose of this
    # specification, it is assumed that when invoked, a host function behaves non-deterministically, but within certain
    # constraints that ensure the integrity of the runtime.
    def __init__(self, function_type: structure.FunctionType, hostcode: typing.Callable):
        self.function_type = function_type
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
    def __init__(self, element_type: int, size: int):
        self.element_type = element_type
        self.element_list = [0x00 for _ in range(size)]
        self.size = size


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
    def __init__(self, value: Value, mut: int):
        self.value = value
        self.mut = mut


class ExternValue:
    # An external value is the runtime representation of an entity that can be imported or exported. It is an address
    # denoting either a function instance, table instance, memory instance, or global instances in the shared store.
    #
    # externval ::= func funcaddr
    #             | table tableaddr
    #             | mem memaddr
    #             | global globaladdr
    def __init__(self, extern_type: int, addr: int):
        self.type = extern_type
        self.addr = addr


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
        self.instr: typing.List[instruction.Instruction] = []


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


class AdministrativeInstructions:
    pass


class AbstractMachine:

    def __init__(self):
        pass

    def instantiate(self, module: structure.Module):
        pass
