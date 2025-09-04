//
//  CLAuthorizationStatus+Helper.swift
//  WhichBin
//
//  Created by Shane Whitehead on 2/9/2025.
//

import CoreLocation

extension CLAuthorizationStatus {
    
    var isAuthorized: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .notDetermined, .restricted:
            return false
        @unknown default:
            return false
        }
    }
}
