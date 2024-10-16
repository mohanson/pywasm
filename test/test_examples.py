import subprocess


def test_examples():
    assert subprocess.getoutput(f'python examples/add.py') == '9'
    assert subprocess.getoutput(f'python examples/cycle.py') == '4'
    assert subprocess.getoutput(f'python examples/env.py') == '55'
    assert subprocess.getoutput(f'python examples/fib.py') == '55'
    assert subprocess.getoutput(f'python examples/str.py') == 'Hello World!'
    assert subprocess.getoutput(f'python examples/sum.py') == '4950'


if __name__ == '__main__':
    test_examples()
