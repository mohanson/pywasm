import wasmi
import io
import struct
import typing

with open('./data/add.wasm', 'rb') as f:
    mod = wasmi.Mod.from_reader(f)
vm = wasmi.Vm(mod)
r = vm.exec_i(0, [15, 20])
print(r)
