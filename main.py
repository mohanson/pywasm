import wasmi

path = './tests/data/add.wasm'

with open(path, 'rb') as f:
    mod = wasmi.Mod.from_reader(f)
vm = wasmi.Vm(mod)
r = vm.exec('add', [40, 2])
print(r)


# import wasmi.stack
# import wasmi.common
# print(wasmi.common.rotl_u32(58, 400000000000))
