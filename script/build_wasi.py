import contextlib
import os
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


with cd('res'):
    if not os.path.exists('wasi-testsuite'):
        call('git clone --branch prod/testsuite-base https://github.com/WebAssembly/wasi-testsuite')
with cd('res/wasi-testsuite'):
    call('git checkout prod/testsuite-base')
    call('git pull origin prod/testsuite-base')
