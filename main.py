import pywasm

a = pywasm.Module.from_reader(open('./examples/add.wasm', 'rb'))
print(a)
