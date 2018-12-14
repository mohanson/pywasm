import io

import wasmi.leb128
import wasmi.opcodes


class Interpreter:
    def __init__(self, code: bytearray):
        assert len(code) >= 8
        self.code = io.BytesIO(code)
        self.magic_number = self.code.read(4)
        self.version = self.code.read(4)
        self.function_signature = []
        self.function = []
        self.export = {}
        self.bytecode = []

        for _ in range(1 << 32):
            op = self.code.read(1)
            if not op:
                break
            if ord(op) == wasmi.opcodes.IDType:
                self.read_section_type()
                continue
            if ord(op) == wasmi.opcodes.IDFunction:
                self.read_section_function()
                continue
            if ord(op) == wasmi.opcodes.IDExport:
                self.read_section_export()
                continue
            if ord(op) == wasmi.opcodes.IDCode:
                self.read_code()
                continue

    def read_section_type(self):
        l = ord(self.code.read(1))
        n = ord(self.code.read(1))
        assert ord(self.code.read(1)) == 0x60
        npi = ord(self.code.read(1))
        pil = self.code.read(npi)
        npr = ord(self.code.read(1))
        prl = self.code.read(npr)
        self.function_signature.append([pil, prl])

    def read_section_function(self):
        l = ord(self.code.read(1))
        n = ord(self.code.read(1))
        i = ord(self.code.read(1))
        self.function.append(i)

    def read_section_export(self):
        l = ord(self.code.read(1))
        n = ord(self.code.read(1))
        n_name = ord(self.code.read(1))
        name = self.code.read(n_name).decode()
        _ = self.code.read(1)
        i = ord(self.code.read(1))
        self.export[name] = i

    def read_code(self):
        l = ord(self.code.read(1))
        n = ord(self.code.read(1))
        fn = ord(self.code.read(1))
        _ = self.code.read(1)
        self.bytecode.append(self.code.read(fn - 1))

    def exec(self, name, data):
        i = self.export[name]
        function_signature = self.function_signature[i]
        function = self.function[i]
        function_code = self.bytecode[i]
        stack = []
        pc = 0
        dc = 0
        for i in range(1 << 32):
            op = function_code[i]
            pc += 1
            if op == wasmi.opcodes.OPGetLocal:
                a = int.from_bytes(data[dc:dc+4], byteorder='big')
                stack.append(a)
                dc = dc + 4
                continue
            if op == wasmi.opcodes.OPAdd:
                a = stack.pop()
                b = stack.pop()
                stack.append(a + b)
                continue
            if op == wasmi.opcodes.OPRetuen:
                return stack.pop()
            if op == wasmi.opcodes.OPStop:
                break
