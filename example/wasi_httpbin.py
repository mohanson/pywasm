import os
import pywasm
import socket

runtime = pywasm.core.Runtime()

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = 'httpbin.org'
port = 80
client_socket.connect((host, port))
rights = sum([
    pywasm.wasi.Preview1.RIGHTS_FD_READ,
    pywasm.wasi.Preview1.RIGHTS_FD_WRITE,
    pywasm.wasi.Preview1.RIGHTS_SOCK_SHUTDOWN,
])

wasi = pywasm.wasi.Preview1(['wasi_httpbin.wasm'], {}, {})
wasi.fd.append(pywasm.wasi.Preview1.File(
    host_fd=client_socket.fileno(),
    host_flag=os.O_RDWR,
    host_name=client_socket.getsockname(),
    host_status=pywasm.wasi.Preview1.FILE_STATUS_OPENED,
    pipe=None,
    wasm_fd=3,
    wasm_flag=0,
    wasm_name=client_socket.getsockname(),
    wasm_rights_base=rights,
    wasm_rights_root=rights,
    wasm_status=pywasm.wasi.Preview1.FILE_STATUS_OPENED,
    wasm_type=pywasm.wasi.Preview1.FILETYPE_SOCKET_STREAM,
))
wasi.bind(runtime)
wasi.main(runtime, runtime.instance_from_file('example/wasi_httpbin/bin/wasi_httpbin.wasm'))
