import contextlib
import glob
import io
import json
import os
import pywasm
import subprocess
import typing


def call(cmd: str) -> subprocess.CompletedProcess[bytes]:
    print(f'$ {cmd}')
    return subprocess.run(cmd, shell=True, check=True)


@contextlib.contextmanager
def cd(dst: str) -> typing.Generator[None, typing.Any, None]:
    cwd = os.getcwd()
    os.chdir(dst)
    yield
    os.chdir(cwd)


case = sorted(glob.glob('res/wasi-testsuite/tests/assemblyscript/testsuite/*.wasm'))
for wasm_path in case:
    print(wasm_path)
    name = os.path.splitext(os.path.basename(wasm_path))[0]
    conf_path = wasm_path[:-5] + '.json'
    conf = {}
    if os.path.exists(conf_path):
        with open(conf_path) as f:
            conf = json.load(f)
    runtime = pywasm.core.Runtime()
    wasi = pywasm.wasi.Preview1([f'{name}.wasm'] + conf.get('args', []), conf.get('env', {}))
    wasi.fd[1] = io.BytesIO(bytearray())
    wasi.bind(runtime)
    exit = wasi.main(runtime, runtime.instance_from_file(wasm_path))
    wasi.fd[1].seek(0)
    assert wasi.fd[1].read().decode() == conf.get('stdout', '')
    assert exit == conf.get('exit_code', 0)
