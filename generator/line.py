from typing import Tuple


class Line:
    def __init__(self, a: float, b: float, c: float) -> None:
        super().__init__()

        self.__a = a
        self.__b = b
        self.__c = c

    def x(self, y: float) -> float:
        return (self.__b * y + self.__c) / (-self.__a)

    def y(self, x: float) -> float:
        return (self.__a * x + self.__c) / (-self.__b)

    @staticmethod
    def from_points(p1: Tuple[float, float], p2: Tuple[float, float]) -> 'Line':
        print(p1)
        print(p2)

        a = - (p1[1] - p2[1]) / (p1[0] - p2[0])
        b = 1
        c = -(a * p1[0] + b * p1[1])

        print(a, b, a * p1[0] + b)

        return Line(a, b, c)

    def __str__(self) -> str:
        return f"{self.__a}x + {self.__b}y + {self.__c} = 0"
