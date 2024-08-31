//
//  Support.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 30/8/2024.
//

import Foundation

struct Support {
    static var preferredDataSource: URL {
        guard let value = ProcessInfo.processInfo.environment["sample"], let result = Bool(value), result else {
            return URL(string: "https://data.gov.au/data/dataset/0af93e4d-4ef7-4d45-855b-364039c52f98/resource/172777d4-b8dc-4579-a268-acf836da4362/download/frankston-city-council-garbage-collection-zones.json")!
        }
        return Bundle.main.url(forResource: "Sample", withExtension: "json")!
    }
    
    enum Key: String {
        case appGroupKey = "group.org.kaizen.whichbin.widget"
        case location = "location"
        case dataSource = "dataSource"
    }
}
