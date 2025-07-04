import contextlib
import glob
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
    if not os.path.exists('spec'):
        call('git clone https://github.com/WebAssembly/spec')
with cd('res/spec'):
    call('git checkout main')
    call('git pull origin main')
    # When update spectest, we can increase the commit id in small steps.
    # Use: git log --reverse 1041527d508218acc40f0278d4abc3be9ba5e3bd.. -- test/core
    call('git checkout 1041527d508218acc40f0278d4abc3be9ba5e3bd')
with cd('res/spec/test/core'):
    for e in sorted(glob.glob('*.wast')):
        call(f'wast2json {e}')
