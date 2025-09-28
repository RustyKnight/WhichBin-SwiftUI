//
//  MapKit+Support.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 11/4/2025.
//

import Foundation
import MapKit
import WhichBinLib

// This needs to move to a different library...

public extension MKPolygon {
    
    func contains(_ coor: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPoint(coor)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        return polygonRenderer.path.contains(polygonViewPoint)
    }
}

public extension MKMultiPolygon {
    
    func contains(_ coor: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer = MKMultiPolygonRenderer(multiPolygon: self)
        let currentMapPoint: MKMapPoint = MKMapPoint(coor)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        return polygonRenderer.path.contains(polygonViewPoint)
    }
}
