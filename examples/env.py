import pywasm
pywasm.on_debug()


def fib(n):
    if n <= 1:
        return n
    return fib(n - 1) + fib(n - 2)


vm = pywasm.load('./examples/env.wasm', {'env.fib': fib})
r = vm.exec('get', [10])
print(r) # 55
