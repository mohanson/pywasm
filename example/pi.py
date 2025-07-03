import pywasm
pywasm.log.lvl = 1

runtime = pywasm.core.Runtime()
m = runtime.instance_from_file('example/pi/bin/pi.wasm')
r = runtime.invocate(m, 'pi', [7])
print(f'pi(7) = {r[0]}')
