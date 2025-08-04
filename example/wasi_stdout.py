import io
import pywasm

runtime = pywasm.core.Runtime()
wasi = pywasm.wasi.Preview1(['wasi_stdout.wasm'], {}, {})
# By setting the pipe to io.BytesIO(bytearray()) to capture output or provide input.
wasi.fd[1].pipe = io.BytesIO(bytearray())
wasi.bind(runtime)
wasi.main(runtime, runtime.instance_from_file('example/wasi_stdout/bin/wasi_stdout.wasm'))
wasi.fd[1].pipe.seek(0)
assert wasi.fd[1].pipe.read() == b'Hello World!\n'
