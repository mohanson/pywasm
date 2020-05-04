import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/br_if/br_if.0.wasm')
r = runtime.exec('as-if-then', [0, 0])
print(r)
