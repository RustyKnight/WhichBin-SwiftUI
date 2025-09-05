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

class DataSourceListViewModel: ObservableObject {
    // Would really like a target location if
    // possible :P

    enum ViewType: String, Identifiable, CaseIterable {
        case location = "By location"
        case distance = "By distance"

        var id: String { rawValue }
    }

    enum VerificationState {
        case unknown
        case verifying
        case verified(Bool)
        case error(Error)
    }

    struct DataSourceDistance: Identifiable {
        let id = UUID()
        let key: DataSourceRegistry.Key
        let dataSource: DataSource
        let distance: Measurement<UnitLength>
    }

    let location: LocationCoordinate
    let groupedByLocation: [Tree]
    let listByDistance: [DataSourceDistance]

    @Published var selectedViewType: ViewType = .location

    @Published
    private(set) var verificationState: VerificationState = .unknown
    
    var isVerifyingCollection: Bool {
        switch verificationState {
        case .verifying: true
        default: false
        }
    }

    init(location: LocationCoordinate) {
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

    /*
     Verification step should take place when the user
     selects the data source.  A alert should be presented
     to the user if the location is out side the
     collection area and they should have the option
     to use it or not.
     
     Maybe show a map?!?
     */
    
    @MainActor
    func verifyDataSource(_ key: DataSourceRegistry.Key) async {
        log(debug: "Verifying ... \(key)")
        verificationState = .unknown
        
        guard let dataSource = DataSourceRegistry.shared.dataSources[key] else {
            log(debug: "Unknown data source: \(key)")
            return
        }

        log(debug: "Verifying data source: \(key)")
        verificationState = .verifying

        do {
            let coordinate = location.coreLocation.coordinate
            let schedules = try await dataSource.load()

            let contains = schedules.contains { schedule in
                schedule.polygon.mapMultiPolygon.contains(coordinate)
            }

            try? await Task.sleep(for: .seconds(5))
            
            log(debug: "Data source verified: \(key) \(contains)")
            verificationState = .verified(contains)
        } catch {
            log(error: "Failed to load data source \(key): \(error)")
            verificationState = .error(error)
        }
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
