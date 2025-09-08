//
//  SiteViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import Cadmus
import Combine
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
    
    @Published
    var saveError: Bool = false

    let dismissView = PassthroughSubject<Bool, Never>()
    
    private let originalSiteId: UUID?

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
        originalSiteId = nil
    }

    init(site: Site) {
        name = site.name
        description = site.description
        coordinates = site.location
        originalSiteId = site.id
    }
    
    func save(_ siteManager: SiteManager) {
        guard let locationTarget, let dataSource else { return }
        
        // Need to provide update workflow :/
        let site = Site(
            name: name,
            description: description,
            location: locationTarget.location,
            dataSourceKey: dataSource
        )
        
        do {
            if let originalSiteId {
                try siteManager.remove(siteWithId: originalSiteId)
            }
            try siteManager.add(site: site)
            dismissView.send(true)
        } catch {
            log(error: "Failed to save site details: \(error)")
        }
    }
}
