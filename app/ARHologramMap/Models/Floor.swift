//
// Created by Igor Djachenko on 07/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation

struct Floor {
    let floor: [Point2D]
    let ceiling: [Point2D]?
    let height: Real?
}

extension Floor: Decodable {
}