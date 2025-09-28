//
//  Polygon+Containas.swift
//  WhichBinDataSourceLib
//
//  Created by Shane Whitehead on 28/9/2025.
//

import WhichBinLib

public extension WhichBinLib.Polygon {
    
    func contains(_ location: LocationCoordinate) -> Bool {
        mapMultiPolygon.contains(location.coordinate)
    }
}
