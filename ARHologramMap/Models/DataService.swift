//
// Created by Igor Djachenko on 26/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation

class DataService {
    private struct Registry: Decodable {
        let files: [String]
    }

    static let instance = DataService()

    private init() {}

    func hologramsList() -> [String] {
        guard let data = DataService.readJson(name: "registry") else {
            return []
        }

        guard let registry = try? JSONDecoder().decode(Registry.self, from: data) else {
            return []
        }

        return registry.files
    }

    func hologram(name: String) -> Building? {
        guard let data = DataService.readJson(name: name),
              let building = try? JSONDecoder().decode(Building.self, from: data) else {
            return nil
        }

        return building
    }

    private static func readJson(name: String) -> Data? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }

        return data
    }
}
