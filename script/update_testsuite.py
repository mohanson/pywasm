import glob
import os
import shutil
import subprocess
import sys

wabt = 'https://github.com/WebAssembly/wabt'
testsuite = 'https://github.com/WebAssembly/testsuite'
wast2json = shutil.which('wast2json')

if not wast2json:
    print(f'command \'wast2json\' not found, you can download it at \'{wabt}\'')
    print('abort')
    sys.exit(0)

shutil.rmtree('./res/testsuite', ignore_errors=True)
shutil.rmtree('./res/testsuite_wasm', ignore_errors=True)
os.makedirs('./res', exist_ok=True)
os.mkdir('./res/testsuite_wasm')

os.chdir('./res')
subprocess.call(f'git clone {testsuite}', shell=True)
os.chdir('..')

for e in glob.glob('./res/testsuite/*.wast'):
    a, _ = os.path.splitext(os.path.basename(e))
    os.makedirs(f'./res/testsuite_wasm/{a}')
    subprocess.call(f'wast2json --enable-all {e} -o ./res/testsuite_wasm/{a}/{a}.json', shell=True)
