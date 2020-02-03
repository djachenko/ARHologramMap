import math
from abc import ABC

from generators.generator import Generator
from models.building import Building
from models.floor import Floor
from models.point import Point2D
from models.polygon import Polygon


def epsilonate(value: float) -> float:
    epsilon = 0.00001

    if value < epsilon:
        return 0
    else:
        return value


class PolyhedronGenerator(Generator, ABC):
    def __init__(self, angles_count: int, radius: float, floors_count: int, height: float) -> None:
        super().__init__()

        assert angles_count >= 3

        self.floors_count = floors_count
        self.radius = radius
        self.angles_count = angles_count
        self.height = height

    def generate(self) -> Building:
        step = math.pi * 2 / self.angles_count
        floor_height = self.height / self.floors_count

        floors = {}

        for floor_index in range(self.floors_count):

            points = []

            for angle_index in range(self.angles_count):
                phi = angle_index * step + math.pi / 2

                x = epsilonate(math.sin(phi)) * self.radius
                y = epsilonate(math.cos(phi)) * self.radius

                points.append(Point2D(x, y))

            floor = Floor(Polygon(points))

            floors[floor_index + 1] = floor

        building = Building(floors, floor_height)

        return building


class CubeGenerator(PolyhedronGenerator):
    @classmethod
    def name(cls) -> str:
        return "cube"

    def __init__(self, floors_count: int, side: float) -> None:
        super().__init__(4, side / 2 * math.sqrt(2), floors_count, side)
