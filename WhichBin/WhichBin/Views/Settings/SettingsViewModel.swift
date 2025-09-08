//
//  SettingsViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    enum Destination: Hashable {
        case siteManagement
        case privacy
    }

    let siteManager: SiteManager

    init(siteManager: SiteManager) {
        self.siteManager = siteManager
    }
}
