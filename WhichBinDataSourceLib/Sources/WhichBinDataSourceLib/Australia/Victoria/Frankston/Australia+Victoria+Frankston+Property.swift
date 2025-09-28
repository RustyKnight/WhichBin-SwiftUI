//
//  Australia+Victoria+Frankston+Property.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import Foundation
import CoreExtensions
import WhichBinLib

extension Australia.Victoria.Frankston.Feature {
    struct Property: Sendable {
        let area: String
        let cycles: [Cycle]
    }
}

extension Australia.Victoria.Frankston.Feature.Property {
    struct Cycle: Sendable {
        let bin: Bin
        let dayOfTheWeek: Date.Weekday
        let epoch: Date
        let weekInterval: Double
    }
}

extension Australia.Victoria.Frankston.Feature.Property.Cycle {
    /// Calculates the next collection date for the bin based on the supplied
    /// anchor date.
    /// - Parameter anchor: Date after which the next date should be calculated.
    /// - Returns: Calculates the next collection date.
    func nextCollection(from anchor: Date = Date.today) -> Date {
        let collectionDay = dayOfTheWeek
        let startDate = epoch.startOfDay

        // Calculate the days until the next collection...
        let daysUntilNextCollection = (collectionDay.calendarValue - anchor.weekday + 7) % 7
        var nextCollection = anchor + daysUntilNextCollection.days
        //anchor.adding(days: daysUntilNextCollection)

        // Calculate the number of days from the start date to the next collection day...
        let daysFromStart = startDate.daysBetween(nextCollection)

        // Adjust the next collection day if not aligned with the collection cycle
        let weeks = weekInterval
        let check = Double(daysFromStart).truncatingRemainder(dividingBy: (weeks * 7))
        if check != 0 {
            let daysUntilAligned = (weeks * 7) - (check)
//            nextCollection = nextCollection.adding(days: Int(daysUntilAligned))
            nextCollection = nextCollection + Int(daysUntilAligned).days
        }
        return nextCollection
    }
}

extension Australia.Victoria.Frankston.Feature.Property: Decodable {
    enum CodingKeys: String, CodingKey {
        case area

        case glassDay = "gls_day"
        case glassStart = "gls_start"
        case glassWeeks = "gls_weeks"

        case greenDay = "grn_day"
        case greenStart = "grn_start"
        case greenWeeks = "grn_weeks"

        case recyclingDay = "rec_day"
        case recyclingStart = "rec_start"
        case recyclingWeeks = "rec_weeks"

        case rubbishDay = "rub_day"
        case rubbishStart = "rub_start"
        case rubbishWeeks = "rub_weeks"
    }

    // The mapping section is intended to make parsing easier are more self contained
    struct CodingKeyMap {
        let day: CodingKeys
        let weeks: CodingKeys
        let start: CodingKeys
    }

    private static let keyMappings: [Bin: CodingKeyMap] = {
        var mapping = [Bin: CodingKeyMap]()

        mapping[.rubbish] = CodingKeyMap(day: .rubbishDay, weeks: .rubbishWeeks, start: .rubbishStart)
        mapping[.recycling] = CodingKeyMap(day: .recyclingDay, weeks: .recyclingWeeks, start: .recyclingStart)
        mapping[.greenWaste] = CodingKeyMap(day: .greenDay, weeks: .greenWeeks, start: .greenStart)
        mapping[.glass] = CodingKeyMap(day: .glassDay, weeks: .glassWeeks, start: .glassStart)

        return mapping
    }()

    private static let eventDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Australia/Melbourne")
        return formatter
    }()

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.area = try container.decode(String.self, forKey: .area)

        var cycles = [Cycle?]()
        cycles.append(try Self.parseEvent(from: container, bin: .rubbish))
        cycles.append(try Self.parseEvent(from: container, bin: .recycling))
        cycles.append(try Self.parseEvent(from: container, bin: .greenWaste))
        cycles.append(try Self.parseEvent(from: container, bin: .glass))

        self.cycles = cycles.compactMap { $0 }
    }

    private static func parseEvent(
        from container: KeyedDecodingContainer<Self.CodingKeys>,
        bin: Bin
    ) throws -> Cycle? {
        guard let keys = Self.keyMappings[bin] else { return nil }

        let dayOfWeek = try container.decode(Date.Weekday.self, forKey: keys.day)
        let weeks = try container.decode(Double.self, forKey: keys.weeks)
        let epoch = try container.decode(String.self, forKey: keys.start)

        guard let date = Self.eventDateFormatter.date(from: epoch) else { return nil }

        return .init(
            bin: bin,
            dayOfTheWeek: dayOfWeek,
            epoch: date,
            weekInterval: weeks
        )
    }

    static func date(from value: String) -> Date? {
        return eventDateFormatter.date(from: value)
    }
}
