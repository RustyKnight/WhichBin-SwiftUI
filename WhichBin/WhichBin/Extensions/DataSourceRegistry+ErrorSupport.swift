//
//  DataSourceRegistry+ErrorSupport.swift
//  WhichBin
//
//  Created by Shane Whitehead on 11/9/2025.
//

import Foundation
import WhichBinLib

extension DataSourceRegistry {
    
    enum Error: Swift.Error, LocalizedError {
        case invalidDataSource
        
        var errorDescription: String? {
            switch self {
            case .invalidDataSource:
                "Invalid or unknown data source."
            }
        }
        
        var failureReason: String? {
            switch self {
            case .invalidDataSource:
                "The data source may no longer be available or has changed name."
            }
        }
    }
    
}
