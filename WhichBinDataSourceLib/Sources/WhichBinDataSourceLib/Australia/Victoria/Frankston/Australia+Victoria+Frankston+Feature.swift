//
//  Frankston+Collection.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import MapKit

extension Australia.Victoria.Frankston {
    struct Feature {
        let geometry: Geometry
        let id: String
        let properties: Property
        let type: String
    }
}

extension Australia.Victoria.Frankston.Feature: Decodable {
    enum CodingKeys: String, CodingKey {
        case geometry
        case id
        case properties
        case type
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type)
        self.id = try container.decode(String.self, forKey: .id)
        self.properties = try container.decode(Property.self, forKey: .properties)
        self.geometry = try container.decode(Australia.Victoria.Frankston.Geometry.self, forKey: .geometry)
    }
}
