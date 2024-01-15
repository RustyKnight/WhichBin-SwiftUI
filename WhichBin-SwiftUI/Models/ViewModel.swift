//
//  ViewModel.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation

class ViewModel: ObservableObject {
    let streetAddress: String?
    let events: EventModel
    
    init(streetAddress: String?, events: EventModel) {
        self.streetAddress = streetAddress
        self.events = events
    }

    func nextWeek() {
        events.nextWeek()
        objectWillChange.send()
    }
    
    func previousWeek() {
        events.previousWeek()
        objectWillChange.send()
    }
}
