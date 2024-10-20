import typing

from . import core
from . import convention
from . import execution
from . import leb128
from . import log
from . import opcode
from . import option
from . import validation


class Runtime:
    # A webassembly runtime manages Store, stack, and other runtime structure. They forming the WebAssembly abstract.

    def __init__(self, module: core.Module, imps: typing.Dict = None, opts: typing.Optional[option.Option] = None):
        self.machine = execution.Machine()
        self.machine.opts = opts or option.Option()

        # For compatibility with older 0.4.x versions
        self.store = self.machine.store

        imps = imps if imps else {}
        extern_value_list: typing.List[execution.ExternValue] = []
        for e in module.import_list:
            if e.module not in imps or e.name not in imps[e.module]:
                raise Exception(f'pywasm: missing import {e.module}.{e.name}')
            if e.type == 0x00:
                a = execution.HostFunc(module.type_list[e.desc], imps[e.module][e.name])
                addr = self.machine.store.allocate_host_function(a)
                extern_value_list.append(addr)
                continue
            if e.type == 0x01:
                addr = execution.TableAddress(len(self.store.table_list))
                table = imps[e.module][e.name]
                self.store.table_list.append(table)
                extern_value_list.append(addr)
                continue
            if e.type == 0x02:
                addr = execution.MemoryAddress(len(self.store.memory_list))
                memory = imps[e.module][e.name]
                if self.machine.opts.pages_limit > 0 and e.desc.limits.n > self.machine.opts.pages_limit:
                    raise Exception('pywasm: out of memory limit')
                memory.grow(e.desc.limits.n)
                self.store.memory_list.append(memory)
                extern_value_list.append(addr)
                continue
            if e.type == 0x03:
                addr = self.store.allocate_global(
                    e.desc,
                    execution.Val.from_auto(e.desc.type, imps[e.module][e.name])
                )
                extern_value_list.append(addr)
                continue

        self.machine.instantiate(module, extern_value_list)

    def func_addr(self, name: str) -> execution.FunctionAddress:
        # Get a function address denoted by the function name
        for e in self.machine.module.export_list:
            if e.name == name and isinstance(e.value, execution.FunctionAddress):
                return e.value
        raise Exception('pywasm: function not found')

    def exec_accu(self, name: str, args: typing.List[execution.Val]) -> execution.Result:
        # Invoke a function denoted by the function address with the provided arguments.
        func_addr = self.func_addr(name)
        return self.machine.invocate(func_addr, args)

    def exec(self, name: str, args: typing.List[typing.Union[int, float]]) -> execution.Result:
        func_addr = self.func_addr(name)
        func = self.machine.store.function_list[func_addr]
        func_args = []
        # Mapping check for python valtype to webAssembly valtype
        for i, e in enumerate(func.type.args.data):
            v = execution.Val.from_auto(e, args[i])
            func_args.append(v)
        resp = self.exec_accu(name, func_args)
        if len(resp.data) == 0:
            return None
        if len(resp.data) == 1:
            return resp.data[0].into_auto()
        return [e.into_auto() for e in resp.data]


# Using the pywasm API.
# If you have already compiled a module from another language using tools like Emscripten, or loaded and run the code
# by Javascript yourself, the pywasm API is easy to learn.

def on_debug():
    log.lvl = 1


def load(name: str, imps: typing.Dict = None, opts: typing.Optional[option.Option] = None) -> Runtime:
    # Generate a runtime directly by loading a file from disk.
    with open(name, 'rb') as f:
        module = core.Module.from_reader(f)
        return Runtime(module, imps, opts)


Store = execution.Store
Memory = execution.MemoryInstance
Val = execution.Val
Table = execution.TableInstance
Global = execution.GlobalInstance
Limits = core.Limits
FunctionAddress = execution.FunctionAddress
TableAddress = execution.TableAddress
MemoryAddress = execution.MemoryAddress
GlobalAddress = execution.GlobalAddress
Option = option.Option

# For compatibility with older 0.4.x versions
Ctx = Store
