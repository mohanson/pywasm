import pywasm
# pywasm.on_debug()

runtime = pywasm.load('./examples/add.wasm')
r = runtime.exec('add', [4, 5])
print(r) # 4 + 5 = 9
