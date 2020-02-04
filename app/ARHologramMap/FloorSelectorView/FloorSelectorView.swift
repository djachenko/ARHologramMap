//
// Created by Igor Djachenko on 07/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import UIKit
import TableKit

class FloorSelectorView: XibLoadableView {
    @IBOutlet private weak var floorNumbersTableView: UITableView!

    var floorsCount = 0 {
        didSet {
            reloadRows()
        }
    }

    private static var floorStartIndex = 1

    var director: TableDirector!

    override func awakeFromNib() {
        super.awakeFromNib()

        director = TableDirector(tableView: floorNumbersTableView)

        reloadRows()
    }

    private func reloadRows() {
        let rows = (0..<floorsCount)
                .map {
                    $0 + FloorSelectorView.floorStartIndex
                }
                .map { floorNumber in
                    TableRow<FloorSelectorViewCell>(item: floorNumber)
                }

        director.clear()
        director += rows
    }

    private func didTapCell(number: Int) {
        print("tapped cell with number \(number)")
    }
}
