//
// Created by Igor Djachenko on 15/11/2017.
// Copyright (c) 2017 Igor Djachenko. All rights reserved.
//

import Foundation

extension Array {
    init(count: Int, generator:(Int) -> Element) {
        self.init()

        (0..<count).forEach({index in
            let element = generator(index)

            append(element)
        })
    }
}
