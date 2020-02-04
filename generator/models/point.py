from typing import Tuple

from models.scalable import Scalable


class Point2D(Scalable):
    def __init__(self, x: float, y: float) -> None:
        super().__init__()

        self.__x = x
        self.__y = y

    @property
    def x(self):
        return self.__x

    @property
    def y(self):
        return self.__y

    def scale(self, factor: float):
        self.__x *= factor
        self.__y *= factor

    def __str__(self):
        return str([self.__x, self.__y])

    def to_json(self) -> Tuple[float, float]:
        return self.x, self.y


class Point3D:
    def __init__(self, x: float, y: float, z: float) -> None:
        super().__init__()

        self.__x = x
        self.__y = y
        self.__z = z

    @property
    def x(self):
        return self.__x

    @property
    def y(self):
        return self.__y

    @property
    def z(self):
        return self.__z
