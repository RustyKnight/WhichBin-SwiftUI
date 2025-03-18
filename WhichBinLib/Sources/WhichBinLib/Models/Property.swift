//
//  Event.swift
//
//
//  Created by Shane Whitehead on 14/1/2024.
//

import Foundation

public func == (lhs: Property, rhs: Property) -> Bool {
    lhs.collectionType == rhs.collectionType &&
    lhs.day == rhs.day &&
    lhs.weeks == rhs.weeks &&
    lhs.epoch == rhs.epoch
}

public struct Property: Codable, Hashable, Equatable {
    public enum CollectionType: Int, Codable {
        case rubbish = 0
        case recycling
        case green
        case glass
    }
    
    public enum DayOfWeek: String, Codable {
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
    public let weeks: Double
    public let epoch: Date
    public let collectionType: CollectionType

    public init(day: DayOfWeek, weeks: Double, epoch: Date, collectionType: CollectionType) {
        self.day = day
        self.weeks = weeks
        self.epoch = epoch
        self.collectionType = collectionType
    }
}

public extension Property {
    var nextDate: Date {
        nextEventDateOnOrAfter(Date())
    }
    
    func nextEventDateOnOrAfter(_ date: Date) -> Date {
        let anchor = date.startOfDay
        var date = epoch.endOfDay
        let calendar = Calendar.current
        while date <= anchor {
            date = calendar.date(byAdding: .day, value: Int(ceil(7.0 * weeks)), to: date)!.endOfDay
        }
        return date
    }

    func nextEventDateAfter(_ date: Date) -> Date {
        let anchor = date.startOfDay
        var date = epoch.endOfDay
        let calendar = Calendar.current
        while date <= anchor {
            date = calendar.date(byAdding: .day, value: Int(ceil(7 * weeks)), to: date)!.endOfDay
        }
        return date
    }
}
