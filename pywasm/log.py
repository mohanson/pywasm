import datetime

lvl = 0


def debugln(*args):
    if lvl > 0:
        println(*args)


def println(*args):
    pre = datetime.datetime.now().strftime('%Y/%m/%d %H:%M:%S')
    print(pre, 'pywasm:', *args)
