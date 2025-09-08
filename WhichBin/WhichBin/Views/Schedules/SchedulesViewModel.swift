//
//  SchedulesViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 7/9/2025.
//

import SwiftUI

class SchedulesViewModel: ObservableObject {
    
    enum Destination: Hashable {
        case settings
    }
    
    let siteManager: SiteManager
    
    @Published
    var addNewSite: Bool = false

    @Published
    var manageSites: Bool = false
    
    var hasAvailableSites: Bool {
        siteManager.sites.isEmpty == false
    }
    
    var siteLoadError: Error? {
        switch siteManager.state {
        case .error(let error): error
        default: nil
        }
    }
    
    init(siteManager: SiteManager) {
        self.siteManager = siteManager
    }
    
    // Need to load all the schedules for the
    // available sites
    // Might be nice to be able to load them independently ...??
}
