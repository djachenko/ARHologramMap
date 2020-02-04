//
// Created by Igor Djachenko on 07/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import Reusable
import UIKit

class XibLoadableView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    private func initialize() {
        let nibName = String(describing: type(of: self))

        let nib = UINib(nibName: nibName, bundle: .main)

        let rootView = nib.instantiate(withOwner: self).first as! UIView

        rootView.frame = bounds
        rootView.isOpaque = isOpaque

        backgroundColor = .clear

        addSubview(rootView)

        rootView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]

        rootView.translatesAutoresizingMaskIntoConstraints = true
    }
}