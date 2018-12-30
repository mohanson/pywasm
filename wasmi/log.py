import datetime
import sys

switch = False


def println(*args):
    if not switch:
        return
    pre = datetime.datetime.now().strftime('%Y/%m/%d %H:%M:%S')
    print(pre, *args)


def panicln(*args):
    println(*args)
    raise Exception(' '.join(str(e) for e in args))


def fatalln(*args):
    println(*args)
    println('exit status 1')
    sys.exit(1)
