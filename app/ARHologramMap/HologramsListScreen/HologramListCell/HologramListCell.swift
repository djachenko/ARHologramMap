//
// Created by Igor Djachenko on 04/02/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import TableKit
import UIKit

class HologramListCell: UITableViewCell, ConfigurableCell {
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(with title: String) {
        titleLabel.text = title
    }
}
