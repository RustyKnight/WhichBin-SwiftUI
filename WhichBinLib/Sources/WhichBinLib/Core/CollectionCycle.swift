//
//  CollectionCycle.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 12/4/2025.
//

import Foundation
import CoreExtensions

/// Describes the collection cycle used for a given bin.
public protocol CollectionCycle: Sendable {
    /// The bin.
    var bin: Bin { get }

    /// The day of the week the bin is collected
    var dayOfTheWeek: Calendar.Weekday { get }
    
    /// Calculates the next collection date from today
    /// - Returns: The next collection after today.
    func nextEvent() -> Event
    
    /// Calculates the next collection date from the supplied date.
    /// - Parameter from: Anchor date.
    /// - Returns: Next collection date from the supplied date.
    func nextEvent(from: Date) -> Event
}
