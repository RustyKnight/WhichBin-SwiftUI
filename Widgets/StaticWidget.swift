//
//  StaticWidget.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 29/8/2024.
//

import WidgetKit
import SwiftUI
import WhichBinLib
import CoreLocation

struct StaticTimeLineProvider: TimelineProvider {

    enum Error: Swift.Error {
        case missingSharedDefaults
        case missingSharedDataSource
        case missingSharedLocation
    }

    typealias Entry = WidgetModel

    func placeholder(in context: Context) -> WidgetModel {
        print(">> placeHolder...")
        let targetDate = Date().next(.wednesday).startOfDay
        return WidgetModel(
            eventsDate: targetDate,
            events: EventModel.sampleEvents(targetDate)
        )
    }

    // Consider it as a "preview"
    func getSnapshot(in context: Context, completion: @escaping @Sendable (WidgetModel) -> Void) {
        print(">> snapshot...")
        return completion(WidgetModel.sample)
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<WidgetModel>) -> Void) {
        print(">> timeline...")
        Task {
            do {
                let config = try loadConfiguration()

                let factory = EventModelFactory(
                    targetLocation: config.0,
                    dataSourceURL: config.1
                )

                do {
                    print(">> Load events")
                    let eventModel = try await factory.load()
                    let widgetModel = nextEventsFrom(eventModel: eventModel)

                    print(">> Next event date = \(widgetModel.eventsDate)")
                    print(">> Next events = \(widgetModel.events)")

                    let timeLine = Timeline(
                        entries: [widgetModel],
                        policy: .atEnd
                    )
                    completion(timeLine)
                } catch {
                    completion(Timeline<WidgetModel>.emptyState(debugDetails: "\(error)"))
                }
            } catch {
                completion(Timeline<WidgetModel>.emptyState(debugDetails: "\(error)"))
            }
        }
    }

    private func nextEventsFrom(eventModel: EventModel) -> WidgetModel {
        let events = Dictionary(grouping: eventModel.nextEventsOnOrAfterToday()) {
            $0.date.startOfDay
        }
        guard let targetDate = events.keys.sorted().first, let nextEvents = events[targetDate] else {
            return WidgetModel(date: Date().plus(minutes: 5), eventsDate: nil, events: [])
        }
        return WidgetModel(eventsDate: targetDate, events: nextEvents)
    }

    private func loadConfiguration() throws -> (CLLocationCoordinate2D, URL) {
        print(">> defaults = \(UserDefaults.shared)")
        print(">> location = \(UserDefaults.shared?.location(forKey: Support.Key.location))")
        print(">> dataSource = \(UserDefaults.shared?.url(forKey: Support.Key.dataSource))")

        guard let defaults = UserDefaults.shared else {
            throw Error.missingSharedDefaults
        }
        guard let location = defaults.location(forKey: Support.Key.location) else {
            throw Error.missingSharedLocation
        }
        guard let dataSource = defaults.url(forKey: Support.Key.dataSource) else {
            throw Error.missingSharedDataSource
        }

        return (location, dataSource)

        //        guard let dataSource = Bundle.main.url(forResource: "Sample", withExtension: "json") else {
        //            print(">> Missing sample datasource")
        //            return nil
        //        }
        //
        //        print(">> load from samples")
        //        return (Secrets.home, dataSource)
    }
}

struct StaticWidget: Widget {
    var body: some WidgetConfiguration {
        //        A Widget can have two configurations: StaticConfiguration or AppIntentConfiguration.
        //        * StaticConfiguration: Describes the content of a widget that has no user-configurable options.
        //        * AppIntentConfiguration: Describes the content of a widget that uses custom intent to provide user-configurable options.
        StaticConfiguration(
            kind: "org.kaizen.WhichBinWidget",
            provider: StaticTimeLineProvider()) { entry in
                WhichBinWidgetView(model: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            }
            .configurationDisplayName("WhichBin")
            .description("Which Bin needs to be put out and when")
            .supportedFamilies([
                .systemSmall,
                .systemMedium,
                .accessoryRectangular
            ])
    }

}
