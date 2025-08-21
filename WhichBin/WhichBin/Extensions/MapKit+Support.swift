//
//  MapKit+Support.swift
//  WhichBin
//
//  Created by Shane Whitehead on 22/4/2025.
//

import MapKit
import Contacts

extension MKMapItem {
    var addressDescription: String {
        placemark.addressDescription
    }
}

extension CLPlacemark {
    var addressDescription: String {
        guard let postalAddress else {
            return "---"
        }
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: postalAddress)
    }
}
