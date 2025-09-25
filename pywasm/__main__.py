import argparse
import sys

import pywasm

parser = argparse.ArgumentParser()
parser.add_argument('--version', '-v', action='version', version=f'pywasm {pywasm.version}')
parser.add_argument('--func', default='_start', help='set func name')
parser.add_argument('--func-args', action='append', default=[], help='set func args, like arg')
parser.add_argument('--wasi-envs', action='append', default=[], help='set wasi envs, like key=val')
parser.add_argument('--wasi-dirs', action='append', default=[], help='set wasi dirs, like dir:dir(host)')
parser.add_argument('--wasi-args', action='append', default=[], help='set wasi args, like arg')
parser.add_argument('--wasi', choices=['preview1'], help='set wasi version')
parser.add_argument('file', help='wasm file')
args = parser.parse_args()


def main_wasi():
    wasi_args = [args.file] + args.wasi_args
    wasi_dirs = {}
    wasi_envs = {}
    for e in args.wasi_dirs:
        spes = e.split(':', 1)
        wasi_dirs[spes[0]] = spes[1]
    for e in args.wasi_envs:
        spes = e.split('=', 1)
        wasi_envs[spes[0]] = spes[1]
    if args.wasi == 'preview1':
        runtime = pywasm.core.Runtime()
        wasi = pywasm.wasi.Preview1(wasi_args, wasi_dirs, wasi_envs)
        wasi.bind(runtime)
        inst = runtime.instance_from_file(args.file)
        code = wasi.main(runtime, inst)
        sys.exit(code)


def main_wasm():
    runtime = pywasm.core.Runtime()
    inst = runtime.instance_from_file(args.file)
    addr = [e for e in inst.exps if e.name == args.func][0].data.data
    func = runtime.machine.store.func[addr]
    assert len(func.type.args) == len(args.func_args)
    func_args = []
    for e in zip(func.type.args, args.func_args):
        if e[0] in [pywasm.ValType.i32(), pywasm.ValType.i64()]:
            func_args.append(int(e[1]))
            continue
        if e[0] in [pywasm.ValType.f32(), pywasm.ValType.f64()]:
            func_args.append(float(e[1]))
            continue
        if e[0] == pywasm.ValType.v128():
            func_args.append(bytearray.fromhex(e[1][2:]))
            continue
        assert 0
    rets = runtime.invocate(inst, args.func, func_args)
    print(rets)


if args.wasi:
    main_wasi()
main_wasm()
