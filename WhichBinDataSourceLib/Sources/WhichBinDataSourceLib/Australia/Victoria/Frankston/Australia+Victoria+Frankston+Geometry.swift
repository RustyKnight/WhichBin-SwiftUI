//
//  Australia+Victoria+Frankston+Geometry.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import WhichBinLib

extension Australia.Victoria.Frankston {
    struct Geometry {
        public let polygon: Polygon
    }
}

extension Australia.Victoria.Frankston.Geometry: Decodable {
    enum GeometryType: String, Decodable {
        case multiPolygon = "MultiPolygon"
        case polygon = "Polygon"
    }

    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(GeometryType.self, forKey: .type)

        if type == .multiPolygon {
            let coordinates = try container.decode([[[[Double]]]].self, forKey: .coordinates)
            polygon = Polygon(coordinates)
        } else if type == .polygon {
            let coordinates = try container.decode([[[Double]]].self, forKey: .coordinates)
            polygon = Polygon(coordinates)
        } else {
            throw ParserError.unknownValue(type.rawValue, forProperty: "Geometry.Type")
        }
    }
}
