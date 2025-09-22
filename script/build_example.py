import contextlib
import os
import shutil
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


root = os.path.dirname(os.path.dirname(__file__))
os.chdir(root)

for name in os.listdir('example'):
    if not os.path.isdir(f'example/{name}'):
        continue
    if os.path.exists(f'example/{name}/bin/{name}.wasm'):
        continue
    with cd(f'example/{name}'):
        if not os.path.exists('bin'):
            os.mkdir('bin')
        call('cargo build --release')
        if os.path.exists('target/wasm32-unknown-unknown'):
            shutil.copy(f'target/wasm32-unknown-unknown/release/{name}.wasm', 'bin')
        if os.path.exists('target/wasm32-wasip1'):
            shutil.copy(f'target/wasm32-wasip1/release/{name}.wasm', 'bin')
        call(f'{root}/res/wabt/bin/wasm2wat -o bin/{name}.wat bin/{name}.wasm')
