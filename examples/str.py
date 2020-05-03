import pywasm
# pywasm.on_debug()

runtime = pywasm.load('./examples/str.wasm')
r = runtime.exec('get', [])
print(runtime.store.memory_list[0].data[r:r + 12].decode())
