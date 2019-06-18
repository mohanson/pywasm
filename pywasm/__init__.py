import typing

from pywasm import convention
from pywasm import execution
from pywasm import log
from pywasm import structure


class Runtime:
    # A webassembly runtime manages Store, stack, and other runtime structure. They forming the WebAssembly abstract.

    def __init__(self, module: structure.Module, imps: typing.Dict = None):
        self.module = module
        self.module_instance = execution.ModuleInstance()
        self.store = execution.Store()

        imps = imps if imps else {}
        externvals = []
        for e in self.module.imports:
            if e.module not in imps or e.name not in imps[e.module]:
                raise Exception(f'pywasm: global import {e.module}.{e.name} not found')
            if e.kind == convention.extern_func:
                a = execution.HostFunc(self.module.types[e.desc], imps[e.module][e.name])
                self.store.funcs.append(a)
                externvals.append(execution.ExternValue(e.kind, len(self.store.funcs) - 1))
                continue
            if e.kind == convention.extern_table:
                a = imps[e.module][e.name]
                self.store.tables.append(a)
                externvals.append(execution.ExternValue(e.kind, len(self.store.tables) - 1))
                continue
            if e.kind == convention.extern_mem:
                a = imps[e.module][e.name]
                self.store.mems.append(a)
                externvals.append(execution.ExternValue(e.kind, len(self.store.mems) - 1))
                continue
            if e.kind == convention.extern_global:
                a = execution.GlobalInstance(execution.Value(e.desc.valtype, imps[e.module][e.name]), e.desc.mut)
                self.store.globals.append(a)
                externvals.append(execution.ExternValue(e.kind, len(self.store.globals) - 1))
                continue
        self.module_instance.instantiate(self.module, self.store, externvals)

    def func_addr(self, name: str):
        # Get a function address denoted by the function name
        for e in self.module_instance.exports:
            if e.name == name and e.value.extern_type == convention.extern_func:
                return e.value.addr
        raise Exception('pywasm: function not found')

    def exec(self, name: str, args: typing.List):
        # Invoke a function denoted by the function address with the provided arguments.
        func_addr = self.func_addr(name)
        func = self.store.funcs[self.module_instance.funcaddrs[func_addr]]
        # Mapping check for Python valtype to WebAssembly valtype
        for i, e in enumerate(func.functype.args):
            if e in [convention.i32, convention.i64]:
                assert isinstance(args[i], int)
            if e in [convention.f32, convention.f64]:
                assert isinstance(args[i], float)
            args[i] = execution.Value(e, args[i])
        stack = execution.Stack()
        stack.ext(args)
        log.debugln(f'Running function {name}({", ".join([str(e) for e in args])}):')
        r = execution.call(self.module_instance, func_addr, self.store, stack)
        if r:
            return r[0].n
        return None


# Using the pywasm API.
# If you have already compiled a module from another language using tools like Emscripten, or loaded and run the code
# by Javascript yourself, the pywasm API is easy to learn.

def on_debug():
    log.lvl = 1


def load(name: str, imps: typing.Dict = None) -> Runtime:
    # Generate a runtime directly by loading a file from disk.
    with open(name, 'rb') as f:
        module = structure.Module.from_reader(f)
        return Runtime(module, imps)


Ctx = execution.Ctx
Memory = execution.MemoryInstance
Value = execution.Value
Table = execution.TableInstance
Limits = structure.Limits
