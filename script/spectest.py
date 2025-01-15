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
# Use: git log --reverse f3a0e06235d2d84bb0f3b5014da4370613886965.. -- test/core
call('cd res/spec && git checkout f3a0e06235d2d84bb0f3b5014da4370613886965')  # Nov 12, 2024
call('cd res && cp -R spec/test/core spectest')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json {e}')
os.chdir('../..')
