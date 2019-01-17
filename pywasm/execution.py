from pywasm import structure

class AbstractMachine:
    def __init__(self, module: structure.Module):
        self.module = module
        self.stack = None
        self.store = None
