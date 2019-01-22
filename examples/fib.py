import pywasm

vm = pywasm.VirtualMachine.open('./examples/fib.wasm')
r = vm.exec('fib', [10])
print(r)
