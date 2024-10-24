import glob
import os
import subprocess


def call(cmd: str):
    print(f'$ {cmd}')
    return subprocess.call(cmd, shell=True)


call('cd res && rm -rf spec')
call('cd res && rm -rf spectest')
call('cd res && git clone https://github.com/WebAssembly/spec')
call('cd res/spec && git checkout 85a7ccb0307fb1284ea22f74cd77bd833ec25440')
call('cd res && cp -R spec/test/core spectest')
call('cd res && rm -rf spec')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json {e}')
os.chdir('../..')
