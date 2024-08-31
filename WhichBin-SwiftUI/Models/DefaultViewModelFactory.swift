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
    private let dataSourceURL = Support.preferredDataSource
    private let home = Secrets.home
    
    func make() async throws -> ViewModel {
        async let eventsTask = loadEvents()
        async let addressTask = loadAddress()
        
        let results = try await (addressTask, eventsTask)
        
        return ViewModel(
            streetAddress: results.0,
            events: results.1
        )
    }
    
    private func loadEvents() async throws -> EventModel {
        try await EventModelFactory(targetLocation: home, dataSourceURL: dataSourceURL).load()
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
