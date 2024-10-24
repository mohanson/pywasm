import datetime

lvl = 0


def debugln(*args):
    if lvl:
        println(*args)


def println(*args):
    pre = datetime.datetime.now().strftime('%Y/%m/%d %H:%M:%S')
    print(pre, *args)
