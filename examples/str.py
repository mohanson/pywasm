import pywasm
pywasm.on_debug()

runtime = pywasm.core.Runtime()
mod = runtime.instance_from_file('./examples/str.wasm', {})
ptr = runtime.invocate(mod, 'get', [])[0]
mem = runtime.exported_mem(mod, 'memory')
print(mem.data[ptr:ptr+12].decode())
