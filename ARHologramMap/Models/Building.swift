//
// Created by Igor Djachenko on 07/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation

struct Building {
    let floors: [Int: Floor]
    let default_height: Real
}

extension Building: Decodable {
}