//
//  Bin+Localised.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import Foundation
import WhichBinLib
import WhichBinDataSourceLib

extension Bin {
    
    var localisedDescription: String {
        switch self {
        case .glass: return "Glass"
        case .greenWaste: return "Green waste"
        case .recycling: return "Recycling"
        case .rubbish: return "General waste"
        }
    }
    
    func localDescription(for key: DataSourceRegistry.Key) -> String {
        let defaults = UserDefaults.standard
        return defaults.localDescription(dataSourceKey: key, bin: self) ?? localisedDescription
    }
}
