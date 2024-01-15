//
//  Feature.swift
//
//
//  Created by Shane Whitehead on 14/1/2024.
//

import Foundation
import MapKit

public struct Feature: Decodable {
    public enum FeatureType: String, Decodable {
        case feature = "Feature"
        case unkown
    }
    
    public let type: FeatureType
    public let polygon: MKMultiPolygon?
    public let events: [Event]

    enum CodingKeys: CodingKey {
        case type
        case geometry
        case properties
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(Feature.FeatureType.self, forKey: .type)
        
        // The `geometry` structure is just a container for a single polygon
        // so it doesn't add any value outside of the library context
        let geometry = try container.decode(Geometry.self, forKey: .geometry)
        polygon = geometry.polygon
        
        // The `properties` structure is just a container for unstructured events
        // so we doesn't really need to expose it, since we transform the contents
        // anyway it doesn't serve any real purpose outside of the library context
        let properties = try container.decode(Properties.self, forKey: .properties)

        events = properties.events
    }
}
