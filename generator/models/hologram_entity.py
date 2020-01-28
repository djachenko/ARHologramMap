from abc import abstractmethod
from typing import Dict


class HologramEntity:
    @abstractmethod
    def to_json(self) -> Dict:
        pass
