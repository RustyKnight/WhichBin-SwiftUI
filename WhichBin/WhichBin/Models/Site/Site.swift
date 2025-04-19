//
//  Site.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import MapKit

struct Site: Codable, Hashable {
    /// Friendly name
    let name: String
    /// Intended to provide the address details
    /// of the location
    let description: String
    /// Location coordinates
    let location: Coordinates
}

extension Site {
    struct Coordinates: Codable, Hashable {
        let latitude: Double
        let longitude: Double
    }
}
