//
//  WidgetModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/9/2025.
//

import Foundation
import WhichBinLib
import WidgetKit

struct WidgetModel: TimelineEntry, Codable, Hashable {
    
    let date: Date
    
    let debugDetails: String?
    
    init(date: Date, debugDetails: String? = nil) {
        self.date = date
        self.debugDetails = debugDetails
    }
    
}

extension WidgetModel {
    static var sample: WidgetModel {
        let targetDate = Calendar
            .autoupdatingCurrent
            .next(.wednesday)
            .startOfDay
        return WidgetModel(date: targetDate)
    }
}
