//
//  File.swift
//  
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation
import MapKit

// MARK: - Collection
public struct Collection: Decodable {
    public let type, name: String
    public let features: [Feature]
}
