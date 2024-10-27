import glob
import os
import subprocess


def call(cmd: str):
    print(f'$ {cmd}')
    return subprocess.call(cmd, shell=True)


call('cd res && rm -rf spec')
call('cd res && rm -rf spectest')
call('cd res && git clone https://github.com/WebAssembly/spec')
call('cd res/spec && git checkout 704d9d9e9c861fdb957c3d5e928f1d046a31497e') # Apr 4, 2020
call('cd res && cp -R spec/test/core spectest')
call('cd res && rm -rf spec')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json --disable-bulk-memory {e}')
os.chdir('../..')
