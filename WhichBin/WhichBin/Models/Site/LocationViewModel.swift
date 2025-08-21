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

class LocationViewModel: ObservableObject {

    enum SearchState {
        case idle
        case results([MKMapItem])
        case error(Error)
    }

    @Published
    var searchText: String = ""

    @Published var searchState: SearchState = .idle

    @Published var selectedPlaceMaker: MKPlacemark?

    @Published var region: MKCoordinateRegion?

    private var searchTask: Task<Void, Never>?
    private var subscribers: Set<AnyCancellable> = []

    init() {
        $selectedPlaceMaker.sink { value in
            guard value != nil else { return }
            self.searchState = .idle
            self.clearSearch()
        }
        .store(in: &subscribers)
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
