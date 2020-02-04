//
// Created by Igor Djachenko on 07/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation

class BuildingNode: ARHNode {
    private let building: Building

    init(building: Building, floorNodes: [FloorNode]) {
        self.building = building

        super.init()

        floorNodes.forEach { node in
            addChildNode(node)
        }
    }

    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

