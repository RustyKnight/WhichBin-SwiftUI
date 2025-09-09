//
//  MapView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI
import MapKit

struct CollectionMapView: View {

    @ObservedObject
    var viewModel: CollectionMapViewModel

    var body: some View {
        Map(
            position: $viewModel.position,
            bounds: viewModel.mapBounds,
            interactionModes: [.all],
            scope: nil
        ) {
            Marker(viewModel.site.name, coordinate: viewModel.siteCoordinate)
            if let name = viewModel.dataSourceName {
                Marker(name, coordinate: viewModel.anchorCoordinate)
            }
            
            ForEach(viewModel.areas) { area in
                ForEach(area.polygon.polygons, id: \.self) { poly in
                    MapPolygon(poly)
                        .stroke(area.color, lineWidth: 1)
                        .foregroundStyle(area.color.opacity(0.5))
                }
            }
            
            UserAnnotation()
        }
        .task {
            await viewModel.load()
        }
    }
}
