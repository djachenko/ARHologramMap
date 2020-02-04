//
// Created by Igor Djachenko on 04/02/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation

class HologramsListPresenter {
    weak var viewController: HologramsListViewController?

    private let dataService = DataService.instance

    func loaded() {

        let hologramsList = dataService.hologramsList()

        viewController?.update(titles: hologramsList)
    }

    func selected(item: String) {
        guard let building = dataService.hologram(name: item) else {
            return
        }

        viewController?.open(hologram: building)
    }
}
