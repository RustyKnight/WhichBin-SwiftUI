//
//  Date+StartEndOfDate.swift
//
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation

public extension Date {
    var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    var endOfDay: Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }

    static var today: Date {
        Date()
    }
}

public extension Date {
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        get(
            .next,
            weekday,
            considerToday: considerToday
        )
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        get(
            .previous,
            weekday,
            considerToday: considerToday
        )
    }
    
    func get(
        _ direction: SearchDirection,
        _ weekDay: Weekday,
        considerToday consider: Bool = false
    ) -> Date {
        let dayName = weekDay.rawValue
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        let calendar = Calendar(identifier: .gregorian)
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex
        
        let date = calendar.nextDate(
            after: self,
            matching: nextDateComponent,
            matchingPolicy: .nextTime,
            direction: direction.calendarSearchDirection
        )
        
        return date!
    }
    
}

// MARK: Helper methods
public extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }

}

public extension Date {
    func adding(days: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
}

public extension Date {
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}
