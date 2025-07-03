import pywasm

runtime = pywasm.core.Runtime()
wasi = pywasm.wasi.Preview1(['wasi_print.wasm'], {})
wasi.bind(runtime)
wasi.main(runtime, runtime.instance_from_file('example/wasi_print/bin/wasi_print.wasm'))
