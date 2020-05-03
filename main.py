import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/binary/binary.77.wasm')
# r = runtime.exec('store', [65532, 18446744073709551615])
# print(r)
