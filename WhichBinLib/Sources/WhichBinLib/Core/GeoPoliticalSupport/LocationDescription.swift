//
//  LocationDescription.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2025.
//

public struct LocationDescription: Codable, Hashable {
    public let country: String
    public let state: String
    public let city: String

    init(country: String, state: String, city: String) {
        self.country = country
        self.state = state
        self.city = city
    }
}
