//
//  MapViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI
import MapKit
import Cadmus
import WhichBinLib
import WhichBinMapKitLib

extension Color {
    static let availableColors: [Color] = [
        .blue,
        .green,
        .yellow,
        .orange,
        .purple,
        .pink,
        .gray,
        .black,
    ]
}

protocol SiteDescribable {
    var name: String { get }
    var location: LocationCoordinate { get }
    var dataSource: DataSource { get }
}

class CollectionMapViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded
        case initial
        case error(Error)
    }
    
    @Published
    private(set) var viewState: ViewState = .initial
    
    @Published
    private(set) var areas: [CollectionArea] = []
    
    @Published
    var position: MapCameraPosition
    
    @Published
    var reload: Bool = false
    
    let site: SiteDescribable
    
    var dataSource: DataSource {
        site.dataSource
    }
    
    var dataSourceName: String? {
        dataSource.name
    }
    
    var siteCoordinate: CLLocationCoordinate2D {
        site.location.coordinate
    }
    
    var anchorCoordinate: CLLocationCoordinate2D {
        return dataSource.generalLocation.coordinate
    }
    
    var mapBounds: MapCameraBounds {
        let minimumRange = 1000.0
        let maximumRange = 50_000.0
        
        if areas.isEmpty {
            return .init(
                centerCoordinateBounds: .init(
                    center: anchorCoordinate,
                    latitudinalMeters: maximumRange,
                    longitudinalMeters: maximumRange
                ),
                minimumDistance: minimumRange,
                maximumDistance: maximumRange
            )
        } else {
            let rect = areas.map { $0.polygon.boundingMapRect }
                .reduce(MKMapRect.null) { $0.union($1) }

            return .init(
                centerCoordinateBounds: rect,
                minimumDistance: minimumRange,
                maximumDistance: maximumRange
            )
        }
    }
    
    init(site: SiteDescribable) {
        self.site = site
        position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: site.location.coordinate,
                span: .init(latitudeDelta: 10000, longitudeDelta: 10000)
            )
        )
    }
    
    @MainActor
    func load() async {
        let colors = Color.availableColors
        do {
            let schedules = try await dataSource.load()
            
            let areas = schedules
                .enumerated()
                .map { (index, value) in
                    let safeIndex = ((index % (colors.count - 1)) + (colors.count - 1) % (colors.count - 1))
                    return CollectionArea(
                        id: value.id,
                        color: colors[safeIndex],
                        area: value.name,
                        polygon: value.polygon.mapMultiPolygon
                    )
                }
            
            self.areas = areas
            self.position = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: anchorCoordinate,
                    span: .init(latitudeDelta: 10000, longitudeDelta: 10000)
                )
            )
        } catch {
            log(error: "Failed to load collection details: \(error)")
        }
    }
}

extension CollectionMapViewModel {
    struct CollectionArea: Identifiable {
        let id: String
        let color: Color
        let area: String
        let polygon: MKMultiPolygon
    }
}

extension Schedule {
    var index: Int {
        Int(String(name.split(separator: " ").last ?? "-1")) ?? -1
    }
}
