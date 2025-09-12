//
//  ScheduleGroup.swift
//  WhichBin
//
//  Created by Shane Whitehead on 11/9/2025.
//

import CoreExtensions
import Foundation
import WhichBinLib

// We should be able to generate future schedules
// from this information ...
//
// This would then need to be consolidate in some meaningful manner
// for presentation :/

struct ScheduleGroup {
    let dataSourceKey: DataSourceRegistry.Key
    let dataSource: any DataSource
    let schedule: any Schedule
    let sites: [Site]
}

struct EventGroup {
    let scheduleGroup: ScheduleGroup
    let date: Date
    let bins: [Bin]
}

//typealias CollectionScheduleEvents = (next: [EventGroup], forecast: [EventGroup])

extension ScheduleGroup: CustomStringConvertible {
    var description: String {
        "Schedule \(schedule.id); sites: \(sites.map(\.name).joined(separator: ", "))"
    }
}

extension [ScheduleGroup] {
    
    private func nextCollection(for group: ScheduleGroup, from date: Date) -> EventGroup? {
        // Get the next collection events for this group
        let events = group.schedule.nextEvents(from: date)
        let groupedEvents = Dictionary(grouping: events, by: \.date)
        guard let earliestDate = groupedEvents.keys.sorted().first, let earliestEvents = groupedEvents[earliestDate] else {
            return nil
        }
        
        let bins = earliestEvents.map { $0.bin }
        
        return .init(
            scheduleGroup: group,
            date: earliestDate,
            bins: bins
        )
    }
    
    private func nextCollections(from date: Date) -> [EventGroup] {
        let events = compactMap { group in
            nextCollection(for: group, from: date)
        }
        
        return events
    }
    
    /// Collection of all the next events grouped
    /// by date.
    /// - Returns: Collection of all the next events.
    func nextCollections() -> [Date: [EventGroup]] {
        // Group all the events by date.
        let groupedEvents = Dictionary(grouping: nextCollections(from: Date.today), by: \.date)
        
        return groupedEvents
    }

    private func forecasts() -> [EventGroup] {
        let calendar = Calendar.autoupdatingCurrent
        let firstWeekDay = calendar.firstDayOfWeek
        
        let startDate = calendar.previous(firstWeekDay, after: .today)
        
        return flatMap { schedule in
            // Get the forecast and group them
            // by date
            let events = Dictionary(
                grouping: schedule.schedule.forecast(forWeeksAhead: 4, after: startDate),
                by: \.date
            )
            
            // Transform the events
            return events.map { (key: Date, values: [any Event]) in
                EventGroup(
                    scheduleGroup: schedule,
                    date: key,
                    bins: values.map(\.bin))
            }
        }
    }
    
    func collections() -> [EventGroup] {
        forecasts()
            .filter { eventGroup in
                eventGroup.date >= Date.today
            }
    }
}
