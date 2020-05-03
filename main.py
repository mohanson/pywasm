import pywasm

pywasm.log.lvl = 1


runtime = pywasm.load('./res/spectest/align/align.106.wasm')
r = runtime.exec('f32_align_switch', [0])
print(r)
