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
        self.funs = []
        self.tables = []
        self.mems = []
        self.globals = []


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
        pass


class FunctionInstance:
    # A function instance is the runtime representation of a function. It effectively is a closure of the original
    # function over the runtime module instance of its originating module. The module instance is used to resolve
    # references to other definitions during execution of the function.
    #
    # funcinst ::= {type functype,module moduleinst,code func}
    #            | {type functype,hostcode hostfunc}
    # hostfunc ::= ...
    def __init__(self):
        pass


class HostFunc:
    # A host function is a function expressed outside WebAssembly but passed to a module as an import. The definition
    # and behavior of host functions are outside the scope of this specification. For the purpose of this
    # specification, it is assumed that when invoked, a host function behaves non-deterministically, but within certain
    # constraints that ensure the integrity of the runtime.
    def __init__(self):
        pass


class TableInstance:
    # A table instance is the runtime representation of a table. It holds a vector of function elements and an optional
    # maximum size, if one was specified in the table type at the table’s definition site.
    #
    # Each function element is either empty, representing an uninitialized table entry, or a function address. Function
    # elements can be mutated through the execution of an element segment or by external means provided by the embedder.
    #
    # tableinst ::= {elem vec(funcelem),max u32?}
    # funcelem ::= funcaddr?
    #
    # It is an invariant of the semantics that the length of the element vector never exceeds the maximum size, if
    # present.
    def __init__(self):
        pass


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
    pass


class GlobalInstance:
    # A global instance is the runtime representation of a global variable. It holds an individual value and a flag
    # indicating whether it is mutable.
    #
    # globalinst ::= {value val, mut mut}
    #
    # The value of mutable globals can be mutated through variable instructions or by external means provided by the
    # embedder.
    pass


class ExportInstance:
    # An export instance is the runtime representation of an export. It defines the export’s name and the associated
    # external value.
    #
    # exportinst ::= {name name, value externval}
    pass


class ExternalValue:
    # An external value is the runtime representation of an entity that can be imported or exported. It is an address
    # denoting either a function instance, table instance, memory instance, or global instances in the shared store.
    #
    # externval ::= func funcaddr
    #             | table tableaddr
    #             | mem memaddr
    #             | global globaladdr
    pass


class Value:
    # Values are represented by themselves.
    pass


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
    pass


class Stack:
    # Besides the store, most instructions interact with an implicit stack. The stack contains three kinds of entries:
    #
    # Values: the operands of instructions.
    # Labels: active structured control instructions that can be targeted by branches.
    # Activations: the call frames of active function calls.
    #
    # These entries can occur on the stack in any order during the execution of a program. Stack entries are described
    # by abstract syntax as follows.
    #
    pass


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


class AbstractMachine:
    def __init__(self):
        self.stack = None
        self.store = None
