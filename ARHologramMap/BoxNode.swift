//
// Created by Igor Djachenko on 15/11/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit
import UIKit

class BoxNode: ARHNode {
    override init() {
        super.init()

        let size: CGFloat = 0.02

        let box = SCNBox(width: size, height: size, length: size, chamferRadius: 0)

        box.firstMaterial?.diffuse.contents = UIColor.green

        geometry = box
    }
}
