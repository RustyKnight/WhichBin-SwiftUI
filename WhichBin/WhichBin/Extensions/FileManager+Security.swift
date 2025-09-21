//
//  FileManager+Security.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/9/2025.
//

import Foundation

extension FileManager {
    
    func containerURL<Value>(forSecurityApplicationGroupIdentifier applicationGroupIdentifier: Value) -> URL? where Value: RawRepresentable, Value.RawValue == String {
        containerURL(forSecurityApplicationGroupIdentifier: applicationGroupIdentifier.rawValue)
    }
}
