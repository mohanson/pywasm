import pywasm

pywasm.log.lvl = 1

# a = pywasm.binary.Module.from_reader(open('./examples/fib.wasm', 'rb'))
# for e in a.function_list[0].expr.data:
#     print(e)

# b = pywasm.execution.Machine()
# b.instantiate(a)
# print(b.invocate(0, [pywasm.execution.Value.from_i32(10), pywasm.execution.Value.from_i32(20)]))

# runtime = pywasm.load('./examples/add.wasm')
# r = runtime.exec('add', [10, 20])
# assert r == 30

runtime = pywasm.load('./examples/fib.wasm')
r = runtime.exec('fib', [10])
assert r == 55

# runtime = pywasm.load('./examples/env.wasm')
# r = runtime.exec('fib', [10])
# assert r == 55
