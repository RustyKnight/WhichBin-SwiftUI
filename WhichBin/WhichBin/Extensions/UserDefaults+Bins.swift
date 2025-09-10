//
//  UserDefaults+Bins.swift
//  WhichBin
//
//  Created by Shane Whitehead on 10/9/2025.
//

import Foundation
import SwiftUI
import WhichBinLib

extension UserDefaults {
    
    func color(dataSourceKey: DataSourceRegistry.Key, bin: Bin) -> Color? {
        color(forKey: Self.key(dataSourceKey: dataSourceKey, bin: bin))
    }

    func set(_ value: Color, dataSourceKey: DataSourceRegistry.Key, bin: Bin) {
        set(value, forKey: Self.key(dataSourceKey: dataSourceKey, bin: bin))
    }

    static func key(dataSourceKey: DataSourceRegistry.Key, bin: Bin) -> String {
        "\(dataSourceKey.rawValue).\(bin.name)"
    }
    
    func set(_ value: Color, forKey key: String) {
        let rgb = UIColor(value).asRGBA
        let stringValue = "\(rgb.red),\(rgb.green),\(rgb.blue),\(rgb.alpha)"
        set(stringValue, forKey: key)
    }
    
    func color(forKey key: String) -> Color? {
        guard let stringValue = string(forKey: key) else { return nil }
        let parts = stringValue.split(separator: ",")
        let values = parts.compactMap { Double($0) }
        guard values.count == 4 else { return nil }
        
        return Color(
            UIColor(
                red: values[0],
                green: values[1],
                blue: values[2],
                alpha: values[3]
            )
        )
    }
    
    func localDescription(dataSourceKey: DataSourceRegistry.Key, bin: Bin) -> String? {
        string(forKey: Self.key(dataSourceKey: dataSourceKey, bin: bin))
    }
    
    func set(localDescription: String, dataSourceKey: DataSourceRegistry.Key, bin: Bin) {
        set(localDescription, forKey: Self.key(dataSourceKey: dataSourceKey, bin: bin))
    }
}
