//
//  FrankstonParserTests.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import Foundation
import Testing
import MapKit
import WhichBinLib
@testable import WhichBinDataSourceLib

fileprivate extension Australia.Victoria.Frankston {
    static let testLocation = CLLocationCoordinate2D(
        latitude: -38.155626,
        longitude: 145.119627
    )

    static func mockedData() throws -> Data {
        return try Resource.mockedRestrictedResponse.data()
    }
}

fileprivate let dateFormat = Date.FormatStyle().weekday(.abbreviated).day().month(.abbreviated).year()

class AustraliaVictoriaFrankston {

    @Test func parserTest() async throws {
        typealias nameSpace = Australia.Victoria.Frankston
        let data = try nameSpace.mockedData()
        let _ = try JSONDecoder().decode(
            Australia.Victoria.Frankston.Collection.self,
            from: data
        )
    }

    @Test func detectCycles() async throws {
        typealias nameSpace = Australia.Victoria.Frankston
        let data = try nameSpace.mockedData()
        let collection = try JSONDecoder().decode(
            nameSpace.Collection.self,
            from: data
        )

        let target = collection.features.first { feature in
            feature.geometry.polygon.mapMultiPolygon.contains(nameSpace.testLocation)
        }

        #expect(target != nil)
        #expect(target!.properties.area == "Area 2")
    }

    @Test func testDataSource() async throws {
        typealias nameSpace = Australia.Victoria.Frankston

        let dataSource = nameSpace.DataSource()
        let schedules = try await dataSource.load()

        let schedule = schedules.first { schedule in
            schedule.polygon.mapMultiPolygon.contains(nameSpace.testLocation)
        }

        #expect(schedule != nil)
        #expect(schedule!.id == "Australia.Victoria.Frankston.Kerbside_Garbage_Collection_(Widget).8.Area 2")
        #expect(schedule!.name == "Area 2")
    }

    @Test func testNextCollection() async throws {
        typealias nameSpace = Australia.Victoria.Frankston
        let data = try nameSpace.mockedData()
        let collection = try JSONDecoder().decode(
            nameSpace.Collection.self,
            from: data
        )

        let target = collection.features.first { feature in
            feature.geometry.polygon.mapMultiPolygon.contains(nameSpace.testLocation)
        }

        #expect(target != nil)

        let cycles = target!.properties.cycles

        for cycle in cycles {
            print("\(cycle.bin) [\(cycle.dayOfTheWeek)] next collection: \(cycle.nextCollection().formatted(dateFormat))")
        }
    }

    @Test func testDataSourceNextCollection() async throws {
        typealias nameSpace = Australia.Victoria.Frankston

        let dataSource = nameSpace.DataSource()
        let schedules = try await dataSource.load()

        let schedule = schedules.first { schedule in
            schedule.polygon.mapMultiPolygon.contains(nameSpace.testLocation)
        }

        #expect(schedule != nil)
        #expect(schedule!.id == "Australia.Victoria.Frankston.Kerbside_Garbage_Collection_(Widget).8.Area 2")
        #expect(schedule!.name == "Area 2")

        for event in schedule!.nextEvents() {
            print("\(event.bin) = \(event.date.formatted())")
        }
    }

    @Test func testDateRange() async throws {
        typealias nameSpace = Australia.Victoria.Frankston

        let dataSource = nameSpace.DataSource()
        let schedules = try await dataSource.load()

        let schedule = schedules.first { schedule in
            schedule.polygon.mapMultiPolygon.contains(nameSpace.testLocation)
        }

        #expect(schedule != nil)
        #expect(schedule!.id == "Australia.Victoria.Frankston.Kerbside_Garbage_Collection_(Widget).8.Area 2")
        #expect(schedule!.name == "Area 2")

        print(">---------->")

        let dayBefore = Date.set(year: 2025, month: 04, day: 15)

        for event in schedule!.nextEvents(from: dayBefore) {
            let daysBetween = dayBefore.daysBetween(event.date)
            print("\(event.bin) = \(event.date.formatted(dateFormat)); daysBetween: \(daysBetween)")
        }

        print(">---------->")

        let sameDay = Date.set(year: 2025, month: 04, day: 16)

        for event in schedule!.nextEvents(from: sameDay) {
            let daysBetween = sameDay.daysBetween(event.date)
            print("\(event.bin) = \(event.date.formatted(dateFormat)); daysBetween: \(daysBetween)")
        }

        print(">---------->")

        let dayAfter = Date.set(year: 2025, month: 04, day: 17)

        for event in schedule!.nextEvents(from: dayAfter) {
            let daysBetween = dayAfter.daysBetween(event.date)
            print("\(event.bin) = \(event.date.formatted(dateFormat)); daysBetween: \(daysBetween)")
        }
    }

    @Test func testDataSourceRegistry() {
        let dataSource = DataSourceRegistry.shared.dataSources[.australiaVictoriaFrankston]

        #expect(dataSource?.name == "Frankston City Council")
    }
    
    @Test func testFutureEvents() async throws {
        let dataSource = DataSourceRegistry.shared.dataSources[.australiaVictoriaFrankston]!
        let schedules = try await dataSource
            .load()
            .filter { schedule in
                schedule.polygon.mapMultiPolygon.contains(Australia.Victoria.Frankston.testLocation)
            }
        
        let format = Date.FormatStyle().weekday(.abbreviated).day().month(.abbreviated).year()
        
        let calendar = Calendar.autoupdatingCurrent
        let firstWeekDay = calendar.firstDayOfWeek
        
        print("firstWeekDay = \(firstWeekDay)")
        
        var startOfWeek = calendar.next(firstWeekDay)
        for week in 1...4 {
            let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!.endOfDay
            print("startOfWeek = \(startOfWeek.formatted(format))")
            print("endOfWeek = \(endOfWeek.formatted(format))")

            let events = schedules
                .flatMap { event in
                    event.nextEvents(from: startOfWeek)
                }
                .filter { event in
                    event.date <= endOfWeek
                }
            
            for event in events {
                print(" - \(event.date.formatted(format)) - \(event.bin)")
            }

            startOfWeek = calendar.date(byAdding: .day, value: 1, to: endOfWeek)!.startOfDay
        }
    }
    
    @Test func testForecast() async throws {
        let dataSource = DataSourceRegistry.shared.dataSources[.australiaVictoriaFrankston]!
        let schedules = try await dataSource
            .load()
            .filter { schedule in
                schedule.polygon.mapMultiPolygon.contains(Australia.Victoria.Frankston.testLocation)
            }

        let calendar = Calendar.autoupdatingCurrent
        let firstWeekDay = calendar.firstDayOfWeek
        let anchorDate = calendar.previous(firstWeekDay)
        
        print(">> anchorDate = \(anchorDate.formatted(dateFormat))")
        
        let forecasts = Dictionary(grouping: schedules.forecast(forWeeksAhead: 4, after: anchorDate), by: \.date)
        
        let keys = forecasts.keys.sorted()
        
        for key in keys {
            let events = forecasts[key]!
            print(key.formatted(dateFormat))
            for event in events {
                print(" - \(event) \(event.date.formatted(dateFormat)) - \(event.bin)")
            }
        }
    }
}
