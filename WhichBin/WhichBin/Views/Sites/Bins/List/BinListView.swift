//
//  BinListView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 10/9/2025.
//

import SwiftUI
import WhichBinLib

struct BinListView: View {
    
    @ObservedObject
    var viewModel: BinListViewModel
    
    // Available bins should be defined by the data source???
    
    var body: some View {
        contentView
            .toolbarTheme
            .navigationTitle("Bins")
            .navigationDestination(for: BinListViewModel.Destination.self) { target in
                switch target {
                case .bin(let bin):
                    BinConfigurationView(
                        viewModel: .init(
                            dataSourceKey: viewModel.dataSourceKey,
                            bin: bin
                        )
                    )
                }
            }
            .task {
                await viewModel.loadBins()
            }
    }
}

extension BinListView {
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.viewState {
        case .initial, .loading:
            loadingView
            
        case .loaded(let bins):
            binListView(bins)
            
        case .error(let error):
            errorView(error)
        }
    }
    
    var loadingView: some View {
        VStack {
            Text("Loading...")
                .font(.title)
                .foregroundStyle(.primary)
            
            Text("I know, this is so exciting...")
                .foregroundStyle(.secondary)
        }
        .containerRelativeFrame(
            [.horizontal, .vertical],
            alignment: .center
        )
        .background(Color.listBackground)
    }
    
    func binListView(_ bins: [Bin]) -> some View {
        List {
            ForEach(bins) { bin in
                binView(bin)
                    .listRowBackground(Color.background)
            }
        }
        .listStyle(.grouped)
        .listTheme
    }
    
    func errorView(_ error: Error) -> some View {
        VStack {
            Text("Failed to load bin details")
                .font(.title)
                .foregroundStyle(.primary)
            
            Text("\(error.localizedDescription)")
                .foregroundStyle(.secondary)
        }
        .containerRelativeFrame(
            [.horizontal, .vertical],
            alignment: .center
        )
        .background(Color.listBackground)
    }
}

extension BinListView {
    
    func binView(_ bin: Bin) -> some View {
        NavigationLink(value: BinListViewModel.Destination.bin(bin)) {
            HStack {
                Text(bin.localDescription(for: viewModel.dataSourceKey).capitalized)
                Spacer()
                
                let binColor = viewModel.binFillColor(for: bin)
                
                bin
                    .image
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(binColor)

                WheelyBinView(
                    strokeStyle: binColor.brighten(by: 0.5),
                    strokeWidth: 2,
                    fillColor: binColor,
                    size: .large24
                )
            }
        }
        .buttonStyle(.plain)
    }
}
