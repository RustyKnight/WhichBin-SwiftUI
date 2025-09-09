//
//  Site.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import Foundation
import MapKit
import WhichBinLib

struct Site: Codable, Hashable, Identifiable {
    
    let id: UUID
    
    /// Friendly name
    let name: String

    /// Intended to provide the address details
    /// of the location
    let description: String

    /// Location coordinates
    let location: LocationCoordinate

    /// The data source that this site is associated with
    let dataSourceKey: DataSourceRegistry.Key
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        location: LocationCoordinate,
        dataSourceKey: DataSourceRegistry.Key
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.location = location
        self.dataSourceKey = dataSourceKey
    }
}

extension Site {
    var dataSource: DataSource? {
        DataSourceRegistry.shared.dataSources[dataSourceKey]
    }
}
