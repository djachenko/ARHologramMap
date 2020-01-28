import itertools
from typing import Optional, Tuple


def relation(*values: float) -> Optional[Tuple[int, ...]]:
    max_factor = round(min(values))
    tolerance = 0.2

    pairing_indices = list(itertools.product(range(len(values)), repeat=2))

    for factor in range(max_factor, 0, -1):
        scaled_values = [value / factor for value in values]

        rounded_values = tuple(round(value) for value in scaled_values)

        errors = []
        relations = []

        for a, b in pairing_indices:
            initial_relation = values[a] / values[b]
            rounded_relation = rounded_values[a] / rounded_values[b]

            error = abs(initial_relation - rounded_relation)

            relations.append((initial_relation, rounded_relation, error))

            errors.append(error)

        max_error = max(errors)

        print(factor, max_error)

        if max_error <= tolerance:
            return rounded_values

    return None
