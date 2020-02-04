import json
from typing import Dict, Tuple

from models.floor import Floor
from models.point import Point3D
from models.scalable import Scalable


class Building(Scalable):
    def __init__(self, floors: Dict[int, Floor] = None, floor_height: float = None) -> None:
        super().__init__()

        if floors is None:
            floors = {}

        self.__default_floor_height = floor_height
        self.__floors = floors

        assert all(self.__validate_floor_height(floor) for floor in floors.values())

    def __validate_floor_height(self, floor: Floor) -> bool:
        return not (self.__default_floor_height is None and floor.height is None)

    def __setitem__(self, key: int, new_floor: Floor):
        assert self.__validate_floor_height(new_floor)

        self.__floors[key] = new_floor

    def __getitem__(self, floor_index: int) -> Floor:
        return self.__floors[floor_index]

    def to_json(self) -> Dict:
        result = {
            "floors": {index: floor.to_json() for index, floor in self.__floors.items()}
        }

        if self.__default_floor_height is not None:
            result["defaultHeight"] = self.__default_floor_height

        return result

    def bounds(self) -> Tuple[Point3D, Point3D]:
        floors_bounds = [floor.bounds() for floor in self.__floors.values()]

        min_x = min([min_point.x for min_point, _ in floors_bounds])
        min_y = min([min_point.y for min_point, _ in floors_bounds])

        max_x = max([max_point.x for _, max_point in floors_bounds])
        max_y = max([max_point.y for _, max_point in floors_bounds])

        height_diff = 0

        for floor in self.__floors.values():
            def if_not_nil(value, default):
                if value is not None:
                    return value

                return default

            default_height = if_not_nil(self.__default_floor_height, 0)
            floor_height = if_not_nil(floor.height, default_height)

            height_diff += floor_height - default_height

        if self.__default_floor_height is not None:
            top_floor = max(self.__floors.keys())

            total_height = top_floor * self.__default_floor_height + height_diff
        else:
            total_height = height_diff

        return Point3D(min_x, min_y, 0), Point3D(max_x, max_y, total_height)

    def __str__(self):
        return json.dumps(self.to_json(), indent=4)

    def scale(self, factor: float):
        for floor in self.__floors.values():
            floor.scale(factor)

        self.__default_floor_height *= factor
