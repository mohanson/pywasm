import subprocess


subprocess.run(f'python examples/add.py', shell=True, check=True)
subprocess.run(f'python examples/env.py', shell=True, check=True)
subprocess.run(f'python examples/fib.py', shell=True, check=True)
subprocess.run(f'python examples/str.py', shell=True, check=True)
subprocess.run(f'python examples/sum.py', shell=True, check=True)
