import subprocess


def test_add():
    subprocess.check_call(f'python examples/add.py', shell=True)


def test_env():
    subprocess.check_call(f'python examples/env.py', shell=True)


def test_fib():
    subprocess.check_call(f'python examples/fib.py', shell=True)


def test_str():
    subprocess.check_call(f'python examples/str.py', shell=True)


def test_sum():
    subprocess.check_call(f'python examples/sum.py', shell=True)
