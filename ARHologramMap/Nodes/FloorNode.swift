//
// Created by Igor Djachenko on 15/11/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit

class FloorNode: ARHNode {
    private let floor: Floor

    var height: Double {
        return 0 //floor.height
    }

    init(floor: Floor) {
        self.floor = floor

        super.init()

        let plane = SCNPlane()

        plane.firstMaterial?.isDoubleSided = true

        geometry = plane

        let scaleRatio = 0.05
        scale = SCNVector3(scaleRatio, scaleRatio, scaleRatio)

        eulerAngles.x = .pi / 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
