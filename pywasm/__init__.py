import typing

from pywasm import convention
from pywasm import execution
from pywasm import log
from pywasm import structure


def on_debug():
    log.lvl = 1


class AbstractMachine:
    def __init__(self, module: structure.Module, imps: typing.Dict):
        self.module = module
        self.store = execution.Store()
        _ = imps
        self.minst = execution.ModuleInstance()
        self.minst.instantiate(self.module, self.store, [])

    def glob_func(self, name: str):
        for e in self.minst.exports:
            if e.name == name and e.value.extern_type == convention.extern_func:
                return self.store.funcs[e.value.addr]
        return None

    def exec(self, name: str, args: typing.List[execution.Value]):
        func = self.glob_func(name)
        if not func:
            log.panicln('pywasm: function not found')
        assert isinstance(func, execution.WasmFunc)
        stack = execution.Stack()
        frame = execution.Frame(self.minst, args)
        stack.add(frame)
        r = execution.invoke(self.minst, self.store, stack, func.code.expr, func.functype.rets)
        assert isinstance(stack.pop(), execution.Frame)
        return r
