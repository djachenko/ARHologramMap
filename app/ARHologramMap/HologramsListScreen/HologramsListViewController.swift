//
// Created by Igor Djachenko on 04/02/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import UIKit
import TableKit

class HologramsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var hologramScreenModeSwitch: UISwitch!

    private var tableDirector: TableDirector!

    private var presenter = HologramsListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Models"

        tableDirector = TableDirector(tableView: tableView)

        presenter.viewController = self

        presenter.loaded()
    }

    func update(titles: [String]) {
        let rows = titles.map { [unowned self] title -> TableRow<HologramListCell> in
            TableRow<HologramListCell>(item: title)
                    .on(.click) { options in
                        self.selected(item: options.item)
                    }
        }

        tableDirector.clear()
        tableDirector += rows
    }

    private func selected(item: String) {
        presenter.selected(item: item)
    }

    func open(hologram: Hologram) {
        let vc: UIViewController & Hologrammable

        if hologramScreenModeSwitch.isOn {
            vc = ARHologramViewController()
        }
        else {
            vc = SceneHologramViewController()
        }

        vc.set(hologram: hologram)

        navigationController?.pushViewController(vc, animated: true)
    }
}
