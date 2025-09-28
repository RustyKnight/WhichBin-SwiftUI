//
//  State.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2025.
//

public struct State: Hashable, Sendable {
    public let description: String
    public let country: Country
    
    public init(description: String, country: Country) {
        self.description = description
        self.country = country
    }
}
