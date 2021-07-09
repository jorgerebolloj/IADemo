//
//  RoundButton.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 09/07/21.
//

import UIKit

class RoundButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setBorder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setBorder()
    }

    private func setup() {
        layer.cornerRadius = 8
    }

    private func setBorder() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
}
