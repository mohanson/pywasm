from pywasm import log
from pywasm.execution import AbstractMachine
from pywasm.structure import Module


def on_debug():
    log.lvl = 1
