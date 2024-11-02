import pywasm
pywasm.log.lvl = 1

runtime = pywasm.core.Runtime()
mod = runtime.instance_from_file('./examples/str.wasm')
ptr = runtime.invocate(mod, 'get', [])[0]
mem = runtime.exported_memory(mod, 'memory')
print(mem.data[ptr:ptr+12].decode())
