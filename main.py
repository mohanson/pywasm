import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/br_if/br_if.0.wasm')
# r = runtime.exec('store', [65532, 18446744073709551615])
# print(r)
