import glob
import os
import subprocess


def call(cmd: str):
    print(f'$ {cmd}')
    return subprocess.call(cmd, shell=True)


call('cd res && rm -rf spec')
call('cd res && rm -rf spectest')
call('cd res && git clone https://github.com/WebAssembly/spec')
call('cd res/spec && git checkout 484180ba3d9d7638ba1cb400b699ffede796927c')
call('cd res && cp -R spec/test/core spectest')
call('cd res && rm -rf spec')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json --disable-bulk-memory {e}')
os.chdir('../..')
