import pywasm
pywasm.on_debug()

vm = pywasm.load('./examples/add.wasm')
r = vm.exec('add', [4, 5])
print(r) # 4 + 5 = 9
