//
//  DateComponentsFormatter+DaysFormatter.swift
//  
//
//  Created by Shane Whitehead on 9/8/2024.
//

import Foundation

public extension DateComponentsFormatter {
    
    static let days: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day]
        formatter.unitsStyle = .full
        return formatter
    }()
}
