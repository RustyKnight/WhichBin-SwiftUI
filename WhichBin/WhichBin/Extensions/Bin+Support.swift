//
//  Bin+Support.swift
//  WhichBin
//
//  Created by Shane Whitehead on 10/9/2025.
//

import WhichBinLib
import SwiftUI

extension Bin {
    func fillColor(for dataSourceKey: DataSourceRegistry.Key) -> Color {
        let defaults = UserDefaults.standard
        return defaults.color(dataSourceKey: dataSourceKey, bin: self) ?? defaultColor
    }
    
    var defaultColor: Color {
        switch self {
        case .glass: .purple
        case .greenWaste: .green
        case .recycling: .yellow
        case .rubbish: .red
        }
    }
    
    var image: Image {
        switch self {
        case .rubbish: Image("SymbolRubbish")
        case .recycling: Image("SymbolRecycle")
        case .greenWaste: Image("SymbolRecycleGreen")
        case .glass: Image("SymbolRecycleGlass")
        }
    }
}

extension Bin {
    var name: String {
        switch self {
        case .rubbish: "rubbish"
        case .recycling: "recycling"
        case .greenWaste: "greenWaste"
        case .glass: "glass"
        }
    }
}
