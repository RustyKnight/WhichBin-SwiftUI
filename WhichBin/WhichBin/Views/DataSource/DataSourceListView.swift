//
//  Untitled.swift
//  WhichBin
//
//  Created by Shane Whitehead on 3/9/2025.
//

import SwiftUI
import WhichBinLib

struct DataSourceListView: View {

    @ObservedObject var viewModel: DataSourceListViewModel

    var body: some View {
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
                    VStack(alignment: .leading) {
                        Text(city.description)
                        if let dataSource = DataSourceRegistry.shared.dataSources[key] {
                            Text(dataSource.name)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .contentMargins(.top, 0)
        .listStyle(GroupedListStyle())
    }

    var groupedByDistanceView: some View {
        List {
            ForEach(viewModel.listByDistance, id: \.id) { item in
                HStack {
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
        }
    }
}
