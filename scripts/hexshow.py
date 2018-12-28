import sys


def fmth(n: int, l: int):
    a = hex(n)
    return a[2:].rjust(l, '0')


def main():
    name = sys.argv[1]
    with open(name, 'rb') as f:
        for i in range(1 << 32):
            line = f.read(8)
            if not line:
                break
            print(fmth(i, 8), ' '.join([fmth(i, 2) for i in line]))


if __name__ == '__main__':
    main()
