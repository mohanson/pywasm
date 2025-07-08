import contextlib
import os
import platform
import subprocess
import tarfile
import typing
import urllib.request


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
url = ''
match platform.system().lower():
    case 'darwin':
        url = f'https://github.com/WebAssembly/wabt/releases/download/{version}/wabt-{version}-macos-14.tar.gz'
    case 'linux':
        url = f'https://github.com/WebAssembly/wabt/releases/download/{version}/wabt-{version}-ubuntu-20.04.tar.gz'
    case 'windows':
        url = f'https://github.com/WebAssembly/wabt/releases/download/{version}/wabt-{version}-windows.tar.gz'
    case _:
        assert 0
out = os.path.basename(url)
with cd('res'):
    urllib.request.urlretrieve(url, out)
    with tarfile.open(out, 'r:gz') as tar:
        tar.extractall()
    os.remove(out)
    os.rename(f'wabt-{version}', 'wabt')
