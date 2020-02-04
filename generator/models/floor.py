from typing import Dict, Tuple

from models.hologram_entity import HologramEntity
from models.point import Point2D
from models.polygon import Polygon
from models.scalable import Scalable


class Floor(HologramEntity, Scalable):
    def __init__(
            self,
            floor: Polygon,
            ceil: Polygon = None,
            height: float = None
    ) -> None:
        super().__init__()

        self.__height = height
        self.__floor = floor
        self.__ceil = ceil

    @property
    def height(self) -> float:
        return self.__height

    @property
    def ceil(self) -> Polygon:
        return self.__ceil

    @ceil.setter
    def ceil(self, value: Polygon):
        self.__ceil = value

    def to_json(self) -> Dict:
        result = {
            "floor": self.__floor.to_json(),
        }

        if self.ceil is not None:
            result["ceiling"] = self.__ceil.to_json()

        if self.height is not None:
            result["height"] = self.height

        return result

    def __str__(self):
        return str(self.to_json())

    def scale(self, factor: float):
        self.__floor.scale(factor)

        if self.height is not None:
            self.__height *= factor

        if self.ceil is not None:
            self.ceil.scale(factor)

    def bounds(self) -> Tuple[Point2D, Point2D]:
        min_x = min(point.x for point in self.__floor)
        max_x = max(point.x for point in self.__floor)
        min_y = min(point.y for point in self.__floor)
        max_y = max(point.y for point in self.__floor)

        if self.ceil is not None:
            min_x = min(min_x, min(point.x for point in self.ceil))
            max_x = max(max_x, max(point.x for point in self.ceil))
            min_y = min(min_y, min(point.y for point in self.ceil))
            max_y = max(max_y, max(point.y for point in self.ceil))

        return Point2D(min_x, min_y), Point2D(max_x, max_y)
