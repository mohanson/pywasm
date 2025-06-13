import glob
import os
import subprocess


def call(cmd: str):
    print(f'$ {cmd}')
    return subprocess.run(cmd, shell=True, check=True)


call('cd res && rm -rf spectest')
if not os.path.exists('res/spec'):
    call('cd res && git clone https://github.com/WebAssembly/spec')
# When update spectest, we can increase the commit id in small steps.
# Use: git log --reverse abc8d16dcb4b36f818af9ee2fa9b1bf0b50503cb.. -- test/core
call('cd res/spec && git checkout abc8d16dcb4b36f818af9ee2fa9b1bf0b50503cb')
call('cd res && cp -R spec/test/core spectest')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json {e}')
os.chdir('../..')
