import wasmi


def env_fib(_, args):
    def fib(a):
        if a <= 1:
            return a
        return fib(a - 1) + fib(a - 2)
    return fib(args[0].into_i32())


env = wasmi.Env()
env.import_func['env.fib'] = env_fib

path = './examples/env.wasm'
mod = wasmi.Module.open(path)
vm = wasmi.Vm(mod, env)

r = vm.exec('get', [10])
print(r)
