//
//  Properties.swift
//
//
//  Created by Shane Whitehead on 14/1/2024.
//

import Foundation

// This is a mess and would have been done better if the source data
// was in a better structure (ie an array of properties), but this
// is a real world problem...
// Since we go to the trouble of transforming the event information into
// something which is more manageable/consumable, the `Properties`
// structure itself doesn't really serve much of purpose outside
// of the library context, so we keep for internal processing
// only
struct PropertyDTO: Decodable {
    let properties: [Property]

    enum CodingKeys: String, CodingKey {
        case rubbishDay = "rub_day"
        case rubbishWeeks = "rub_weeks"
        case rubbishStart = "rub_start"
        case recyclingDay = "rec_day"
        case recyclingWeeks = "rec_weeks"
        case recyclingStart = "rec_start"
        case greenDay = "grn_day"
        case greenWeeks = "grn_weeks"
        case greenStart = "grn_start"
        case glassDay = "gls_day"
        case glassWeeks = "gls_weeks"
        case glassStart = "gls_start"
    }
    
    // The mapping section is intended to make parsing easier are more self contained
    struct CodingKeyMap {
        let day: CodingKeys
        let weeks: CodingKeys
        let start: CodingKeys
    }
    
    private static var keyMappings: [Property.CollectionType: CodingKeyMap] = {
        var mapping = [Property.CollectionType: CodingKeyMap]()
        
        mapping[.rubbish] = CodingKeyMap(day: .rubbishDay, weeks: .rubbishWeeks, start: .rubbishStart)
        mapping[.recycling] = CodingKeyMap(day: .recyclingDay, weeks: .recyclingWeeks, start: .recyclingStart)
        mapping[.green] = CodingKeyMap(day: .greenDay, weeks: .greenWeeks, start: .greenStart)
        mapping[.glass] = CodingKeyMap(day: .glassDay, weeks: .glassWeeks, start: .glassStart)
        
        return mapping
    }()

    private static var eventDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.timeZone = TimeZone(identifier: "Australia/Melbourne")
        return formatter
    }()

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var events = [Property?]()
        events.append(try PropertyDTO.parseEvent(from: container, collectionType: .rubbish))
        events.append(try PropertyDTO.parseEvent(from: container, collectionType: .recycling))
        events.append(try PropertyDTO.parseEvent(from: container, collectionType: .green))
        events.append(try PropertyDTO.parseEvent(from: container, collectionType: .glass))
        
        self.properties = events.compactMap { $0 }
    }
    
    private static func parseEvent(
        from container: KeyedDecodingContainer<PropertyDTO.CodingKeys>,
        collectionType: Property.CollectionType
    ) throws -> Property? {
        guard let keys = PropertyDTO.keyMappings[collectionType] else { return nil }
        
        let dayOfWeek = try container.decode(Property.DayOfWeek.self, forKey: keys.day)
        let weeks = try container.decode(Int.self, forKey: keys.weeks)
        let epoch = try container.decode(String.self, forKey: keys.start)

        guard let date = PropertyDTO.eventDateFormatter.date(from: epoch) else { return nil }
        
        return Property(
            day: dayOfWeek,
            weeks: weeks,
            epoch: date,
            collectionType: collectionType
        )
    }
    
    static func date(from value: String) -> Date? {
        return eventDateFormatter.date(from: value)
    }
}
