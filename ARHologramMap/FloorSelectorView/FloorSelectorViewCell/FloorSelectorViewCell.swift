//
// Created by Igor Djachenko on 07/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import UIKit
import TableKit

class FloorSelectorViewCell: UITableViewCell, ConfigurableCell {
    private(set) static var defaultHeight: CGFloat? = 30

    @IBOutlet private weak var numberLabel: UILabel!

    func configure(with floorNumber: Int) {
        numberLabel.text = String(floorNumber)

        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let color: UIColor

        if selected {
            color = .blue
        }
        else {
            color = .black
        }

        numberLabel.textColor = color
    }
}
