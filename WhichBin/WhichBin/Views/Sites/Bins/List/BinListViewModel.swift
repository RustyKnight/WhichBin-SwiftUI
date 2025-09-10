//
//  BinListViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 10/9/2025.
//

import SwiftUI
import WhichBinLib
import SwiftUI

class BinListViewModel: ObservableObject {
    
    enum Destination: Hashable {
        case bin(Bin)
    }

    let dataSourceKey: DataSourceRegistry.Key

    init(dataSourceKey: DataSourceRegistry.Key) {
        self.dataSourceKey = dataSourceKey
    }
    
    func binFillColor(for bin: Bin) -> Color {
        bin.fillColor(for: dataSourceKey)
    }
}
