import pywasm
pywasm.on_debug()


def _fib(n):
    if n <= 1:
        return n
    return _fib(n - 1) + _fib(n - 2)


def fib(_: pywasm.Ctx, n: int):
    return _fib(n)


vm = pywasm.load('./examples/env.wasm', {'env': {'fib': fib}})
r = vm.exec('get', [10])
print(r)  # 55
