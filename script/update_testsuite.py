import glob
import os
import shutil
import subprocess
import sys
import tempfile

wabt = 'https://github.com/WebAssembly/wabt'
testsuite = 'https://github.com/WebAssembly/testsuite'
testsuite_commit_id = 'da56298dddb441d1af38492ee98fe001e625d156'
wast2json = shutil.which('wast2json')

if not wast2json:
    print(f'command \'wast2json\' not found, you can download it at \'{wabt}\'')
    print('abort')
    sys.exit(0)


def call(cmd: str):
    print(f'$ {cmd}')
    return subprocess.call(cmd, shell=True)


call('rm -rf ./res/testsuite')
call(f'cd ./res && git clone {testsuite}')
call(f'cd ./res/testsuite && git checkout -b {testsuite_commit_id} {testsuite_commit_id}')
call(f'cd ./res/testsuite && mkdir spectest')

for e in glob.glob('./res/testsuite/*.wast'):
    a, _ = os.path.splitext(os.path.basename(e))
    os.makedirs(f'./res/testsuite/spectest/{a}')
    call(f'wast2json --enable-all {e} -o ./res/testsuite/spectest/{a}/{a}.json')
