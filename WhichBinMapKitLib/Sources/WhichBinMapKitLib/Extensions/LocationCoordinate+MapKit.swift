//
//  LocationCoordinate+MapKit.swift
//  WhichBinMapKitLib
//
//  Created by Shane Whitehead on 28/9/2025.
//

import MapKit
import WhichBinLib

public extension LocationCoordinate {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }

    var location: CLLocation {
        return CLLocation(
            latitude: latitude,
            longitude: longitude
        )
    }
}

public extension LocationCoordinate {
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

public extension CLLocationCoordinate2D {
    
    var locationCoordinate: LocationCoordinate {
        return LocationCoordinate(self)
    }
}
