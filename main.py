import typing

import pywasm

pywasm.on_debug()

def imps() -> typing.Dict:
    limits = pywasm.Limits()
    limits.n = 1
    limits.m = 0
    memory_type = pywasm.binary.MemoryType()
    memory_type.limits = limits
    memory = pywasm.execution.MemoryInstance(memory_type)

    return {
        'spectest': {
            'print_i32': lambda _: None,
            'global_i32': 666,
            'memory': memory,
        }
    }

runtime = pywasm.load('./res/spectest/data/data.13.wasm', imps())
# r = runtime.exec('as-if-then', [0, 0])
# print(r)
