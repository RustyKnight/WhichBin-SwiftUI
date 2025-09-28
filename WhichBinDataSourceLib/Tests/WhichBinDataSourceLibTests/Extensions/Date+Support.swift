//
//  Date+Support.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 16/9/2025.
//

import Foundation

extension Date {
    
    func set(hour: Int, minute: Int = 0, second: Int = 0) -> Date {
        Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: self)!
    }
    
    static func set(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        return Calendar.current.date(from: components)!
    }
}
