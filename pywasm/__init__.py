import platform

from . import core
from . import leb128
from . import log
from . import opcode
if platform.system().lower() in ['darwin', 'linux']:
    from . import wasi
from .core import *

version = '2.1.6'
