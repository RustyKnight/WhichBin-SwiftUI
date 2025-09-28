//
//  DataSourceRegistry.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 14/4/2025.
//

/*
 Need some way to look up data sources by "key" name...
 */

import WhichBinLib

public struct DataSourceRegistry: Sendable{

    public enum Key: String, Sendable, Codable {
        case australiaVictoriaFrankston = "australia.victoria.frankston"
    }

    public static let shared = DataSourceRegistry()

    public let dataSources: [Key: any DataSource] = [
        Key.australiaVictoriaFrankston: Australia.Victoria.Frankston.DataSource(),
    ]

    public func dataSource(for key: Key) -> (any DataSource)? {
        dataSources[key]
    }

    public var availableDataSources: [(Key, any DataSource)] {
        dataSources.map { ($0, $1) }
    }
}
