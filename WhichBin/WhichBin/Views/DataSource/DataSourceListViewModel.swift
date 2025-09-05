//
//  DataSourceListViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 3/9/2025.
//

import Cadmus
import SwiftUI
import WhichBinLib
import WhichBinMapKitLib
import Combine

class DataSourceListViewModel: ObservableObject {
    // Would really like a target location if
    // possible :P

    enum ViewType: String, Identifiable, CaseIterable {
        case location = "By location"
        case distance = "By distance"

        var id: String { rawValue }
    }

    enum VerificationState {
        case unverified
        case withinBounds
        case outsideBounds
        case error(Error)
    }

    struct DataSourceDistance: Identifiable {
        let id = UUID()
        let key: DataSourceRegistry.Key
        let dataSource: DataSource
        let distance: Measurement<UnitLength>
    }

    @Published var selectedViewType: ViewType = .location

    @Published
    private(set) var verificationState: VerificationState = .unverified
    
    @Published
    var isVerifyingCollection = false
    
    @Published
    var collectionVerificationOutsideOfLocationBounds: Bool = false
    
    @Binding
    var dataSourceKey: DataSourceRegistry.Key? {
        didSet {
            guard dataSourceKey != nil else { return }
            dismissView.send(true)
        }
    }

    let location: LocationCoordinate
    let groupedByLocation: [Tree]
    let listByDistance: [DataSourceDistance]

    var isLocationWithCollectionBounds: Bool {
        switch verificationState {
        case .withinBounds: true
        default: false
        }
    }
    
    var isLocationOutsideCollectionBounds: Bool {
        switch verificationState {
        case .outsideBounds: true
        default: false
        }
    }
    
    var verificationDidError: Bool {
        switch verificationState {
        case .error: true
        default: false
        }
    }
    
    var dismissView = PassthroughSubject<Bool, Never>()
    
    private var outOfBoundsDataSource: DataSourceRegistry.Key?

    init(location: LocationCoordinate, dataSourceKey: Binding<DataSourceRegistry.Key?>) {
        self._dataSourceKey = dataSourceKey
        self.location = location

        groupedByLocation = DataSourceRegistry.shared.grouped

        let coreLocation = location.coreLocation
        listByDistance = DataSourceRegistry.shared.dataSources.map {
            let key = $0.key
            let value = $0.value
            let distance = coreLocation.distance(from: value.generalLocation.coreLocation)

            return .init(
                key: key,
                dataSource: value,
                distance: Measurement<UnitLength>(
                    value: distance,
                    unit: .meters
                )
            )
        }
    }
    
    func selectOutOfBoundsDataSource() {
        dataSourceKey = outOfBoundsDataSource
    }
    
    @MainActor
    func verifyDataSource(_ key: DataSourceRegistry.Key) async {
        outOfBoundsDataSource = nil
        verificationState = .unverified
        isVerifyingCollection = true
        
        guard let dataSource = DataSourceRegistry.shared.dataSources[key] else {
            log(debug: "Unknown data source: \(key)")
            return
        }

        log(debug: "Verifying data source: \(key)")

        do {
            let coordinate = location.coreLocation.coordinate
            let schedules = try await dataSource.load()

            let contains = schedules.contains { schedule in
                schedule.polygon.mapMultiPolygon.contains(coordinate)
            }

            log(debug: "Data source verified: \(key) \(contains)")
            verificationState = contains ? .withinBounds : .outsideBounds

            if contains {
                try? await Task.sleep(for: .seconds(1))
                
                dataSourceKey = key
            } else {
                outOfBoundsDataSource = key
                isVerifyingCollection.toggle()
                collectionVerificationOutsideOfLocationBounds.toggle()
            }
        } catch {
            log(error: "Failed to load data source \(key): \(error)")
            verificationState = .error(error)
        }
        
        isVerifyingCollection = false
    }
}

extension DataSourceListViewModel.DataSourceDistance {
    var distanceDescription: String {
        distance.formatted(
            .measurement(
                width: .abbreviated,
                usage: .general,
                numberFormatStyle: .number.precision(.fractionLength(0...1))
            )
        )
    }
}
