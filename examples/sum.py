import pywasm
# pywasm.on_debug()

runtime = pywasm.load('./examples/sum.wasm')
r = runtime.exec('sum', [100])
print(r) # 1 + 2 + ... + 99 = 4950
