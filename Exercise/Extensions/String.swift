//
//  String.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
