//
//  LocationCoordinate.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 15/4/2025.
//

/// Location coordinate
public struct LocationCoordinate: Codable, Hashable {
    
    /// Latitude.
    public let latitude: Double
    
    /// Longitude.
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
