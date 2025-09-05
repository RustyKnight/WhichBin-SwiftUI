//
//  CLAuthorizationStatus+Helper.swift
//  WhichBin
//
//  Created by Shane Whitehead on 2/9/2025.
//

import CoreLocation
import Cadmus

extension CLAuthorizationStatus {
    
    var isAuthorised: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .notDetermined, .restricted:
            return false
        @unknown default:
            return false
        }
    }
    
    var description: String {
        switch self {
        case .notDetermined:
            "Not determined"
        case .restricted:
            "Restricted"
        case .denied:
            "Denied"
        case .authorizedAlways:
            "Authorized always"
        case .authorizedWhenInUse:
            "Authorized when in use"
        @unknown default:
            "Unknown"
        }
    }
}
