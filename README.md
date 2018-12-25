# py-wasmi

A WebAssembly interpreter by pure Python. WASM version: [WebAssembly Core Specification W3C Working Draft, 4 September 2018](https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/)

# Example

py-wasmi is dead simple to use:

```py
import wasmi

path = './data/add.wasm'

with open(path, 'rb') as f:
    mod = wasmi.Mod.from_reader(f)
vm = wasmi.Vm(mod)
r = vm.exec('add', [40, 2])
print(r) # 42
```
