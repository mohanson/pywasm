import pywasm
pywasm.log.lvl = 1

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('./examples/add.wasm')
r = runtime.invocate(m, 'add', [4, 5])
print(f'4 + 5 = {r[0]}')
