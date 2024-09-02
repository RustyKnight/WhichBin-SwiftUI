//
//  Calendar+DaysBetween.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2024.
//

import Foundation

public extension Calendar {
    func daysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = from.startOfDay
        let toDate = to.startOfDay
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>

        return numberOfDays.day!
    }
}
