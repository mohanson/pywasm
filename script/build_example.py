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
    if os.path.exists(f'example/{name}/bin/{name}.wasm'):
        continue
    with cd(f'example/{name}'):
        if not os.path.exists('bin'):
            call('mkdir bin')
        call('cargo build --release')
        if os.path.exists('target/wasm32-unknown-unknown'):
            call(f'cp target/wasm32-unknown-unknown/release/{name}.wasm bin')
        if os.path.exists('target/wasm32-wasip1'):
            call(f'cp target/wasm32-wasip1/release/{name}.wasm bin')
        call(f'wasm2wat -o bin/{name}.wat bin/{name}.wasm')
