import contextlib
import os
import pathlib
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


for name in [p.name for p in pathlib.Path('example').iterdir() if p.is_dir()]:
    with cd(f'example/{name}'):
        call('cargo build --release')
        call(f'cp target/wasm32-unknown-unknown/release/{name}.wasm bin')
        call(f'wasm2wat -o bin/{name}.wat bin/{name}.wasm')
