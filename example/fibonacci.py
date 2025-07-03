import pywasm
pywasm.log.lvl = 1

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('example/fibonacci/bin/fibonacci.wasm')
r = runtime.invocate(m, 'fibonacci', [10])
print(f'fibonacci(10) = {r[0]}')
