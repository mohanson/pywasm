import os
import sys

sys.path.append(os.getcwd())
import wasmi

name = sys.argv[1]
path = os.path.join('examples', f'{name}.wasm')
mod = wasmi.Mod.from_reader(open(path, 'rb'))
wvm = wasmi.Vm(mod)
r = wvm.exec(name, [int(i) for i in sys.argv[2:]])
print(r)
