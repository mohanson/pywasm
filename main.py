import wasmi
import io
import struct
import typing

path = './data/add.wasm'
path = '/tmp/start.wasm'

with open(path, 'rb') as f:
    mod = wasmi.Mod.from_reader(f)
# vm = wasmi.Vm(mod)
# r = vm.exec('mul', [40, 2])
# print(r)
