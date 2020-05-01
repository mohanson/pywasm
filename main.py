import pywasm

pywasm.log.lvl = 1

# a = pywasm.binary.Module.from_reader(open('./examples/add.wasm', 'rb'))
# b = pywasm.execution.Machine()
# b.instantiate(a)
# print(b.invocate(0, [pywasm.execution.Value.from_i32(10), pywasm.execution.Value.from_i32(20)]))

runtime = pywasm.load('./examples/add.wasm')
r = runtime.exec('add', [1, 2])
print(r)
