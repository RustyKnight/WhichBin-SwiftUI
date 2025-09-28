//
//  Frankston+Collection.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import MapKit

extension Australia.Victoria.Frankston {
    struct Collection {
        public let type: String
        public let features: [Feature]
    }
}

extension Australia.Victoria.Frankston.Collection: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case boundingBox = "bbox"
        case features
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type)
        self.features = try container.decode([Australia.Victoria.Frankston.Feature].self, forKey: .features)
    }
}
