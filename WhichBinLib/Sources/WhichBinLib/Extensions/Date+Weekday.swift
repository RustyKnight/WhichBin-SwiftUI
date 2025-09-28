//
//  Date+Date+Weekday.swift
//
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation
import CoreExtensions


public extension Date {
    
    /// Weekday representation which supports decoding
    /// and some other features.
    enum Weekday: String, Decodable, CaseIterable, Sendable {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
        
        public var calendarValue: Int {
            switch self {
            case .sunday: return 1
            case .monday: return 2
            case .tuesday: return 3
            case .wednesday: return 4
            case .thursday: return 5
            case .friday: return 6
            case .saturday: return 7
            }
        }
        
        /// Convert to `Calendar.Weekday`
        public var calendarWeekday: Calendar.Weekday {
            switch self {
            case .sunday: Calendar.Weekday.sunday
            case .monday: Calendar.Weekday.monday
            case .tuesday: Calendar.Weekday.tuesday
            case .wednesday: Calendar.Weekday.wednesday
            case .thursday: Calendar.Weekday.thursday
            case .friday: Calendar.Weekday.friday
            case .saturday: Calendar.Weekday.saturday
            }
        }
    }
    
    /// Weekday from current `Date`.
    var weekday: Int {
        Calendar.current.component(.weekday, from: self)
    }
}
