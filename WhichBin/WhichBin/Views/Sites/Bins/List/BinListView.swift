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
    
    var body: some View {
        List {
            ForEach(Bin.allCases) { bin in
                binView(bin)
                    .listRowBackground(Color.background)
            }
        }
        .listStyle(.grouped)
        .listTheme
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
    }
}

extension BinListView {
    
    func binView(_ bin: Bin) -> some View {
        NavigationLink(value: BinListViewModel.Destination.bin(bin)) {
            HStack {
                Text(bin.name.capitalized)
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
