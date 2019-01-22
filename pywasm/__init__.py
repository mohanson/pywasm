import typing

from pywasm import convention
from pywasm import execution
from pywasm import log
from pywasm import structure


def on_debug():
    log.lvl = 1


class VirtualMachine:
    def __init__(self, module: structure.Module, imps: typing.Dict = None):
        self.module = module
        self.store = execution.Store()
        self.minst = execution.ModuleInstance()
        imps = {} if imps is None else imps
        externvals = []
        for e in self.module.imports:
            name = f'{e.module}.{e.name}'
            if name not in imps:
                raise Exception(f'pywasm: global import {name} not found')
            externvals.append(imps[name])
        self.minst.instantiate(self.module, self.store, [])

    @classmethod
    def open(cls, name: str):
        return VirtualMachine(structure.Module.open(name))

    def func_addr(self, name: str):
        for e in self.minst.exports:
            if e.name == name and e.value.extern_type == convention.extern_func:
                return e.value.addr
        raise Exception('pywasm: function not found')

    def exec(self, name: str, args: typing.List):
        func_addr = self.func_addr(name)
        func = self.store.funcs[self.minst.funcaddrs[func_addr]]
        for i, e in enumerate(func.functype.args):
            if e in [convention.i32, convention.i64]:
                assert isinstance(args[i], int)
            if e in [convention.f32, convention.f64]:
                assert isinstance(args[i], float)
            args[i] = execution.Value(e, args[i])
        stack = execution.Stack()
        for e in args:
            stack.add(e)
        frame = execution.Frame(self.minst, args, len(func.functype.rets), -1)
        log.debugln(f'Running function {name}({", ".join([str(e) for e in args])}):')
        r = execution.call(self.minst, func_addr, self.store, stack)
        if r:
            return r[0]
        return None
