import wasmi
import wasmi.core
import io
import struct
import typing

with open('./data/add.wasm', 'rb') as f:
    mod = wasmi.core.Mod.from_byte(f.read())
vm = wasmi.core.Vm(mod)
r = vm.exec_i(0, [wasmi.stack.Entry.from_i32(2), wasmi.stack.Entry.from_i32(20)])
print(r)
