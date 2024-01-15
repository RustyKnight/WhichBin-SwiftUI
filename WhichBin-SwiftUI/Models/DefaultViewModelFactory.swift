//
//  DefaultViewModelFactory.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation
import CoreLocation
import Contacts
import WhichBinLib

struct DefaultViewModelFactory: ViewModelFactory {
    private let dataSourceURL = URL(string: "https://data.gov.au/data/dataset/0af93e4d-4ef7-4d45-855b-364039c52f98/resource/172777d4-b8dc-4579-a268-acf836da4362/download/frankston-city-council-garbage-collection-zones.json")!
    // Could replace `home` with CLLocationCoordinate2D(latitude: -38.1468737, longitude: 145.1201503,17)
    private let home = Secrets.home
    
    func make() async throws -> ViewModel {
        async let eventsTask = loadEvents()
        async let addressTask = loadAddress()
        
        let results = try await (addressTask, eventsTask)
        
        return ViewModel(
            streetAddress: results.0,
            events: EventModel(results.1)
        )
    }
    
    private func loadEvents() async throws -> [Event] {
        let (data, _) = try await URLSession.shared.data(from: dataSourceURL)
        let collection = try JSONDecoder().decode(Collection.self, from: data)
        //let collection = try FeatureCollection.build(from: data)
        
        return collection
            .features
            .compactMap { feature -> [Event]? in
                guard feature.polygon?.contains(home) ?? false else {
                    return nil
                }
                return feature.events
            }
            .flatMap { $0 }
    }
    
    private func loadAddress() async throws -> String? {
        let placeMarkers = try await CLGeocoder()
            .reverseGeocodeLocation(
                CLLocation(
                    latitude: home.latitude,
                    longitude: home.longitude
                )
            )
        guard let placeMarker = placeMarkers.first, let address = placeMarker.postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: address)
    }
}
