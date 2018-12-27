import wasmi

path = './test/data/add.wasm'

mod = wasmi.Mod.from_reader(open(path, 'rb'))
vm = wasmi.Vm(mod)
r = vm.exec('add', [40, 2])
print(r)
