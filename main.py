import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/binary/binary.83.wasm')
# r = runtime.exec('store', [65532, 18446744073709551615])
# print(r)
