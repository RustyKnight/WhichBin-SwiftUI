//
//  Frankston+DataSource.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import Foundation
import Cadmus
import CoreExtensions
import WhichBinLib


private extension State {
    static let victoriaAustralia = State(description: "Victoria", country: .australia)
}

private extension City {
    static let frankstonVictoriaAustralia = City(description: "Frankston", state: .victoriaAustralia)
}

extension Australia.Victoria.Frankston {
    
    class DataSource: WhichBinLib.DataSource, @unchecked Sendable {
        let preferredDataSource: URL = {
            guard let value = ProcessInfo.processInfo.environment["sample"], let result = Bool(value), result else {
                log(debug: "Load remote data source")
                return URL(string: "https://connect.pozi.com/userdata/frankston-publisher/Community/Kerbside_Garbage_Collection_(Widget).json")!
            }
            log(debug: "Load mocked data source")
            return Bundle.module.url(forResource: "MockedNewResponse", withExtension: "json")!
        }()

        let name: String = "Frankston City Council"
        let generalLocation = LocationCoordinate(
            latitude: -38.164707,
            longitude: 145.164631
        )

        let city: City = .frankstonVictoriaAustralia

        init() {

        }

        func load() async throws -> [any WhichBinLib.Schedule] {
            guard let data = try? Data(contentsOf: preferredDataSource) else {
                throw ParserError.failedLoadingResource(preferredDataSource)
            }
            let collection = try JSONDecoder().decode(
                Collection.self,
                from: data
            )

            return collection.features.compactMap { feature in
                Australia.Victoria.Frankston.Schedule(feature: feature)
            }
        }
    }
}

extension Australia.Victoria.Frankston {
    
    struct Schedule: WhichBinLib.Schedule {
        let id: String
        let polygon: Polygon
        let name: String
        let collectionCycles: [WhichBinLib.CollectionCycle]

        init(feature: Feature) {
            id = "Australia.Victoria.Frankston.\(feature.id).\(feature.properties.area)"
            polygon = feature.geometry.polygon
            name = feature.properties.area

            collectionCycles = feature.properties.cycles.map { cycle in
                Australia.Victoria.Frankston.TimeLine(cycle: cycle)
            }
        }

        func nextEvents(from date: Date) -> [any Event] {
            collectionCycles.map {
                $0.nextEvent(from: date)
            }
        }

        func nextEvents() -> [any Event] {
            nextEvents(from: Date.today)
        }
    }
}

extension Australia.Victoria.Frankston {
    
    struct TimeLine: WhichBinLib.CollectionCycle {
        var bin: Bin {
            cycle.bin
        }

        var dayOfTheWeek: Calendar.Weekday {
            cycle.dayOfTheWeek.calendarWeekday
        }

        let cycle: Australia.Victoria.Frankston.Feature.Property.Cycle

        init(cycle: Australia.Victoria.Frankston.Feature.Property.Cycle) {
            self.cycle = cycle
        }

        func nextEvent(from date: Date) -> WhichBinLib.Event {
            let nextCollection = cycle.nextCollection(from: date)
            return Australia.Victoria.Frankston.TimeLine.Event(
                bin: bin,
                date: nextCollection
            )
        }

        func nextEvent() -> WhichBinLib.Event {
            nextEvent(from: Date.today)
        }
    }
}

extension Australia.Victoria.Frankston.TimeLine {
    
    struct Event: WhichBinLib.Event {
        let bin: Bin
        let date: Date
    }
}
