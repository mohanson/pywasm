import wasmi

path = './tests/data/add.wasm'
path = r"C:\Users\mohan\Downloads\program (3).wasm"

with open(path, 'rb') as f:
    mod = wasmi.Mod.from_reader(f)
vm = wasmi.Vm(mod)
r = vm.exec('foo', [1000])
print(r)
