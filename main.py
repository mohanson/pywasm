import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/binary-leb128/binary-leb128.32.wasm')
# r = runtime.exec('store', [65532, 18446744073709551615])
# print(r)
