class WAException(Exception):
    def __init__(self, message):
        super().__init__(self)
        self.message = message
