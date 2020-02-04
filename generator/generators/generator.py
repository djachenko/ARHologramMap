from abc import abstractmethod
from typing import Dict

from models.building import Building
from models.hologram_entity import HologramEntity


class Generator:
    __MODEL_SIZE = 0.25

    @classmethod
    @abstractmethod
    def name(cls) -> str:
        pass

    @abstractmethod
    def generate(self) -> Building:
        pass

    @staticmethod
    def validate_result(result: Dict) -> bool:
        return "name" in result

    def to_json(self) -> Dict:
        building = self.generate()

        min_point, max_point = building.bounds()

        dx = abs(max_point.x - min_point.x)
        dy = abs(max_point.y - min_point.y)
        dz = abs(max_point.z - min_point.z)

        max_dimension = max(dx, dy, dz)

        scale_factor = Generator.__MODEL_SIZE / max_dimension

        building.scale(scale_factor)

        json = building.to_json()

        json["name"] = self.name()

        return json
