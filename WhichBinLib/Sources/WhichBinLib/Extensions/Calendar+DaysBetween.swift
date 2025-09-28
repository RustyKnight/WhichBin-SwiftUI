//
//  Calendar+DaysBetween.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2024.
//

import Foundation

public extension Calendar {
    /// Calculates the number of days between two dates
    /// - Parameters:
    ///   - from: From date
    ///   - to: To date
    /// - Returns: Days between dates.
    func daysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = from.startOfDay
        let toDate = to.startOfDay
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>

        return numberOfDays.day!
    }
}

public extension Date {
    func daysBetween(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.daysBetween(self, and: date)
    }
}
