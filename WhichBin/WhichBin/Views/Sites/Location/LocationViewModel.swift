//
//  LocationViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import SwiftUI
import MapKit
import CoreExtensions
import Cadmus
import Combine
import SwiftLocation
import os
import Contacts
import WhichBinLib
import WhichBinMapKitLib

class LocationViewModel: ObservableObject {

    enum SearchState {
        case idle
        case results([MKMapItem])
        case error(Error)
    }

    struct Target {
        let description: String
        let location: LocationCoordinate
    }

    @Published
    var searchText: String = ""

    @Published var searchState: SearchState = .idle

    @Published var selectedPlaceMaker: MKPlacemark?

    //@Published var region: MKCoordinateRegion?

    @Binding var target: Target?

    var canTargetCurrentLocation: Bool {
        location.authorizationStatus.isAuthorised
    }

    @Published private(set) var isTargetingLocation = false

    private var searchTask: Task<Void, Never>?
    private var subscribers: Set<AnyCancellable> = []

    private let location: LocationController = .init()

    init(target: Binding<Target?>) {
        self._target = target

        $selectedPlaceMaker.sink { value in
            guard value != nil else { return }
            self.searchState = .idle
            self.clearSearch()
        }
        .store(in: &subscribers)
    }

    func selectLocation() {
        guard let selectedPlaceMaker else { return }

        var description = "Unknown"

        if let postalAddress = selectedPlaceMaker.postalAddress {
            description = CNPostalAddressFormatter().string(from: postalAddress)
        }

        log(debug: "description = \(description)")

        target = .init(
            description: description.trimmed,
            location: selectedPlaceMaker.coordinate.locationCoordinate
        )
    }

    func requestLocationPermission() async {
        guard location.authorizationStatus.isAuthorised == false else { return }

        do {
            try await location.requestPermission(.whenInUse)
        } catch {
            log(error: "Failed to get location permission: \(error.localizedDescription)")
        }
    }

    @MainActor
    func targetCurrentLocation() {
        isTargetingLocation = true
        Task {
            await requestLocationPermission()
            guard location.authorizationStatus.isAuthorised else { return }

            defer {
                isTargetingLocation = false
            }

            do {
                let locations = try await self.location.requestLocation(accuracy: [.horizontal(10.0)])
                guard let target = locations.location else {
                    log(warning: "Failed to get current location")
                    return
                }

                if let marker = try await CLGeocoder().reverseGeocodeLocation(target).first {
                    selectedPlaceMaker = MKPlacemark(placemark: marker)
                } else {
                    selectedPlaceMaker = MKPlacemark(coordinate: target.coordinate)
                }
            } catch {
                log(error: "Failed to get current location: \(error.localizedDescription)")
            }
        }
    }

    func clearSearch() {
        searchText = ""
        searchState = .idle
    }

    func performSearch() {
        searchState = .idle
        guard searchText.trimmed.isEmpty == false else {
            return
        }
        searchTask?.cancel()
        searchTask = Task {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText

            let search = MKLocalSearch(request: request)
            do {
                let results = try await search.start()
                log(debug: "Found = \(results.mapItems.count) matches")
                guard Task.isCancelled == false else {
                    return
                }
                await applySearchResults(results.mapItems)
            } catch {
                log(error: error)
                guard Task.isCancelled == false else {
                    return
                }
                await applyError(error)
            }
        }
    }

    @MainActor
    private func applySearchResults(_ results: [MKMapItem]) {
        searchState = .results(results)
    }

    @MainActor
    private func applyError(_ error: Error) {
        searchState = .error(error)
    }
}
