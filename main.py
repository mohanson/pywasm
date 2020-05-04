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

    limits = pywasm.Limits()
    limits.n = 10
    limits.m = 20
    table = pywasm.Table(pywasm.execution.FunctionAddress,  limits)


    return {
        'spectest': {
            'print_i32': lambda _: None,
            'global_i32': 666,
            'memory': memory,
            'table': table,
        },
        'module1': {
            'shared-table': table,
        }
    }

runtime = pywasm.load('./res/spectest/elem/elem.38.wasm', imps())

# r = runtime.exec('call-7', [])
# print(r)

print(runtime.machine.module.export_list)
