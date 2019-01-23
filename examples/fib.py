import pywasm

vm = pywasm.load('./examples/fib.wasm')
r = vm.exec('fib', [10])
print(r)
