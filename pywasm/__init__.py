from pywasm import log
from pywasm.execution import AbstractMachine, ModuleInstance
from pywasm.structure import Module


def on_debug():
    log.lvl = 1
