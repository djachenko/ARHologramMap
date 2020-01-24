from typing import Tuple, List


class Floor:
    def __init__(
            self,
            floor: List[Tuple[float, float]],
            ceil: List[Tuple[float, float]] = None,
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
    def ceil(self) -> List[Tuple[float, float]]:
        return self.__ceil

    @ceil.setter
    def ceil(self, value: List[Tuple[float, float]]):
        self.__ceil = value

    def to_json(self):
        result = {
            "floor": [[x, z] for x, z in self.__floor],
        }

        if self.ceil is not None:
            result["ceiling"] = [[x, z] for x, z in self.ceil]

        if self.height is not None:
            result["height"] = self.height

        return result

    def __str__(self):
        return str(self.to_json())
