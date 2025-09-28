//
//  BinListViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 10/9/2025.
//

import Cadmus
import SwiftUI
import WhichBinLib
import WhichBinDataSourceLib

class BinListViewModel: ObservableObject {
    
    enum Destination: Hashable {
        case bin(Bin)
    }
    
    enum ViewState {
        case initial
        case loading
        case loaded([Bin])
        case error(Error)
    }

    @Published
    private(set) var viewState: ViewState = .initial
    
    let dataSourceKey: DataSourceRegistry.Key

    init(dataSourceKey: DataSourceRegistry.Key) {
        self.dataSourceKey = dataSourceKey
    }
    
    func binFillColor(for bin: Bin) -> Color {
        bin.fillColor(for: dataSourceKey)
    }
    
    @MainActor
    func loadBins() async {
        guard let dataSource = DataSourceRegistry.shared.dataSource(for: dataSourceKey) else {
            viewState = .error(DataSourceRegistry.Error.invalidDataSource)
            return
        }
        
        viewState = .loading
        
        do {
            let schedules = try await dataSource.load()
            // Get the available bins from the schedules.
            let availableBins = Set<Bin>(
                schedules.flatMap {
                    $0.collectionCycles.map { $0.bin }
                }
            )
            
            let bins = Array(availableBins)
                .sorted { $0.localDescription(for: dataSourceKey) < $1.localDescription(for: dataSourceKey) }
            
            log(debug: "\(bins)")
            
            viewState = .loaded(bins)
        } catch {
            viewState = .error(error)
        }
    }
}
