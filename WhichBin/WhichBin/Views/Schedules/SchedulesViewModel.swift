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
    
    enum Error: Swift.Error {
        case invalidDataSource([Site])
        case failedToLoadSchedule(DataSource, [Site])
    }
    
    enum ViewState {
        case initial
        case loading
        case loaded([EventGroup], [Error])
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
        
        // Group the sites by data source key, so we're not reloading
        // the same data set multiple times.
        let groupedSites = Dictionary(grouping: siteManager.sites) { site in
            site.dataSourceKey
        }

        // Build the scheduling...
        var scheduleGroups: [ScheduleGroup] = []
        var errors: [Error] = []
        for (key, sites) in groupedSites {
            guard let dataSource = DataSourceRegistry.shared.dataSources[key] else {
                // How do we individualised error handling/reporting...?
                log(warning: "Failed to find data source for \(key)")
                errors.append(.invalidDataSource(sites))
                continue
            }
            
            do {
                let schedules = try await dataSource.load()
                
                for schedule in schedules {
                    let matches = sites.filter { site in
                        schedule.polygon.mapMultiPolygon.contains(site.location.coordinate)
                    }
                    
                    guard matches.isEmpty == false else { continue }
                    
                    let scheduleGroup = ScheduleGroup(
                        dataSourceKey: key,
                        dataSource: dataSource,
                        schedule: schedule,
                        sites: matches
                    )
                    
                    scheduleGroups.append(scheduleGroup)
                }
            } catch {
                log(error: "Failed to load schedules for \(key): \(error)")
                errors.append(.failedToLoadSchedule(dataSource, sites))
            }
        }
        
        let nextSchedules = scheduleGroups.collections()
        
        viewState = .loaded(nextSchedules, errors)
    }
}
