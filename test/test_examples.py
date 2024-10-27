import subprocess


subprocess.check_call(f'python examples/add.py', shell=True)
subprocess.check_call(f'python examples/env.py', shell=True)
subprocess.check_call(f'python examples/fib.py', shell=True)
subprocess.check_call(f'python examples/str.py', shell=True)
subprocess.check_call(f'python examples/sum.py', shell=True)
