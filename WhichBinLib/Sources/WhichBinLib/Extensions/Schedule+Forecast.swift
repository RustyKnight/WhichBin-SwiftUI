//
//  Schedule+Forecast.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 12/9/2025.
//

import Foundation
import CoreExtensions

public extension Schedule {
    
    /// Returns a forecast of future events.
    /// - Parameters:
    ///   - weeks: Number of weeks in the future to be included.
    ///   - date: Events to be included after the date.
    /// - Returns: Collection events.
    func forecast(forWeeksAhead weeks: Int, after date: Date = .today) -> [any Event] {
        // If `date` is the start of the week, the algorithm would skip this week
        // entirely, so we subtract 1 day in order to capture it.
        // This does have the side effect of been an "inclusive" capture.
        let calendar = Calendar.autoupdatingCurrent
        let firstWeekDay = calendar.firstDayOfWeek
        
        let anchorDate = calendar.date(byAdding: .day, value: -1, to: date)!.startOfDay
        var startOfWeek = calendar.next(firstWeekDay, after: anchorDate)
        
        var allEvents = [any Event]()
        for _ in 0..<weeks {
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!.endOfDay

            let events = nextEvents(from: startOfWeek)
                .filter { event in
                    event.date <= endOfWeek
                }
            
            allEvents.append(contentsOf: events)

            startOfWeek = calendar.date(byAdding: .day, value: 1, to: endOfWeek)!.startOfDay
        }
        
        return allEvents
    }

}

public extension [Schedule] {
    
    /// Returns a forecast of future events.
    /// - Parameters:
    ///   - weeks: Number of weeks in the future to be included.
    ///   - date: Events to be included after the date.
    /// - Returns: Collection events.
    func forecast(forWeeksAhead weeks: Int, after date: Date = .today) -> [any Event] {
        flatMap { schedule in
            schedule.forecast(
                forWeeksAhead: weeks,
                after: date
            )
        }
    }
}
