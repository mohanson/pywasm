import pywasm
pywasm.log.lvl = 1


def fib(m: pywasm.core.Machine, n: int):
    if n <= 1:
        return n
    return fib(m, n - 1) + fib(m, n - 2)


runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('./examples/env.wasm', {'env': {'fib': fib}})
r = runtime.invocate(m, 'get', [10])
print(f'fib(10) = {r[0]}')
