//
// Created by Igor Djachenko on 15/11/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit

class FloorNode: ARHNode {
    override init() {
        super.init()

        let plane = SCNPlane()

        plane.firstMaterial?.isDoubleSided = true

        geometry = plane

        let scaleRatio = 0.05
        scale = SCNVector3(scaleRatio, scaleRatio, scaleRatio)

        eulerAngles.x = .pi / 2
    }
}
