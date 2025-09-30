//
//  LocationView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import SwiftUI
import MapKit
import Combine
import Contacts

struct LocationView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject
    var viewModel: LocationViewModel
    
    @FocusState private var searchFieldFocused: Bool

    var body: some View {
        VStack {
            searchField
                .padding(.leading)
                .padding(.trailing)

            ZStack(alignment: .bottom) {
                mapView
                    .onTapGesture {
                        searchFieldFocused = false
                    }
                if case .results(let results) = viewModel.searchState {
                    searchResultsView(results)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if viewModel.isTargetingLocation {
                            ProgressView()
                                .standard(size: .extraLarge32)
                        } else {
                            locationButton
                        }
                    }
                    HStack {
                        cancelButton

                        selectButton
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea(.all, edges: [.bottom])
        .task {
            await viewModel.requestLocationPermission()
        }
    }
}

private extension LocationView {

    func searchResultsView(_ results: [MKMapItem]) -> some View {
        List(results, id: \.self) { item in
            Text("\(item.addressDescription)")
                .onTapGesture {
                    searchFieldFocused = false
                    viewModel.selectedPlaceMaker = item.placemark
                }
        }
        .scrollContentBackground(.hidden)
    }

    var searchField: some View {
        HStack {
            Image.magnifyingGlass
                .foregroundStyle(.secondary)

            DebounceTextField("Search", text: $viewModel.searchText, focused: $searchFieldFocused) { value in
                viewModel.performSearch()
            }
            .padding()
            
            Button {
                viewModel.clearSearch()
            } label: {
                Image.Multiply.Circle.filled
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.searchForeground, .searchBackground)
            }

        }
    }

    var mapView: some View {
        Map(interactionModes: [.all]) {
            UserAnnotation()

            if let placeMarker = viewModel.selectedPlaceMaker, let location = placeMarker.location {
                Marker(
                    placeMarker.addressDescription,
                    coordinate: location.coordinate
                )
            }
        }
    }

    var locationButton: some View {
        Button {
            viewModel.targetCurrentLocation()
        } label: {
            if viewModel.isTargetingLocation {
                ProgressView()
            } else {
                Image.Location.circle
                    .resizable()
                    .standard(size: .extraLarge32)
                    .foregroundStyle(.secondary)
            }
        }
        .buttonStyle(.plain)
        .disabled(viewModel.canTargetCurrentLocation == false)
    }

    var selectButton: some View {
        Button {
            viewModel.selectLocation()
            dismiss()
        } label: {
            Text("Select")
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(Color.blue)
        .disabled(viewModel.selectedPlaceMaker == nil)
    }

    var cancelButton: some View {
        CancelButton {
            dismiss()
        }
    }

}
