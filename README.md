# Pywasm: A WebAssembly interpreter written in pure Python.

A WebAssembly interpreter written in pure Python, no third-party libraries are used.

The wasm version currently in use is: [WebAssembly Specification, Release 2.0 (Draft 2025-04-25)](https://webassembly.github.io/spec/core/).

Also requires Python version >= 3.12.

# Installation

```sh
$ pip install pywasm
```

# Some simple examples

1. First we need a wasm module! Grab our `examples/fibonacci/bin/fibonacci.wasm` file and save a copy in a new directory on your local machine.

2. Now, instantiate WebAssembly modules directly from underlying sources. This is achieved using the `Runtime.instance_from_file` method.

```py
import pywasm
pywasm.log.lvl = 1

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('examples/fibonacci/bin/fibonacci.wasm')
r = runtime.invocate(m, 'fibonacci', [10])
print(f'fibonacci(10) = {r[0]}')
```

A brief description for `examples`

|            File            |                             Description                              |
| -------------------------- | -------------------------------------------------------------------- |
| examples/blake2b.py        | Blake2b hashing algorithm                                            |
| examples/blake2b_direct.py | Make the hash result returned as a value, not as an output parameter |
| examples/fibonacci.py      | Fibonacci, which contains loop and recursion                         |
| examples/fibonacci_env.py  | Call python/native function in wasm                                  |
| examples/pi.py             | Calculate π using the agm algorithm                                  |

# Test

```sh
$ python test/test_spec.py
```

# Thanks

- [wagon](https://github.com/go-interpreter/wagon)
- [warpy](https://github.com/kanaka/warpy)
- [zstdpy](https://github.com/dholth/zstdpy)

# License

[MIT](./LICENSE)
