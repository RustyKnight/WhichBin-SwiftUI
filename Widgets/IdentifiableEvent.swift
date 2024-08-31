//
//  File.swift
//  
//
//  Created by Shane Whitehead on 9/8/2024.
//

import Foundation
import WhichBinLib

struct IdentifiableEvent: Identifiable {
    var id: String {
        "\(sourceEvent.date)-\(sourceEvent.day)-\(sourceEvent.collectionType)"
    }
    let sourceEvent: EventModel.Event
}

extension Array where Element == EventModel.Event {
    func mapToIdentifiableEvents() -> [IdentifiableEvent] {
        map { IdentifiableEvent(sourceEvent: $0) }
    }
}
