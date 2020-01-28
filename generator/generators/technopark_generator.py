from typing import List, Tuple

import util
from models.building import Building
from models.floor import Floor
from generators.generator import Generator
from line import Line
from models.hologram_entity import HologramEntity


class TechnoparkGenerator(Generator):
    @classmethod
    def name(cls) -> str:
        return "Technopark"

    def generate(self) -> HologramEntity:
        floor_6_dx = 351
        floor_6_shift = 165

        floor_13_dx = 246
        floor_13_shift = 141

        passage_dx = 88
        roof_dx = 390

        floor_6_dx, floor_6_shift, floor_13_dx, floor_13_shift, passage_dx, roof_dx = \
            util.relation(floor_6_dx, floor_6_shift, floor_13_dx, floor_13_shift, passage_dx, roof_dx)

        floor_6_left = floor_6_dx + floor_6_shift
        floor_13_left = floor_13_dx + floor_13_shift

        outer = Line.from_points((floor_6_left, 6), (floor_13_left, 13))
        inner = Line.from_points((floor_6_shift, 6), (floor_13_shift, 13))

        common_floor_dy = 4
        boiler_dy = common_floor_dy * 2

        roof_dz_to_dx = 32 / 35
        roof_dz_to_passage_dz = 16 / 9

        roof_dz = roof_dx / roof_dz_to_dx
        roof_z_top = roof_dz * roof_dz_to_passage_dz / 2

        bottom_floor = 1
        top_floor = 12

        floors = [
            bottom_floor,
            top_floor
        ]

        floor_height = 4

        building = Building(floor_height=floor_height)

        def generate_floor(number: int) -> List[Tuple[float, float]]:
            outer_x = outer.x(number)
            inner_x = inner.x(number)

            points = [
                (outer_x, roof_z_top),
                (inner_x, roof_z_top),
                (inner_x, roof_z_top + roof_dz),
                (outer_x, roof_z_top + roof_dz),
            ]

            return points

        for floor in floors:
            floor_points = generate_floor(floor)

            building[floor] = Floor(floor_points)

        building[top_floor].ceil = generate_floor(top_floor + 1)

        def generate_last_floor(index: int) -> List[Tuple[float, int]]:
            return [
                (outer.x(index), roof_z_top),
                (passage_dx, roof_z_top),
                (passage_dx, 0),
                (-passage_dx, 0),
                (-passage_dx, roof_z_top + roof_dz),
                (outer.x(index), roof_z_top + roof_dz),
            ]

        last_floor = Floor(
            floor=generate_last_floor(top_floor + 1),
            ceil=generate_last_floor(top_floor + 2),
            height=boiler_dy
        )

        building[top_floor + 1] = last_floor

        return building
