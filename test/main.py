import subprocess


def call(cmd: str) -> subprocess.CompletedProcess[bytes]:
    print(f'$ {cmd}')
    return subprocess.run(cmd, shell=True, check=True)


call('python -m pywasm --func pi --func-args 7 example/pi/bin/pi.wasm')
call('python -m pywasm --wasi preview1 --wasi-dirs pywasm:pywasm example/wasi_ll/bin/wasi_ll.wasm')
