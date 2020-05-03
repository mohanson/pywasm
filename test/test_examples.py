import subprocess


def test_examples():
    assert subprocess.getoutput('py examples/add.py') == '9'
    assert subprocess.getoutput('py examples/env.py') == '55'
    assert subprocess.getoutput('py examples/fib.py') == '55'
    assert subprocess.getoutput('py examples/str.py') == 'Hello World!'
    assert subprocess.getoutput('py examples/sum.py') == '4950'


if __name__ == '__main__':
    test_examples()
