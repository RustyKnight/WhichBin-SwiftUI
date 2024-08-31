//
//  UserDefaults+Shared.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 30/8/2024.
//

import Foundation
import WhichBinLib

public extension UserDefaults {

    static var shared: UserDefaults? {
        UserDefaults(suiteName: Support.Key.appGroupKey)
    }
}
