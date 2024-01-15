//
//  Geometry.swift
//
//
//  Created by Shane Whitehead on 14/1/2024.
//

import Foundation
import MapKit

// So, again, the structure isn't great
// Since this structure is only carrying a single property
// and it's source structure is transformed to support
// the `MKMultiPolygon` (arguably we pushing a data
// structure back onto the caller they might not what,
// but for simplicity in this case, we'll keep it)
// the structure itself has no value outside of
// the library context, so we keep it for internally
// parsing only
struct Geometry: Decodable {
    enum GeometryType: String, Decodable {
        case multiPolygon = "MultiPolygon"
        case polygon = "Polygon"
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }

    public let polygon: MKMultiPolygon?
    
    public init(polygon: MKMultiPolygon?) {
        self.polygon = polygon
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(GeometryType.self, forKey: .type)
            
        if type == .multiPolygon {
            let coordinates = try container.decode([[[[Double]]]].self, forKey: .coordinates)
            polygon = Geometry.parseMultiPolygon(coordinates: coordinates)
        } else if type == .polygon {
            let coordinates = try container.decode([[[Double]]].self, forKey: .coordinates)
            polygon = MKMultiPolygon(Geometry.parsePolygon(coordinates: coordinates))
        } else {
            polygon = nil
        }
    }
    
    private static func parseMultiPolygon(coordinates: [[[[Double]]]]) -> MKMultiPolygon {
        var polys = [MKPolygon]()
        for polygon in coordinates {
            polys.append(contentsOf: parsePolygon(coordinates: polygon))
        }
        return MKMultiPolygon(polys)
    }
    
    private static func parsePolygon(coordinates: [[[Double]]]) -> [MKPolygon] {
        // Look into how we could use map to remove the loops :/
        var polys = [MKPolygon]()
        for polygon in coordinates {
            var points = [CLLocationCoordinate2D]()
            for point in polygon {
                let lng = point[0]
                let lat = point[1]
                
                points.append(CLLocationCoordinate2D(latitude: lat, longitude: lng))
            }
            polys.append(MKPolygon(coordinates: points, count: points.count))
        }
        return polys
    }
}
