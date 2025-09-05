//
//  SiteViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import SwiftUI
import WhichBinLib

class SiteViewModel: ObservableObject {

    @Published
    var name: String = ""

    @Published
    var description: String = ""

    @Published
    var coordinates: LocationCoordinate?

    @Published
    var locationTarget: LocationViewModel.Target? {
        didSet {
            guard let locationTarget else { return }
            description = locationTarget.description
            coordinates = locationTarget.location
        }
    }

    @Published
    var dataSource: DataSourceRegistry.Key?

    var canSave: Bool {
        !name.trimmed.isEmpty &&
        coordinates != nil &&
        !description.trimmed.isEmpty &&
        dataSource != nil
    }
    
    var dataSourceDescription: String? {
        guard let dataSource else { return nil }
        return DataSourceRegistry.shared.dataSources[dataSource]?.name
    }

    init() {

    }

    init(site: Site) {
        name = site.name
        description = site.description
        coordinates = site.location
    }
}
