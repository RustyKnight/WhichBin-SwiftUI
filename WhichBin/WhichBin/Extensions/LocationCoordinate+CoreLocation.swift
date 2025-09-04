//
//  LocationCoordinate+CoreLocation.swift
//  WhichBin
//
//  Created by Shane Whitehead on 4/9/2025.
//

import WhichBinLib
import CoreLocation

extension LocationCoordinate {
    var coreLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
