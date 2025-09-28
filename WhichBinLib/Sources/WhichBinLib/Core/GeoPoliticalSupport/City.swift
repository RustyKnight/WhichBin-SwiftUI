//
//  City.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2025.
//

public struct City: Sendable, Hashable {
    public let description: String
    public let state: State
    
    public init(description: String, state: State) {
        self.description = description
        self.state = state
    }
}
