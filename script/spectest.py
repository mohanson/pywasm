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
    call('rm -rf spec')
    call('rm -rf spectest')
    call('git clone https://github.com/WebAssembly/spec')
with cd('res/spec'):
    # When update spectest, we can increase the commit id in small steps.
    # Use: git log --reverse 1041527d508218acc40f0278d4abc3be9ba5e3bd.. -- test/core
    call('git checkout 1041527d508218acc40f0278d4abc3be9ba5e3bd')
with cd('res'):
    call('cp -R spec/test/core spectest')
with cd('res/spectest'):
    for e in sorted(glob.glob('*.wast')):
        call(f'wast2json {e}')
