from collections import defaultdict

from generators.generator import Generator
from line import Line
from models.building import Building
from models.floor import Floor
from models.point import Point2D
from models.polygon import Polygon


class TechnoparkGenerator(Generator):
    @classmethod
    def name(cls) -> str:
        return "Technopark"

    def generate(self) -> Building:
        floor_6_dx = 741
        floor_6_shift = 320

        floor_13_dx = 522
        floor_13_shift = 271

        passage_dx = 183
        roof_dx = 818

        floor_6_left = floor_6_dx + floor_6_shift
        floor_13_left = floor_13_dx + floor_13_shift

        common_floor_dz = 90
        floor_13_dz = common_floor_dz * 2

        heights = defaultdict(lambda: 1, {
            13: 2
        })

        def ground_heights(index: int) -> float:
            if index == -1:
                return 0

            return ground_heights(index - 1) + heights[index]

        outer = Line.from_points(
            (floor_6_left, ground_heights(6)),
            (floor_13_left, ground_heights(13))
        )

        inner = Line.from_points(
            (floor_6_shift, ground_heights(6)),
            (floor_13_shift, ground_heights(13))
        )

        roof_dy_to_dx = 32 / 35
        roof_dy_to_passage_dy = 16 / 9

        roof_dy = roof_dx / roof_dy_to_dx
        roof_y_inner = roof_dy * roof_dy_to_passage_dy / 2  # passage_length / 2

        bottom_floor = 1
        top_floor = 2

        floors = list(range(bottom_floor, top_floor + 1))

        building = Building(floor_height=common_floor_dz)

        def generate_floor(number: int) -> Polygon:
            ground_height = ground_heights(number - 1)

            outer_x = outer.x(ground_height)
            inner_x = inner.x(ground_height)

            points = [
                Point2D(outer_x, roof_y_inner),
                Point2D(inner_x, roof_y_inner),
                Point2D(inner_x, roof_y_inner + roof_dy),
                Point2D(outer_x, roof_y_inner + roof_dy),
            ]

            return Polygon(points)

        for floor in floors:
            floor_points = generate_floor(floor)

            building[floor] = Floor(floor_points)

        building[top_floor].ceil = generate_floor(top_floor + 1)

        def generate_last_floor(index: int) -> Polygon:
            return Polygon([
                Point2D(outer.x(index), roof_y_inner),
                Point2D(passage_dx / 2, roof_y_inner),
                Point2D(passage_dx / 2, 0),
                Point2D(-passage_dx / 2, 0),
                Point2D(-passage_dx / 2, roof_y_inner + roof_dy),
                Point2D(outer.x(index), roof_y_inner + roof_dy),
            ])

        last_floor = Floor(
            floor=generate_last_floor(top_floor + 1),
            ceil=generate_last_floor(top_floor + 3),
            height=floor_13_dz
        )

        # building[top_floor + 1] = last_floor

        return building
