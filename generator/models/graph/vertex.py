from typing import Any


class Vertex:
    def __init__(self, index: Any) -> None:
        super().__init__()

        self.__index = index

    def __eq__(self, other):
        if not isinstance(other, Vertex):
            return False

        return self.__index == other.__index

    def __str__(self):
        return f"Vertex({str(self.__index)})"

    def __repr__(self):
        return str(self)

    @property
    def item(self):
        return self.__index