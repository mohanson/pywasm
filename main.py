import pywasm

pywasm.log.lvl = 1

a = pywasm.binary.Module.from_reader(open('./examples/add.wasm', 'rb'))

# print(a.section_list[0].data[0].args.data[0] == pywasm.convention.i32)
