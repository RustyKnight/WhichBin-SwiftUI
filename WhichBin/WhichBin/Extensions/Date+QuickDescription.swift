//
//  Date+QuickDescription.swift
//  WhichBin
//
//  Created by Shane Whitehead on 16/9/2025.
//

import Foundation

extension Date {
    
    var quickDescription: String {
        Date.FormatStyle().weekday(.abbreviated).day().month(.abbreviated).year().format(self)
    }
}
