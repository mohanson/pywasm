import argparse
import sys

import pywasm

parser = argparse.ArgumentParser()
parser.add_argument('--version', '-v', action='version', version=f'pywasm {pywasm.version}')
parser.add_argument('--preview1', action='store_true', default=True, help='use wasi preview1')
parser.add_argument('file', help='wasm file to run')
parser.add_argument('args', nargs='*', help='arg0 arg1 ... dir0:dir0 dir1:dir1 ... env0=val0 env1=val1 ... ')
args = parser.parse_args()

wasi_args = [args.file]
wasi_dirs = {}
wasi_envs = {}
for e in args.args:
    if '=' in e:
        spes = e.split('=', 1)
        wasi_envs[spes[0]] = spes[1]
        continue
    if ':' in e:
        spes = e.split(':', 1)
        wasi_dirs[spes[0]] = spes[1]
        continue
    wasi_args.append(e)

if args.preview1:
    runtime = pywasm.core.Runtime()
    wasi = pywasm.wasi.Preview1(wasi_args, wasi_dirs, wasi_envs)
    wasi.bind(runtime)
    exit = wasi.main(runtime, runtime.instance_from_file(args.file))
    sys.exit(exit)
