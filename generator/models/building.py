import json
from typing import Dict

from models.floor import Floor
from models.hologram_entity import HologramEntity


class Building(HologramEntity):
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
            result["default_height"] = self.__default_floor_height

        return result

    def __str__(self):
        return json.dumps(self.to_json(), indent=4)
