import pywasm
pywasm.on_debug()

vm = pywasm.load('./examples/str.wasm')
r = vm.exec('get', [])
print(vm.store.mems[0].data[r:r + 12])
