# py-wasmi

A WebAssembly interpreter by pure Python. WASM version: [WebAssembly Core Specification W3C Working Draft, 4 September 2018](https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/)

# Requirements
- py-wasmi has been tested and is known to run on Linux/Ubuntu, macOS and Windows(10). It will likely work fine on most OS.
- Python3.6 or newer.

# Install

```sh
$ git clone https://github.com/mohanson/py-wasmi
$ cd py-wasmi && python3 main.py # Run quick test
```

**OR**

```sh
$ pip3 install wasmi # The version may be outdate.
```

# Example

py-wasmi is dead simple to use. Write some c code belows:

```c
int add(int a, int b) {
    return a + b;
}
```

Generate `add.wasm` by [WasmFiddle](https://wasdk.github.io/WasmFiddle/), and then:

```py
import wasmi

path = './tests/data/add.wasm'

with open(path, 'rb') as f:
    mod = wasmi.Mod.from_reader(f)
vm = wasmi.Vm(mod)
r = vm.exec('add', [40, 2])
print(r) # 42
```

# FAQ

F: How is the py-wasm performance?<br>
Q: It's doesn't care about performance especially on **Python**.

# License

[WTFPL](https://choosealicense.com/licenses/wtfpl/)
