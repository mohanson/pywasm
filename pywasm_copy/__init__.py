import typing

from . import binary
from . import convention
from . import execution
from . import instruction
from . import leb128
from . import log
from . import num


class Runtime:
    # A webassembly runtime manages Store, stack, and other runtime structure. They forming the WebAssembly abstract.

    def __init__(self, module: binary.Module, imps: typing.Dict = None):
        self.machine = execution.Machine()

        imps = imps if imps else {}
        extern_value_list: typing.List[execution.ExternValue] = []
        for e in module.import_list:
            if e.module not in imps or e.name not in imps[e.module]:
                raise Exception(f'pywasm: missing import {e.module}.{e.name}')
            if isinstance(e.desc, binary.TypeIndex):
                a = execution.HostFunc(module.type_list[e.desc], imps[e.module][e.name])
                addr = self.machine.store.allocate_host_function(a)
                extern_value_list.append(addr)
                continue
            if isinstance(e.desc, binary.TableType):
                raise NotImplementedError
            if isinstance(e.desc, binary.MemoryType):
                raise NotImplementedError
            if isinstance(e.desc, binary.GlobalType):
                raise NotImplementedError

        self.machine.instantiate(module, extern_value_list)

    def func_addr(self, name: str) -> execution.FunctionAddress:
        # Get a function address denoted by the function name
        for e in self.machine.module.export_list:
            if e.name == name and isinstance(e.value, execution.FunctionAddress):
                return e.value
        raise Exception('pywasm: function not found')

    def exec(self, name: str, args: typing.List[typing.Union[int, float]]) -> execution.Result:
        # Invoke a function denoted by the function address with the provided arguments.
        func_addr = self.func_addr(name)
        func = self.machine.store.function_list[func_addr]
        func_args = []
        # Mapping check for python valtype to webAssembly valtype
        for i, e in enumerate(func.type.args.data):
            v = {
                convention.i32: execution.Value.from_i32,
                convention.i64: execution.Value.from_i64,
                convention.f32: execution.Value.from_f32,
                convention.f64: execution.Value.from_f64,
            }[e](args[i])
            func_args.append(v)
        return self.machine.invocate(func_addr, func_args).data[0].val()


# Using the pywasm API.
# If you have already compiled a module from another language using tools like Emscripten, or loaded and run the code
# by Javascript yourself, the pywasm API is easy to learn.

def on_debug():
    log.lvl = 1

def load(name: str, imps: typing.Dict = None) -> Runtime:
    # Generate a runtime directly by loading a file from disk.
    with open(name, 'rb') as f:
        module = binary.Module.from_reader(f)
        return Runtime(module, imps)


Memory = execution.MemoryInstance
Value = execution.Value
Table = execution.TableInstance
Global = execution.GlobalInstance
Limits = binary.Limits