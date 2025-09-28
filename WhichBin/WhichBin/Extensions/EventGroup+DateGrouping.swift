//
//  EventGroup+DateGrouping.swift
//  WhichBin
//
//  Created by Shane Whitehead on 22/9/2025.
//

import Foundation

struct DateGroupedEvent: Identifiable {
    var id: Date { date }
    let date: Date
    let events: [EventGroup]
}

extension [EventGroup] {
    
    var groupedByDate: [DateGroupedEvent] {
        let grouped = Dictionary(grouping: self, by: \.date)
        return grouped.map { (key: Date, value: [EventGroup]) in
            DateGroupedEvent(date: key, events: value)
        }
    }
}
