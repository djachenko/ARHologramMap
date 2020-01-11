//
// Created by Igor Djachenko on 15/11/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit

class ARHologram: ARHNode {
//    private var floors: [FloorFrameNode]! {
//        didSet {
//            if floors == nil {
//                floors = []
//            }
//        }
//    }

//    private let highlight = FloorHighlightNode()

    private let floorHeight: Float = 0.02
    private let floorsCount = 5

    private static let rotationAxis = SCNVector3.yAxis

    var currentFloor = 2 {
        didSet {
            currentFloor = max(0, currentFloor)
            currentFloor = min(floorsCount - 1, currentFloor)

            arrangeFloors(height: floorHeight)
        }
    }

    override init() {
        super.init()

//        floors = [FloorFrameNode](count: floorsCount, generator: {floorIndex in
//            return FloorFrameNode()
//        })

//        floors.forEach({floorNode in
//            addChildNode(floorNode)
//        })

//        addChildNode(highlight)

        addChildNode(BoxNode())

        arrangeFloors(height: floorHeight)
    }

    var collapsed: Bool = false {
        didSet {
            let height = collapsed ? 0 : floorHeight

            arrangeFloors(height: height)
        }
    }

    private func arrangeFloors(height: Float) {
        SCNTransaction.animationDuration = 0.5

//        floors.enumerated().forEach({ (floorIndex, floorNode) in
//            floorNode.position.y = Float(floorIndex) * height
//        })
//
//        highlight.position.y = Float(currentFloor) * height
    }

    func rotate(angle: Float) {
        let rotation = SCNMatrix4MakeRotation(angle, ARHologram.rotationAxis.x, ARHologram.rotationAxis.y, ARHologram.rotationAxis.z)
        let newTransform = SCNMatrix4Mult(transform, rotation)

        transform = newTransform
    }

    func scale(ratio: Float) {
        let scaling = SCNMatrix4MakeScale(ratio, ratio, ratio)

        let newTransform = SCNMatrix4Mult(transform, scaling)

        transform = newTransform
    }
}
