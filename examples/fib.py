import pywasm
pywasm.log.lvl = 1

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('./examples/fib.wasm')
r = runtime.invocate(m, 'fib', [10])
print(f'fib(10) = {r[0]}')
