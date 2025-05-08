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
# Use: git log --reverse ea3e55e7602c327e9b72c7e47033aa7cc66d460a.. -- test/core
call('cd res/spec && git checkout ea3e55e7602c327e9b72c7e47033aa7cc66d460a')
call('cd res && cp -R spec/test/core spectest')

os.chdir('res/spectest')
for e in sorted(glob.glob('*.wast')):
    call(f'wast2json {e}')
os.chdir('../..')
