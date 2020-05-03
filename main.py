import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/align/align.106.wasm')
r = runtime.exec('i32_align_switch', [0, 0])
print(r)
