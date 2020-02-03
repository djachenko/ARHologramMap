from typing import List

from models.point import Point2D
from models.scalable import Scalable


class Polygon(Scalable):
    def __init__(self, points: List[Point2D]) -> None:
        super().__init__()

        self.__points = points

    def scale(self, factor: float):
        for point in self.__points:
            point.scale(factor)

    def __iter__(self):
        for point in self.__points:
            yield point

    def __getitem__(self, index: int) -> Point2D:
        return self.__points[index]

    def to_json(self):
        return [point.to_json() for point in self.__points]
