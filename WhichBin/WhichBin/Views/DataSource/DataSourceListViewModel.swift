//
//  DataSourceListViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 3/9/2025.
//

import SwiftUI
import WhichBinLib

class DataSourceListViewModel: ObservableObject {
    // Would really like a target location if
    // possible :P

    enum ViewType: String, Identifiable, CaseIterable {
        case location = "By location"
        case distance = "By distance"

        var id: String { rawValue }
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
