//
//  UserDefaults+SecureShare.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/9/2025.
//

import Foundation

extension UserDefaults {
    convenience init?<R: RawRepresentable>(suiteName: R) where R.RawValue == String {
        self.init(suiteName: suiteName.rawValue)
    }
}

extension UserDefaults {

    static var shared: UserDefaults? {
        UserDefaults(suiteName: Support.Key.appGroupKey)
    }
}
