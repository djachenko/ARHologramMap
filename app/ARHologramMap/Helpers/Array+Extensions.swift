//
// Created by Igor Djachenko on 15/11/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation
import SceneKit

extension Array {
    init(count: Int, generator:(Int) -> Element) {
        self.init()

        (0..<count).forEach({index in
            let element = generator(index)

            append(element)
        })
    }

    func all(_ predicate: (Element) -> Bool) -> Bool {
        for item in self {
            if !predicate(item) {
                return false
            }
        }

        return true
    }

    func any(_ predicate: (Element) -> Bool) -> Bool {
        return !all(predicate)
    }

    func mapToDict<Key: Hashable, Value>(_ transform: (Element) -> (Key, Value)) -> [Key: Value] {
        return [Key: Value](uniqueKeysWithValues: map(transform))
    }
}

extension Array where Element == Bool {
    func all() -> Bool {
        return all { $0 }
    }
}

extension Array where Element == SCNVector3 {
    init(_ floatVectors: [vector_float3]) {
        self.init(floatVectors.map { vector in
            SCNVector3(x: vector[0], y: vector[1], z: vector[2])
        })
    }
}