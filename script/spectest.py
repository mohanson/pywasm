import glob
import os
import subprocess


def call(cmd: str):
    print(f'$ {cmd}')
    return subprocess.call(cmd, shell=True)


call('cd res && rm -rf spectest')
if not os.path.exists('res/spec'):
    call('cd res && git clone https://github.com/WebAssembly/spec')
# When update spectest, we can increase the commit id in small steps.
# Use: git log --reverse commit.. -- test/core
call('cd res/spec && git checkout cda4012a157f8e34cec64dc975e5552b96c58179') # Oct 29, 2024
call('cd res && cp -R spec/test/core spectest')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json {e}')
os.chdir('../..')
