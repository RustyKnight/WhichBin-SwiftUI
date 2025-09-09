//
//  SitesListViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 6/9/2025.
//

import Cadmus
import SwiftUI

class SitesListViewModel: ObservableObject {
    
    enum Destination: Hashable {
        case site(Site)
    }
    
    let siteManager: SiteManager
    
    @Published
    var deleteError: Bool = false
    
    init(siteManager: SiteManager) {
        self.siteManager = siteManager
    }
    
    func deleteSites(at indexSet: IndexSet) {
        do {
            try siteManager.delete(indexSet)
        } catch {
            log(error: "Failed to delete sites: \(error)")
            deleteError.toggle()
        }
    }
}
