import pywasm

pywasm.log.lvl = 1

a = pywasm.Module.from_reader(open('./examples/add.wasm', 'rb'))
print(a)
