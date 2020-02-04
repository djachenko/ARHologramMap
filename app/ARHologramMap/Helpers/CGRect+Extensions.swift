//
// Created by Igor Djachenko on 16/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import CoreGraphics

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + width / 2, y: origin.y + height / 2)
    }
}