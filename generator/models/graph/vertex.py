class Vertex:
    def __init__(self, index: int) -> None:
        super().__init__()

        self.__index = index

    def __eq__(self, other):
        if not isinstance(other, Vertex):
            return False

        return self.__index == other.__index
