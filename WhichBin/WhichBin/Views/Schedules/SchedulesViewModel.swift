//
//  SchedulesViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 7/9/2025.
//

import Cadmus
import SwiftUI
import WhichBinLib

class SchedulesViewModel: ObservableObject {
    
    enum Destination: Hashable {
        case settings
    }
    
    enum ViewState {
        case initial
        case loading
        case loaded(ScheduleService.ScheduleResults)
        case error(Swift.Error)
    }
    
    let siteManager: SiteManager
    
    @Published
    var viewState: ViewState = .initial
    
    @Published
    var addNewSite: Bool = false

    @Published
    var manageSites: Bool = false
    
    var hasAvailableSites: Bool {
        siteManager.sites.isEmpty == false
    }
    
    var siteLoadError: Swift.Error? {
        switch siteManager.state {
        case .error(let error): error
        default: nil
        }
    }
    
    var dayDateStyle: Date.FormatStyle {
        Date.FormatStyle()
            .day()
            .month(.abbreviated)
            .year()
            .weekday(.abbreviated)
    }
    
    init(siteManager: SiteManager) {
        self.siteManager = siteManager
    }
    
    @MainActor
    func load() async {
        viewState = .loading
        
        do {
            let scheduleResults = try await ScheduleService.load()
            viewState = .loaded(scheduleResults)
        } catch {
            viewState = .error(error)
        }
    }
}
