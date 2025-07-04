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


version = '1.0.37'
with cd('res'):
    call(f'wget https://github.com/WebAssembly/wabt/releases/download/{version}/wabt-{version}-ubuntu-20.04.tar.gz')
    call(f'tar -zxvf wabt-{version}-ubuntu-20.04.tar.gz')
    call(f'rm -rf wabt-{version}-ubuntu-20.04.tar.gz')
    call(f'mv wabt-{version} wabt')
