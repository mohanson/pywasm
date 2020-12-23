import shutil
import subprocess

if shutil.which('py'):
    py = 'py'
else:
    py = 'python'

def test_examples():
    assert subprocess.getoutput(f'{py} examples/add.py') == '9'
    assert subprocess.getoutput(f'{py} examples/cycle.py') == '4'
    assert subprocess.getoutput(f'{py} examples/env.py') == '55'
    assert subprocess.getoutput(f'{py} examples/fib.py') == '55'
    assert subprocess.getoutput(f'{py} examples/str.py') == 'Hello World!'
    assert subprocess.getoutput(f'{py} examples/sum.py') == '4950'


if __name__ == '__main__':
    test_examples()
