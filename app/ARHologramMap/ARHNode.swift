//
// Created by Igor Djachenko on 24/10/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit

class ARHNode:SCNNode {
    override init() {
        super.init()
    }

    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
}
