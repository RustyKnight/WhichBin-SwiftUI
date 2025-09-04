//
//  Site.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import MapKit
import WhichBinLib

struct Site: Codable, Hashable {
    
    /// Friendly name
    let name: String

    /// Intended to provide the address details
    /// of the location
    let description: String

    /// Location coordinates
    let location: LocationCoordinate

    /// The data source that this site is associated with
    let dataSourceKey: DataSourceRegistry.Key
}
//
//extension Site {
//
//    struct Coordinates: Codable, Hashable {
//        let latitude: Double
//        let longitude: Double
//
//        init(latitude: Double, longitude: Double) {
//            self.latitude = latitude
//            self.longitude = longitude
//        }
//
//        init(coordinate: CLLocationCoordinate2D) {
//            self.latitude = coordinate.latitude
//            self.longitude = coordinate.longitude
//        }
//    }
//}
