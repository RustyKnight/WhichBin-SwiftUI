//
//  LocationCoordinate.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 15/4/2025.
//

public struct LocationCoordinate: Codable, Hashable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
