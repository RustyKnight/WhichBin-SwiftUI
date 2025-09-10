//
//  BinViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI
import WhichBinLib

class BinConfigurationViewModel: ObservableObject {
    
    let dataSourceKey: DataSourceRegistry.Key
    let bin: Bin
    
    @Published
    var binFillColor: Color
    
    @Published
    var description: String
    
    var canSave: Bool {
        description.isEmpty == false
    }

    init(dataSourceKey: DataSourceRegistry.Key, bin: Bin) {
        self.dataSourceKey = dataSourceKey
        self.bin = bin
        
        self.description = bin.localDescription(for: dataSourceKey)
        self.binFillColor = bin.fillColor(for: dataSourceKey)
    }
}
