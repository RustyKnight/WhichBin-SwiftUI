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

/// Data source registry.
public struct DataSourceRegistry: Sendable{
    
    /// Data source keys.
    public enum Key: String, Sendable, Codable {
        case australiaVictoriaFrankston = "australia.victoria.frankston"
    }
    
    /// Shared instance.
    public static let shared = DataSourceRegistry()
    
    /// Keyed data sources.
    let dataSources: [Key: any DataSource] = [
        Key.australiaVictoriaFrankston: Australia.Victoria.Frankston.DataSource(),
    ]
    
    /// Data source by key.
    /// - Parameter key: Data source key.
    /// - Returns: Data source for key.
    public func dataSource(for key: Key) -> (any DataSource)? {
        dataSources[key]
    }
    
    /// All available data datas.
    public var availableDataSources: [(key: Key, value: any DataSource)] {
        dataSources.map { ($0, $1) }
    }
}
