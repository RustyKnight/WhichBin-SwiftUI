//
//  EventModel.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation

public class EventModel {
    // We're doing this so we don't have to
    // try and re-calculate the date each time
    // And this should be renamed ... EventDate? EventAtDate?
    public struct Event: Identifiable, Codable, Hashable, Equatable {
        public var id: String {
            "\(property.day)-\(property.collectionType)"
        }

        let property: Property

        public let date: Date

        public var day: Property.DayOfWeek {
            property.day
        }

        public var collectionType: Property.CollectionType {
            property.collectionType
        }

        init(property: Property, date: Date) {
            self.property = property
            self.date = date
        }
    }
    
    private let properties: [Property]
    
    public private(set) var weekStarting: Date {
        didSet {
            weekEnding = weekStarting
                .adding(days: 6)
                .endOfDay
        }
    }
    public private(set) var weekEnding: Date

    public init(_ properties: [Property]) {
        self.properties = properties
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
    public func nextWeek() -> [Event] {
        weekStarting = weekStarting.adding(days: 7)
        return eventsWithinPeriod()
    }
    
    @discardableResult
    public func previousWeek() -> [Event] {
        weekStarting = weekStarting.adding(days: -7)
        return eventsWithinPeriod()
    }
    
    public func eventsWithinPeriod() -> [Event] {
        return properties.map {
            Event(
                property: $0,
                date: $0.nextEventDateOnOrAfter(weekStarting)
            )
        }
        .filter {
            return $0.date.isBetween(weekStarting, and: weekEnding)
        }
    }

    public func nextEventsOnOrAfterToday() -> [Event] {
        properties.map {
            Event(
                property: $0,
                date: $0.nextEventDateOnOrAfter(.today)
            )
        }
    }
}
