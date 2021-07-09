//
//  UIButton.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 09/07/21.
//

import UIKit

extension UIButton {
    func roundedBorder() {
        self.layer.cornerRadius = 8
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}
