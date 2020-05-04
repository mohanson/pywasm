import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/br_if/br_if.0.wasm')
print(runtime.machine.store.function_list[0].code.expr)
r = runtime.exec('as-loop-last', [1])
print(r)
