from pathlib import Path
from shutil import copyfile

from generators.generator import Generator
from generators.polyhedron_generator import CubeGenerator
from generators.technopark_generator import TechnoparkGenerator

import json

results_path = Path("results")
app_path = Path("../ARHologramMap/Res")


def main():
    generators = [
        TechnoparkGenerator(),
        CubeGenerator(4, 0.25)
    ]

    jsons = [generator.to_json() for generator in generators]

    assert all(Generator.validate_result(result) for result in jsons)

    results_path.mkdir(parents=True, exist_ok=True)

    umbrella_file_name = "registry.json"
    names_list = []

    for json_object in jsons:
        hologram_name = json_object["name"].lower()

        json_path = results_path / (hologram_name + ".json")

        with json_path.open("w") as result_file:
            json.dump(json_object, result_file, indent=4)

        names_list.append(hologram_name)

        print(json.dumps(json_object))

    registry = {
        "files": names_list
    }

    with (results_path / umbrella_file_name).open("w") as registry_file:
        json.dump(registry, registry_file, indent=4)


def copy_to_app():
    assert app_path.exists() and app_path.is_dir()

    for res_file in app_path.iterdir():
        assert res_file.is_file()

        res_file.unlink()

    for file in results_path.iterdir():
        if file.suffix != ".json":
            continue

        copyfile(file, app_path/file.name)


if __name__ == '__main__':
    main()
    copy_to_app()
