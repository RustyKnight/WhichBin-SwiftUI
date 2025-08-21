//
//  SiteViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import SwiftUI

class SiteViewModel: ObservableObject {

    @Published
    var name: String = ""

    @Published
    var description: String = ""

    @Published
    var coordinates: Site.Coordinates?

    init() {

    }

    init(site: Site) {
        name = site.name
        description = site.description
        coordinates = site.location
    }
}
