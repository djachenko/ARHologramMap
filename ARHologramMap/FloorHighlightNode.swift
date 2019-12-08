//
// Created by Igor Djachenko on 15/11/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit
import UIKit

class FloorHighlightNode: FloorNode {
    override init() {
        super.init()

        geometry?.firstMaterial?.diffuse.contents = UIImage(named: "floor_highlight")
    }
}
