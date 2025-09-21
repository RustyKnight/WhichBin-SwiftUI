//
//  Support.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/9/2025.
//

import Foundation

struct Support {

    enum Key: String {
        case appGroupKey = "group.org.kaizen.whichbin.widget"
    }

    static let sharedFolder: URL? = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Support.Key.appGroupKey)
}
