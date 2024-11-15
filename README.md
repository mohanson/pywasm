# Pywasm: A WebAssembly interpreter written in pure Python.

A WebAssembly interpreter written in pure Python, no third-party libraries are used.

The wasm version currently in use is: [WebAssembly Specification, Release 2.0 (Draft 2024-11-12)](https://webassembly.github.io/spec/core/).

Also requires Python version >= 3.12.

# Installation

```sh
$ pip install pywasm
```

# Some simple examples

1. First we need a wasm module! Grab our `./examples/fib.wasm` file and save a copy in a new directory on your local machine. Note: `fib.wasm` was compiled from `./examples/fib.c`.

2. Now, instantiate WebAssembly modules directly from underlying sources. This is achieved using the `Runtime.instance_from_file` method.

```py
import pywasm
pywasm.log.lvl = 1

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('./examples/fib.wasm')
r = runtime.invocate(m, 'fib', [10])
print(f'fib(10) = {r[0]}')
```

A brief description for `./examples`

| File                | Description                                  |
|---------------------|----------------------------------------------|
| ./examples/add.wasm | Export i32.add function                      |
| ./examples/env.wasm | Call python/native function in wasm          |
| ./examples/fib.wasm | Fibonacci, which contains loop and recursion |
| ./examples/str.wasm | Export a function which returns string       |
| ./examples/sum.wasm | Equal difference series summation            |

# Test

```sh
$ python ./test/test_spec.py
```

# Thanks

- [wagon](https://github.com/go-interpreter/wagon)
- [warpy](https://github.com/kanaka/warpy)
- [zstdpy](https://github.com/dholth/zstdpy)

# License

[MIT](./LICENSE)
