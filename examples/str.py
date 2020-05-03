import pywasm
pywasm.on_debug()

runtime = pywasm.load('./examples/str.wasm')
r = runtime.exec('get', [])
print(runtime.machine.store.mems[0].data[r:r + 12])
