import wasmi


def env_fib(_, args):
    def fib(a):
        if a <= 1:
            return a
        return fib(a - 1) + fib(a - 2)
    return fib(args[0].into_i32())


path = './examples/env.wasm'

with open(path, 'rb') as f:
    mod = wasmi.Mod.from_reader(f)
vm = wasmi.Vm(mod)
vm.envbfuncs['env.fib'] = env_fib

r = vm.exec('get', [10])
print(r)
