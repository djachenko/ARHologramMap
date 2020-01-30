//
// Created by Igor Djachenko on 26/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import SceneKit

class BuildingGeometry: SCNGeometry {
    static func build(from building: Building) -> SCNGeometry {
        assert(building.floors.count >= 2)

        func mapTo3D(floor: Polygon2D, height: Real) -> Polygon3D {
            return floor.map { point in
                Point3D(point.x, height, point.y)
            }
        }

        let floors = building.floors
        let floorNumbers = floors.keys.sorted()


        let defaultHeight = building.default_height
        var diff = Real(0)

        let slices = floorNumbers.flatMap { number -> [Polygon3D] in
            let floor = floors[number]!

            let floorHeight = Real(number - 1) * defaultHeight + diff

            if let floorHeight =  floors[number]?.height {
                diff += floorHeight - defaultHeight
            }

            var floorSlices = [
                mapTo3D(floor: floor.floor, height: floorHeight)
            ]

            if let ceiling = floor.ceiling {
                floorSlices.append(mapTo3D(floor: ceiling, height: floorHeight))
            }

            return floorSlices
        }

        var mesh = [Point3D]()

        let meshIndices = slices.map { slice in
            slice.map { point -> UInt16 in
                let index = UInt16(mesh.count)

                mesh.append(point)

                return index
            }
        }

        let meshTriangles = (1..<meshIndices.count).flatMap { topIndex -> [[UInt16]] in
            let bottomIndex = topIndex - 1

            let topCorners = meshIndices[topIndex]
            let bottomCorners = meshIndices[bottomIndex]

            guard bottomCorners.count == topCorners.count else {
                return []
            }

            assert(bottomCorners.count == topCorners.count)

            let cornerCount = bottomCorners.count

            var tetragons = (1..<cornerCount).map { index -> [UInt16] in
                [
                    bottomCorners[index],
                    bottomCorners[index - 1],
                    topCorners[index - 1],
                    topCorners[index],
                ]
            }

            tetragons.append([
                bottomCorners.first,
                bottomCorners.last,
                topCorners.last,
                topCorners.first
            ].compactMap {
                $0
            })

            let triangles = tetragons.flatMap { tetragon in
                [
                    [
                        tetragon[0],
                        tetragon[1],
                        tetragon[2],
                    ],
                    [
                        tetragon[0],
                        tetragon[2],
                        tetragon[3],
                    ],
                ]
            }

            return triangles
        }

        mesh.enumerated().forEach { index, point in
            print("\(index) (x: \(point.x), y: \(point.y), z: \(point.z))")
        }

        print()

        meshTriangles.enumerated().forEach { index, triangle in
            var line = "\(index): "

            triangle.forEach { point in
                line += "\(point), "
            }

            print(line)
            print()
        }

        assert(meshTriangles.all { $0.count == 3 })


        let buildingGeometry = SCNGeometry(
                sources: [SCNGeometrySource(vertices: mesh)],
                elements: [SCNGeometryElement(indices: meshTriangles.flatMap { $0 }, primitiveType: .triangles)]
        )

        return buildingGeometry
    }
}
