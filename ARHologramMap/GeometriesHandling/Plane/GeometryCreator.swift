//
// Created by Igor Djachenko on 06/02/2018.
// Copyright (c) 2018 Igor Djachenko. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

protocol GeometryCreator {
    func createGeometry(anchor: ARPlaneAnchor) -> SCNGeometry

    func update(node: SCNNode, anchor: ARPlaneAnchor)
}




class TriangleCreator : GeometryCreator {
    func createGeometry(anchor: ARPlaneAnchor) -> SCNGeometry {
        let vertices = [SCNVector3](anchor.geometry.vertices)

        let indices = anchor.geometry.triangleIndices

        let geometrySource = SCNGeometrySource(vertices: vertices)

        let geometryElements = SCNGeometryElement(indices: indices, primitiveType: .triangles)

        let geometry = SCNGeometry(sources: [geometrySource], elements: [geometryElements])

        return geometry
    }

    func update(node: SCNNode, anchor: ARPlaneAnchor) {
        let geometry = createGeometry(anchor: anchor)

        geometry.firstMaterial!.diffuse.contents = UIColor.green

        node.geometry = geometry
    }
}




class MockCreator: TriangleCreator {
    override func createGeometry(anchor: ARPlaneAnchor) -> SCNGeometry {
        let vertices = [
            SCNVector3(x: 0, y: 0, z: 0),
            SCNVector3(x: 1, y: 0, z: 0),
            SCNVector3(x: 0, y: 1, z: 0)
        ]

        let indices = [0, 1, 2]

        let geometrySource = SCNGeometrySource(vertices: vertices)

        let geometryElements = SCNGeometryElement(indices: indices, primitiveType: .triangles)

        let geometry = SCNGeometry(sources: [geometrySource], elements: [geometryElements])

        return geometry
    }

    override func update(node: SCNNode, anchor: ARPlaneAnchor) {
    }
}




class RectangleCreator: GeometryCreator {
    func createGeometry(anchor: ARPlaneAnchor) -> SCNGeometry {
        let plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))

        return plane
    }

    func update(node: SCNNode, anchor: ARPlaneAnchor) {
        guard let plane = node.geometry as? SCNPlane else {
            return
        }

        plane.width = CGFloat(anchor.extent.x)
        plane.height = CGFloat(anchor.extent.z)
    }
}
