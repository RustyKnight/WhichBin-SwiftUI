//
//  EventModel.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation
import WhichBinLib

class EventModel {
    // We're doing this so we don't have to
    // try and re-calculate the date each time
    // And this should be renamed ... EventDate? EventAtDate?
    struct EventWrapper: Identifiable {
        var id: String {
            "\(sourceEvent.day)-\(sourceEvent.collectionType)"
        }
        let sourceEvent: Event
        let date: Date
    }
    
    private let events: [Event]
    
    private(set) var weekStarting: Date {
        didSet {
            weekEnding = weekStarting
                .adding(days: 6)
                .endOfDay
        }
    }
    private(set) var weekEnding: Date

    init(_ events: [Event]) {
        self.events = events
        let today = Date.today.startOfDay
        weekStarting = today
            .previous(.monday, considerToday: true)
        weekEnding = weekStarting
            .adding(days: 6)
            .endOfDay
        
        // If there are no events remaining for this week, we want to
        // move to the next week instead...
        let events = eventsWithinPeriod()
        let remainingEvents = events.filter { $0.date.startOfDay >= today }
        guard remainingEvents.isEmpty else { return }
        nextWeek()
    }
    
    @discardableResult
    func nextWeek() -> [EventWrapper] {
        weekStarting = weekStarting.adding(days: 7)
        return eventsWithinPeriod()
    }
    
    @discardableResult
    func previousWeek() -> [EventWrapper] {
        weekStarting = weekStarting.adding(days: -7)
        return eventsWithinPeriod()
    }
    
    func eventsWithinPeriod() -> [EventWrapper] {
        return events.map {
            EventWrapper(
                sourceEvent: $0,
                date: $0.nextEventDateOnOrAfter(weekStarting)
            )
        }
        .filter {
            return $0.date.isBetween(weekStarting, and: weekEnding)
        }
    }
}
