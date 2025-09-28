//
//  Untitled.swift
//  WhichBin
//
//  Created by Shane Whitehead on 3/9/2025.
//

import SwiftUI
import WhichBinLib
import WhichBinDataSourceLib

/*
    We should allow for the displaying of a map showing
    the collection area, with the specified location ...
 */

struct DataSourceListView: View {

    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: DataSourceListViewModel

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                titleView
                
                segmentView
                
                if viewModel.selectedViewType == .distance {
                    groupedByDistanceView
                } else {
                    groupedByLocationView
                }
                
                Spacer()
            }
            .background(Color.listBackground)

            if viewModel.isVerifyingCollection {
                verificationView
            }
        }
        .alert(
            "Outside of bounds",
            isPresented: $viewModel.collectionVerificationOutsideOfLocationBounds,
            actions: {
                /// Add a button that opens the article URL.
                Button("No") {
                }
                /// Make it the default action on the alert
                .keyboardShortcut(.defaultAction)
                
                /// Add a generic OK button.
                Button("Yes") {
                    viewModel.selectOutOfBoundsDataSource()
                }
            }, message: {
                    Text(
                        """
                        The site location is not within selected collection bounds.
                        
                        Do you wish to use it anyway?
                        """
                    )
            }
        )
        .onReceive(viewModel.dismissView) { shouldDismiss in
            if shouldDismiss {
                self.dismiss()
            }
        }
    }
}

private extension DataSourceListView {

    var titleView: some View {
        HStack {
            Image(systemName: "trash.circle")
                .resizable()
                .frame(width: 32, height: 32)
            Text("Collection Schedules")
                .font(.title)
            Spacer()
        }
        .padding(.top, .Padding.standard)
        .padding(.bottom, .Padding.extraLarge)
        .padding(.horizontal)
    }

    var segmentView: some View {
        Picker("", selection: $viewModel.selectedViewType) {
            ForEach(DataSourceListViewModel.ViewType.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .padding(.bottom, .Padding.small)
    }

    var groupedByLocationView: some View {
        List {
            OutlineGroup(
                viewModel.groupedByLocation,
                id: \.id,
                children: \.children
            ) { item in
                switch item.value {
                case .country(let country):
                    Text(country.description)

                case .state(let state):
                    Text(state.description)

                case .city(let city, let key):
                    Button {
                        Task {
                            await viewModel.verifyDataSource(key)
                        }
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(city.description)
                                if let dataSource = DataSourceRegistry.shared.dataSource(for: key) {
                                    Text(dataSource.name)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .listTheme
    }

    var groupedByDistanceView: some View {
        List {
            ForEach(viewModel.listByDistance, id: \.id) { item in
                Button {
                    Task {
                        await viewModel.verifyDataSource(item.key)
                    }
                } label: {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(item.dataSource.name)
                            Text(item.dataSource.locationDescription)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                        Spacer()

                        Text(item.distanceDescription)
                    }
                }
                .listRowBackground(Color.background)
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
            }
        }
        .listTheme
    }
    
    var verificationView: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack {
                    if viewModel.isLocationWithCollectionBounds {
                        Image.Checkmark.Circle.filled
                            .size(.large32)
                            .foregroundStyle(.green)
                        Text("Validation Successful")
                            .font(.title)
                        Text("Site location is within the collection area")
                            .multilineTextAlignment(.center)
                    } else if viewModel.isLocationOutsideCollectionBounds {
                        Image.Multiply.Circle.filled
                            .size(.large32)
                            .foregroundStyle(.red)
                        Text("Validation Failed")
                            .font(.title)
                        Text("Site location is not within the collection area")
                            .multilineTextAlignment(.center)
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .controlSize(.extraLarge)
                            .padding(.bottom, .Padding.standard)
                        
                        Text("Validating collection area")
                            .font(.title)
                            .multilineTextAlignment(.center)
                        Text("Please wait")
                            .font(.body)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGroupedBackground))
                .cornerRadius(.Padding.standard)
                Spacer()
            }
            Spacer()
        }
        .background(.secondary.opacity(0.9))
    }
}
