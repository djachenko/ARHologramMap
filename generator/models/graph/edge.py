from models.graph.vertex import Vertex


class Edge:
    def __init__(self, first: Vertex, second: Vertex) -> None:
        super().__init__()

        self.__first = first
        self.__second = second

    @property
    def first(self) -> Vertex:
        return self.__first

    @property
    def second(self) -> Vertex:
        return self.__second

    def is_loop(self) -> bool:
        return self.first == self.second
