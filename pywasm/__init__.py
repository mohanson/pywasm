import typing

from pywasm import convention
from pywasm import execution
from pywasm import log
from pywasm import structure


def on_debug():
    log.lvl = 1


class AbstractMachine:
    def __init__(self, module: structure.Module, imps: typing.Dict = None):
        self.module = module
        self.store = execution.Store()
        self.minst = execution.ModuleInstance()
        imps = {} if imps is None else imps
        externvals = []
        for e in self.module.imports:
            name = f'{e.module}.{e.name}'
            if name not in imps:
                log.panicln(f'pywasm: global import {name} not found')
            externvals.append(imps[name])
        self.minst.instantiate(self.module, self.store, [])

    @classmethod
    def open(cls, name: str):
        return AbstractMachine(structure.Module.open(name))

    def glob_func(self, name: str):
        for e in self.minst.exports:
            if e.name == name and e.value.extern_type == convention.extern_func:
                return self.store.funcs[e.value.addr]
        return None

    def exec(self, name: str, args: typing.List):
        func = self.glob_func(name)
        if not func:
            log.panicln('pywasm: function not found')
        assert isinstance(func, execution.WasmFunc)
        for i, e in enumerate(func.functype.args):
            if e in [convention.i32, convention.i64]:
                assert isinstance(args[i], int)
            if e in [convention.f32, convention.f64]:
                assert isinstance(args[i], float)
            args[i] = execution.Value(e, args[i])
        stack = execution.Stack()
        frame = execution.Frame(self.minst, args, len(func.functype.rets), -1)
        log.debugln(f'Running function {name}({", ".join([str(e) for e in args])}):')
        return execution.invoke(self.store, frame, stack, func.code.expr)
