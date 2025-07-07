import pywasm

runtime = pywasm.core.Runtime()
wasi = pywasm.wasi.Preview1(['wasi_ll.wasm'], {
    # This object represents the WebAssembly application's local directory structure. The string keys of dirs are
    # treated as directories within the file system. The corresponding values in preopens are the real paths to those
    # directories on the host machine.
    'pywasm': 'pywasm',
}, {})
wasi.bind(runtime)
wasi.main(runtime, runtime.instance_from_file('example/wasi_ll/bin/wasi_ll.wasm'))
