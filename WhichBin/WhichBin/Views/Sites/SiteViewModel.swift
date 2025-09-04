//
//  SiteViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import SwiftUI
import WhichBinLib

class SiteViewModel: ObservableObject {

    enum VerificationState {
        case none
        case successful
        case failed
    }

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
    private(set) var isVerifying = false

    @Published
    private(set) var verificationState: VerificationState = .none

    var canVerify: Bool {
        coordinates != nil && dataSource != nil
    }

    var canSave: Bool {
        !name.trimmed.isEmpty &&
        coordinates != nil &&
        !description.trimmed.isEmpty &&
        dataSource != nil
    }

    init() {

    }

    init(site: Site) {
        name = site.name
        description = site.description
        coordinates = site.location
    }
}
