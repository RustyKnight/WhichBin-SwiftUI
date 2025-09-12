//
//  BinViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import Combine
import SwiftUI
import WhichBinLib

class BinConfigurationViewModel: ObservableObject {
    
    let dataSourceKey: DataSourceRegistry.Key
    let bin: Bin
    
    @Published
    var binFillColor: Color
    
    @Published
    var description: String {
        didSet {
            if description.trimmed.isEmpty {
                // Use the default name if the user clears the
                // description
                description = bin.localisedDescription
            }
        }
    }

    let dismissView = PassthroughSubject<Bool, Never>()

    var canSave: Bool {
        description.isEmpty == false
    }

    init(dataSourceKey: DataSourceRegistry.Key, bin: Bin) {
        self.dataSourceKey = dataSourceKey
        self.bin = bin
        
        self.description = bin.localDescription(for: dataSourceKey)
        self.binFillColor = bin.fillColor(for: dataSourceKey)
    }
    
    func save() {
        UserDefaults.standard.set(
            localDescription: description,
            dataSourceKey: dataSourceKey,
            bin: bin
        )
        
        dismissView.send(true)
    }
}
