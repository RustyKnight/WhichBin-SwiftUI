//
//  Event.swift
//
//
//  Created by Shane Whitehead on 14/1/2024.
//

import Foundation

public struct Event {
    public enum CollectionType {
        case rubbish
        case recycling
        case green
        case glass
    }
    
    public enum DayOfWeek: String, Decodable {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
        
        var weekday: Date.Weekday {
            switch self {
            case .monday: return .monday
            case .tuesday: return .tuesday
            case .wednesday: return .wednesday
            case .thursday: return .thursday
            case .friday: return .friday
            case .saturday: return .saturday
            case .sunday: return .sunday
            }
        }
    }

    public let day: DayOfWeek
    public let weeks: Int
    public let epoch: Date
    public let collectionType: CollectionType
}

public extension Event {
    var nextDate: Date {
        nextEventDateOnOrAfter(Date())
    }
    
    func nextEventDateOnOrAfter(_ date: Date) -> Date {
        let anchor = date.endOfDay
        var date = epoch.endOfDay
        //var nextPeriod = anchor.next(day.weekday, considerToday: true).endOfDay
        let calendar = Calendar.current
        while date <= anchor {
            date = calendar.date(byAdding: .day, value: 7 * weeks, to: date)!.endOfDay
        }
        return date
    }
}
