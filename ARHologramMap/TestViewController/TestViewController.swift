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
    }
}
