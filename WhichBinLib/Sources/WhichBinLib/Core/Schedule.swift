//
//  Schedule.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 11/4/2025.
//

import Foundation

/// Represents a schedule, typically for an area within principality.
/// A given locality could have multiple schedules.
public protocol Schedule: Identifiable, Sendable {
    /// Unique id of schedule.
    var id: String { get }
    /// Polygon describing the area of the collection.
    var polygon: Polygon { get }
    /// Name of schedule.
    var name: String { get }
    /// Collection cycle of schedule.
    var collectionCycles: [CollectionCycle] { get }
    
    /// Returns the next collection events for the schedule.
    /// - Returns: Next collection events for the schedule.
    func nextEvents() -> [Event]

    /// Returns the next collection events for the schedule.
    /// from the supplied date.
    /// - Parameter from: Date from which to calculate the next events.
    /// - Returns: Next collection events for the schedule.
    func nextEvents(from: Date) -> [Event]
}
