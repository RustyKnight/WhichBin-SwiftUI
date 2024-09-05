//
//  WidgetModel.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 29/8/2024.
//

import Foundation
import WhichBinLib
import WidgetKit

struct WidgetModel: TimelineEntry, Codable, Hashable {
    let date: Date

    let eventsDate: Date?
    let previousEventDate: Date?
    let events: [EventModel.Event]

    let debugDetails: String?

    init(date: Date = Date().endOfDay, eventsDate: Date?, previousEventDate: Date?, events: [EventModel.Event], debugDetails: String? = nil) {
        self.date = date
        self.eventsDate = eventsDate
        self.previousEventDate = previousEventDate
        self.events = events
        self.debugDetails = debugDetails
    }
}

extension WidgetModel {
    func expired(at expiryDate: Date) -> WidgetModel {
        WidgetModel(
            date: expiryDate,
            eventsDate: eventsDate,
            previousEventDate: previousEventDate,
            events: events
        )
    }
}

extension WidgetModel {
    static var sample: WidgetModel {
        let targetDate = Date().next(.wednesday).startOfDay
        let previousEventDate = Date().previous(.wednesday).endOfDay
        return WidgetModel(
            eventsDate: targetDate,
            previousEventDate: previousEventDate,
            events: EventModel.sampleEvents(targetDate)
        )
    }
}
