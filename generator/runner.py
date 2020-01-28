from pathlib import Path

from generators.generator import Generator
from generators.technopark_generator import TechnoparkGenerator

import json


def main():
    generator_classes = [
        TechnoparkGenerator,
    ]

    generators = [cls() for cls in generator_classes]

    jsons = [generator.to_json() for generator in generators]

    assert all(Generator.validate_result(result) for result in jsons)

    results_path = Path("results")

    results_path.mkdir(parents=True, exist_ok=True)

    umbrella_file_name = "registry.json"
    names_list = []

    for json_object in jsons:
        hologram_name = json_object["name"]

        json_path = results_path / (hologram_name.lower() + ".json")

        with json_path.open("w") as result_file:
            json.dump(json_object, result_file, indent=4)

        names_list.append(hologram_name)

        print(json.dumps(json_object))

    registry = {
        "files": names_list
    }

    with (results_path / umbrella_file_name).open("w") as registry_file:
        json.dump(registry, registry_file, indent=4)





if __name__ == '__main__':
    main()
