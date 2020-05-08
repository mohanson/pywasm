# pywasm: A WebAssembly interpreter written in pure Python.

[![Build Status](https://travis-ci.org/mohanson/pywasm.svg?branch=master)](https://travis-ci.org/mohanson/pywasm)

A WebAssembly interpreter written in pure Python.

The wasm version currently in use is: [WebAssembly Core Specification, W3C Recommendation, 5 December 2019](https://www.w3.org/TR/wasm-core-1/). Just like Firefox or Chrome does.

# Installation

```sh
$ pip3 install pywasm
```

# Some simple examples

1. First we need a wasm module! Grab our `./examples/fib.wasm` file and save a copy in a new directory on your local machine. Note: `fib.wasm` was compiled from `./examples/fib.c` by [WasmFiddle](https://wasdk.github.io/WasmFiddle/).

2. Now, compile and instantiate WebAssembly modules directly from underlying sources. This is achieved using the `pywasm.load` method.

```py
import pywasm
# pywasm.on_debug()

runtime = pywasm.load('./examples/fib.wasm')
r = runtime.exec('fib', [10])
print(r) # 55
```

A brief description for `./examples`

| File                | Description                                  |
|---------------------|----------------------------------------------|
| ./examples/add.wasm | Export i32.add function                      |
| ./examples/env.wasm | Call python/native function in wasm          |
| ./examples/fib.wasm | Fibonacci, which contains loop and recursion |
| ./examples/str.wasm | Export a function which returns string       |
| ./examples/sum.wasm | Equal difference series summation            |

Of course there are some more complicated examples!

- Zstandard decompression algorithm: [https://github.com/dholth/zstdpy](https://github.com/dholth/zstdpy)
- Run AssemblyScript on pywasm: [https://github.com/mohanson/pywasm_assemblyscript](https://github.com/mohanson/pywasm_assemblyscript)

# Test

```sh
$ python3 ./test/test_spec.py
```

Tested in the following environments:

- Python >= 3.6

# Thanks

- [wagon](https://github.com/go-interpreter/wagon)
- [warpy](https://github.com/kanaka/warpy)

# License

[MIT](./LICENSE)
