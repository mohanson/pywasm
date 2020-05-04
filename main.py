import pywasm

pywasm.on_debug()

limits = pywasm.Limits()
limits.n = 1
limits.m = 0
memory_type = pywasm.binary.MemoryType()
memory_type.limits = limits
memory = pywasm.execution.MemoryInstance( memory_type )

imps = {
    'spectest': {
        'memory': memory,
    }
}

runtime = pywasm.load('./res/spectest/data/data.2.wasm', imps)
# r = runtime.exec('as-if-then', [0, 0])
# print(r)
