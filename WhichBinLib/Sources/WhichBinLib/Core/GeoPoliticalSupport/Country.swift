//
//  Country.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2025.
//

public struct Country: Hashable, Sendable {
    public let description: String
}

public extension Country {
    static let australia = Country(description: "Australia")
}
