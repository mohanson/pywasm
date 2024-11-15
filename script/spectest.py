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
# Use: git log --reverse commit.. -- test/core
call('cd res/spec && git checkout bd2aa85d5f6c6129760a3705f4de8acdb45b8e67')  # Nov 12, 2024
call('cd res && cp -R spec/test/core spectest')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json {e}')
os.chdir('../..')
