from abc import abstractmethod
from typing import Dict

from models.hologram_entity import HologramEntity


class Generator:
    @classmethod
    @abstractmethod
    def name(cls) -> str:
        pass

    @abstractmethod
    def generate(self) -> HologramEntity:
        pass

    @staticmethod
    def validate_result(result: Dict) -> bool:
        return "name" in result

    def to_json(self) -> Dict:
        json = self.generate().to_json()

        json["name"] = self.name()

        return json
