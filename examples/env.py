import pywasm
import typing
pywasm.log.lvl = 1


def fib_host(n: int) -> int:
    if n <= 1:
        return n
    return fib_host(n - 1) + fib_host(n - 2)


def fib_wasm(_: pywasm.core.ModuleInst, args: typing.List[int]) -> typing.List[int]:
    return [fib_host(args[0])]


runtime = pywasm.core.Runtime()
runtime.imports['env'] = {}
runtime.imports['env']['fib'] = runtime.allocate_func_host(
    pywasm.core.FuncType([pywasm.core.ValType.i32()], [pywasm.core.ValType.i32()]),
    fib_wasm,
)
m = runtime.instance_from_file('./examples/env.wasm')
r = runtime.invocate(m, 'get', [10])
print(f'fib(10) = {r[0]}')
