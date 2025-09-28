//
//  Polygon+MapKit.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 11/4/2025.
//

import MapKit
import WhichBinLib

public extension WhichBinLib.Polygon {
    
   var mapMultiPolygon: MKMultiPolygon {
       points.multiPolygon
    }
}

extension Array where Element == [[Double]] {
    
    var polygons: [MKPolygon] {
        var polys = [MKPolygon]()
        for polygon in self {
            var points = [CLLocationCoordinate2D]()
            for point in polygon {
                let lng = point[0]
                let lat = point[1]

                points.append(
                    CLLocationCoordinate2D(
                        latitude: lat,
                        longitude: lng
                    )
                )
            }
            polys.append(MKPolygon(coordinates: points, count: points.count))
        }
        return polys
    }
}

extension Array where Element == [[[Double]]] {
    
    var multiPolygon: MKMultiPolygon {
        var polys = [MKPolygon]()
        for coordinates in self {
            polys.append(contentsOf: coordinates.polygons)
        }
        return MKMultiPolygon(polys)
    }
}
