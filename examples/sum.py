import pywasm
pywasm.on_debug()

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('./examples/sum.wasm', {})
r = runtime.invocate(m, 'sum', [100])
print(f'1 + 2 + ... + 99 = {r[0]}')
