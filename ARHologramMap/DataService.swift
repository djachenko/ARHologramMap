//
// Created by Igor Djachenko on 26/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation

class DataService {
    static func getJson() -> Data? {
        guard let path = Bundle.main.path(forResource: "cube", ofType: "json") else {
            return nil
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }

        return data
    }
}
