//
// Created by Igor Djachenko on 13/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import SceneKit

class Plane {
    private(set) var equation: (SCNVector3) -> Float
    private(set) var representation: String

    init(A: Float, B: Float, C: Float, D: Float) {
        equation = { point in
            A * point.x +
            B * point.y +
            C * point.z +
            D
        }

        representation = "\(A)x + \(B)y + \(C)z + \(D) = 0"
    }

    convenience init?(points: [SCNVector3]) {
        let coefficients = Plane.countCoefficients(points: Array(points[0..<3]))

        self.init(
                A: coefficients.A,
                B: coefficients.B,
                C: coefficients.C,
                D: coefficients.D
        )

        guard points.map(contains(point:)).all() else {
            return nil
        }
    }

    func contains(point: SCNVector3) -> Bool {
        let diffValue = equation(point)

        return diffValue.isEqual(to: 0)
    }

    func update(points: [SCNVector3]) {
        let coefficients = Plane.countCoefficients(points: Array(points[0..<3]))

        let A = coefficients.A
        let B = coefficients.B
        let C = coefficients.C
        let D = coefficients.D

        equation = { point in
            A * point.x +
            B * point.y +
            C * point.z +
            D
        }

        representation = "\(A)x + \(B)y + \(C)z + \(D) = 0"

        guard points.map(contains(point:)).all() else {
            assertionFailure()
            
            return
        }
    }

    private static func countCoefficients(points: [SCNVector3]) -> (A: Float, B: Float, C: Float, D: Float) {
        guard points.count >= 3 else {
            fatalError()
        }

        let a = points[0]
        let b = points[1]
        let c = points[2]

        let ab = b - a
        let ac = c - a

        let cross = SCNVector3.crossProduct(a: ab, b: ac).normalize()

        let A = cross.x
        let B = cross.y
        let C = cross.z

        let D = -(A * a.x + B * a.y + C * a.z)

        return (A: A, B: B, C: C, D: D)
    }
}
