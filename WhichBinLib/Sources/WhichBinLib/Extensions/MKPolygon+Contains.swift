//
//  MKPolygon+Contains.swift
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation
import MapKit

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
