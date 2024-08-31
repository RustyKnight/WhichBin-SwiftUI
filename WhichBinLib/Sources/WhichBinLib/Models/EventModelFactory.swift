//
//  EventModelFactory.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 29/8/2024.
//

import Foundation
import CoreLocation

public struct EventModelFactory {

    public let targetLocation: CLLocationCoordinate2D
    public let dataSourceURL: URL

    public init(targetLocation: CLLocationCoordinate2D, dataSourceURL: URL) {
        self.targetLocation = targetLocation
        self.dataSourceURL = dataSourceURL
    }

    public func load() async throws -> EventModel {
        let (data, _) = try await URLSession.shared.data(from: dataSourceURL)
        let collection = try JSONDecoder().decode(Collection.self, from: data)

        let propertiesWithinLocation = collection
            .features
            .compactMap { feature -> [Property]? in
                guard feature.polygon?.contains(targetLocation) ?? false else {
                    return nil
                }
                return feature.properties
            }
            .flatMap { $0 }

        return EventModel(propertiesWithinLocation)
    }

}
