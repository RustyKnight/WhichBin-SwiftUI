//
//  String+Localization.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 4/9/2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
