import pywasm
import time

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('example/blake2b_iter/bin/blake2b_iter.wasm')

tic = time.time()
print('main: benchmarks ...')
r = runtime.invocate(m, 'blake2b_iter', [2048])
assert r[0] == 129
end = time.time()
print('main: benchmarks end', end - tic)
