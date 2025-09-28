//
//  Polygon.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 11/4/2025.
//

/*
 The reason this is done here was to reduce the reliance on MapKit
 */

/// Simple description of a polygon.
/// This supports multiple polygons
public struct Polygon: Sendable {
    /// Points of polygon
    public let points: [[[[Double]]]]

    public init(_ points: [[[[Double]]]]) {
        self.points = points
    }

    public init (_ points: [[[Double]]]) {
        self.points = [points]
    }
}
