import pywasm

runtime = pywasm.core.Runtime()
wasi = pywasm.wasi.Preview1(['wasi_zen.wasm'], {}, {})
wasi.bind(runtime)
wasi.main(runtime, runtime.instance_from_file('example/wasi_zen/bin/wasi_zen.wasm'))
