//
//  DataSource.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import MapKit

/*
 Going to need some kind of look up system to find available data sources :P
 */

/// Source of collection data.
public protocol DataSource: Sendable {
    /// Loads the collection schedule.
    /// - Returns: Collection schedule.
    func load() async throws -> [any Schedule]

    var name: String { get }
    var generalLocation: LocationCoordinate { get }
    var city: City { get }
}
