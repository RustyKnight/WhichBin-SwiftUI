//
//  Date+Support.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 29/8/2024.
//

import Foundation

public enum DateParts {
    case hours(_ amount: Int)
    case minutes(_ amount: Int)
    case seconds(_ amount: Int)

    case days(_ amount: Int)
    case months(_ amount: Int)
    case years(_ amount: Int)

    public var component: Calendar.Component {
        switch self {
        case .hours: return .hour
        case .minutes: return .minute
        case .seconds: return .second
        case .days: return .day
        case .months: return .month
        case .years: return .year
        }
    }

    public var amount: Int {
        switch self {
        case .hours(let amount): return amount
        case .minutes(let amount): return amount
        case .seconds(let amount): return amount
        case .days(let amount): return amount
        case .months(let amount): return amount
        case .years(let amount): return amount
        }
    }
}

public func + (lhs: Date, rhs: DateParts) -> Date {
    Calendar.current.date(byAdding: rhs.component, value: rhs.amount, to: lhs)!
}

public extension Date {
    func plus(hours: Int) -> Date {
        self + DateParts.hours(hours)
    }

    func plus(minutes: Int) -> Date {
        self + DateParts.minutes(minutes)
    }

    func plus(days: Int) -> Date {
        self + DateParts.days(days)
    }
}

extension Date {
    var formattedDateTime: String {
        return DateFormatter.dateTime.string(from: self)
    }
}

public extension DateFormatter {
    static var dateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
}
