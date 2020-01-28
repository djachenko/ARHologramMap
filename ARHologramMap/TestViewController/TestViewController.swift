//
// Created by Igor Djachenko on 07/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import UIKit

class TestViewController: UIViewController {
    @IBOutlet private weak var selectorView: FloorSelectorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        selectorView.floorsCount = 7

        let data = DataService.getJson()!

        do {
            let building = try JSONDecoder().decode(Building.self, from: data)

            let b = building.floors

            let buildingGeometry = BuildingGeometry.build(from: building)

            print(b)

            let a = 7
        }
        catch {
            print(error)
        }

        let a = 7
    }
}
