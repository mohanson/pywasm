import pywasm

vm = pywasm.load('./examples/sum.wasm')
r = vm.exec('sum', [100])
print(r) # 1 + 2 + ... + 99 = 4950
