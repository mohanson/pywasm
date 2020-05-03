import pywasm

runtime = pywasm.load('./examples/fib.wasm')
r = runtime.exec('fib', [10])
print(r)
