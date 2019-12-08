//
// Created by Igor Djachenko on 23/10/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit

let SCNVector3Identity = SCNVector3(1, 1, 1)

extension SCNVector3 {
    static let zero = SCNVector3(0, 0, 0)
    static let identity = SCNVector3(1, 1, 1)

    static let xAxis = SCNVector3(1, 0, 0)
    static let yAxis = SCNVector3(0, 1, 0)
    static let zAxis = SCNVector3(0, 0, 1)

    var length:Float {
        get {
            return sqrtf(x * x + y * y + z * z)
        }
    }

    func normalize() -> SCNVector3 {
        return SCNVector3(
                x / length,
                y / length,
                z / length
        )
    }

    static func /(left: SCNVector3, factor: CGFloat) -> SCNVector3 {
        return left / Double(factor)
    }

    static func /(left: SCNVector3, factor: Float) -> SCNVector3 {
        return left / Double(factor)
    }

    static func /(left: SCNVector3, factor: Double) -> SCNVector3 {
        return SCNVector3(
                Double(left.x) / factor,
                Double(left.y) / factor,
                Double(left.z) / factor
        )
    }

    static func *(left: SCNVector3, factor: CGFloat) -> SCNVector3 {
        return left * Double(factor)
    }

    static func *(left: SCNVector3, factor: Float) -> SCNVector3 {
        return left * Double(factor)
    }

    static func *(left: SCNVector3, factor: Double) -> SCNVector3 {
        return SCNVector3(
                Double(left.x) * factor,
                Double(left.y) * factor,
                Double(left.z) * factor
        )
    }

    static func -(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(
                left.x - right.x,
                left.y - right.y,
                left.z - right.z
        )
    }

    static func -=(left: inout SCNVector3, right: SCNVector3) {
        left = left - right
    }

    static prefix func -(vector: SCNVector3) -> SCNVector3 {
        return SCNVector3(
                -vector.x,
                -vector.y,
                -vector.z
        )
    }

    init(unifiedValue: Float) {
        self.init(x: unifiedValue, y: unifiedValue, z: unifiedValue)
    }
}
