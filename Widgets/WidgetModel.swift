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
    let events: [EventModel.Event]

    let debugDetails: String?

    init(date: Date = Date().endOfDay, eventsDate: Date?, events: [EventModel.Event], debugDetails: String? = nil) {
        self.date = date
        self.eventsDate = eventsDate
        self.events = events
        self.debugDetails = debugDetails
    }
}

extension WidgetModel {
    static var sample: WidgetModel {
        let targetDate = Date().next(.wednesday).startOfDay
        return WidgetModel(
            eventsDate: targetDate,
            events: EventModel.sampleEvents(targetDate)
        )
    }
}
