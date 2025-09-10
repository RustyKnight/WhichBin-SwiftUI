//
//  SiteView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import SwiftUI

/*
 Make snapshot of the collection area and user location???
 Probably still need a live map view :P
 
 Ability to apply color configuration for each bin type -
 stored based on the site id :P
 */

struct SiteView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var siteManager: SiteManager
    
    @ObservedObject
    var viewModel: SiteViewModel
    
    @State
    var selectLocation = false
    
    @State
    var selectDataSource = false
    
    private let trailingPadding: CGFloat = 36
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    nameView
                        .listRowBackground(Color.background)

                    locationView
                        .listRowBackground(Color.background)

                    descriptionView
                        .listRowBackground(Color.background)

                    dataSourceView
                        .listRowBackground(Color.background)
                }
                
                Section {
                    collectionMapView
                        .listRowBackground(Color.clear)
                }
                
                Section {
                    binsConfigurationView
                        .listRowBackground(Color.background)
                }
                //
                //            Spacer()
                //
                //            HStack {
                //                cancelButton
                //                saveButton
                //            }
            }
            .listStyle(.grouped)
            .listTheme
            
            actionButtons
        }
//        .padding()
//        .background(Color.background.darken(by: 0.4))
        .sheet(isPresented: $selectLocation) {
            LocationView(viewModel: .init(target: $viewModel.locationTarget))
        }
        .sheet(isPresented: $selectDataSource) {
            if let location = viewModel.locationTarget?.location {
                DataSourceListView(viewModel: .init(location: location, dataSourceKey: $viewModel.dataSource))
            } else {
                EmptyView()
            }
        }
        .alert("Unable to save site details", isPresented: $viewModel.saveError) {
            Button.okay()
        }
        .navigationTitle("Site Details")
        .navigationDestination(for: SiteViewModel.Destination.self) { target in
            switch target {
            case .binConfiguration(let key):
                BinListView(viewModel: .init(dataSourceKey: key))
            }
        }
//        .toolbar {
//            saveToolbarButton
//        }
    }
}

private extension SiteView {
    
    var titleView: some View {
        HStack {
            Image.Trash.Circle.unfilled
                .resizable()
                .frame(width: 32, height: 32)
            Text("Site Details")
                .font(.title)
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
        .padding(.bottom, 32)
        .background(Color.background)
    }
    
    var nameView: some View {
        HStack {
            Text("Name")
                .foregroundStyle(.secondary)
            
            Spacer()
            TextField(
                "Friendly Name",
                text: $viewModel.name
            )
            .multilineTextAlignment(.trailing)
            .lineLimit(1)
            .padding(.trailing, trailingPadding)
        }
    }
    
    var locationView: some View {
        Button {
            selectLocation.toggle()
        } label: {
            HStack {
                Text("Location")
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                if let coordinates = viewModel.coordinates {
                    Text("\(coordinates.latitude), \(coordinates.longitude)")
                } else {
                    Text("---")
                }
                
                Image.Chevron.right
                    .foregroundStyle(.secondary)
                    .padding(.leading)
            }
//            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    var descriptionView: some View {
        HStack(alignment: .top) {
            Text("Description")
                .foregroundStyle(.secondary)
            
            Spacer()
            
            TextField(
                "Address or other descriptive details",
                text: $viewModel.description,
                axis: .vertical
            )
            .multilineTextAlignment(.trailing)
            .lineLimit(5...10)
        }
        .padding(.trailing, trailingPadding)
    }
    
    var dataSourceView: some View {
        Button {
            selectDataSource.toggle()
        } label: {
            HStack {
                Text("Collection schedule")
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                if let description = viewModel.dataSourceDescription {
                    Text(description)
                } else {
                    Text("---")
                }
                
                Image.Chevron.right
                    .foregroundStyle(.secondary)
                    .padding(.leading)
            }
//            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(viewModel.locationTarget == nil)
    }
    
    @ViewBuilder
    var binsConfigurationView: some View {
        if let key = viewModel.dataSource {
            HStack {
                NavigationLink(
                    value: SiteViewModel.Destination.binConfiguration(key)
                ) {
                    Text("Bins")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)

                Spacer()
//
//                Image.Chevron.right
//                    .foregroundStyle(.secondary)
//                    .padding(.leading)
            }
//        } else {
//            HStack {
//                Text("Bins")
//                    .foregroundStyle(.secondary)
//
//                Spacer()
//
//                Image.Chevron.right
//                    .foregroundStyle(.secondary)
//                    .padding(.leading)
//            }
        }
    }
}

private extension SiteView {
    @ViewBuilder
    var collectionMapView: some View {
        if let collectionMapViewModel = viewModel.collectionMapViewModel {
            CollectionMapView(viewModel: collectionMapViewModel)
                .frame(height: 256)
        } else {
            EmptyView()
        }
    }
}

private extension SiteView {
    
//    var saveToolbarButton: some View {
//        Button {
//            viewModel.save(siteManager)
//        } label: {
//            Text("Save")
//                .frame(maxWidth: .infinity)
//        }
//        .tint(.tint)
//    }
    
    var actionButtons: some View {
        VStack {
            Divider()
            HStack {
                cancelButton
                saveButton
            }
        }
        .background(Color.listBackground)
    }
    
    var saveButton: some View {
        Button {
            viewModel.save(siteManager)
//            dismiss()
        } label: {
            Text("Save")
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(Color.green)
        .disabled(viewModel.canSave == false)
        
    }
    
    var cancelButton: some View {
        CancelButton {
            dismiss()
        }
    }
}

#Preview {
    SiteView(viewModel: .init())
}
