//
//  ScheduleService.swift
//  WhichBin
//
//  Created by Shane Whitehead on 21/9/2025.
//

import WhichBinLib
import WhichBinDataSourceLib
import WhichBinMapKitLib
import Cadmus

struct ScheduleService {
    
    enum Error: Swift.Error {
        case invalidDataSource([Site])
        case failedToLoadSchedule(DataSource, [Site])
    }
    
    struct ScheduleResults {
        let lastEvent: EventGroup?
        let futureEvents: [EventGroup]
        let errors: [Error]
    }
    
    /// Loads all the schedules for all the configured sites and groups
    /// them accordingly.
    /// - Returns: Grouped events and any processing errors.
    static func load() async throws -> ScheduleResults {
        let siteManager = SiteManager.shared
        
        if siteManager.isLoaded == false, let loadError = siteManager.loadError {
            throw loadError
        }
        
        // Group the sites by data source key, so we're not reloading
        // the same data set multiple times.
        let groupedSites = Dictionary(grouping: siteManager.sites) { site in
            site.dataSourceKey
        }
        
        // Build the scheduling...
        var scheduleGroups: [ScheduleGroup] = []
        var errors: [Error] = []
        for (key, sites) in groupedSites {
            guard let dataSource = DataSourceRegistry.shared.dataSource(for: key) else {
                // How do we individualised error handling/reporting...?
                log(warning: "Failed to find data source for \(key)")
                errors.append(.invalidDataSource(sites))
                continue
            }
            
            do {
                let schedules = try await dataSource.load()
                
                for schedule in schedules {
                    let matches = sites.filter { site in
                        schedule.polygon.contains(site.location)
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
                
        let schedules = scheduleGroups.collections()
        
        let past = schedules.past.sorted { $0.date > $1.date }
        let previousSchedule = past.first
        
        return .init(
            lastEvent: previousSchedule,
            futureEvents: schedules.future,
            errors: errors
        )
    }
}
