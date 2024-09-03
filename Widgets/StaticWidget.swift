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
import Cadmus

struct StaticTimeLineProvider: TimelineProvider {

    enum Error: Swift.Error {
        case missingSharedDefaults
        case missingSharedDataSource
        case missingSharedLocation
    }

    typealias Entry = WidgetModel

    func placeholder(in context: Context) -> WidgetModel {
        let targetDate = Date().next(.wednesday).startOfDay
        return WidgetModel(
            eventsDate: targetDate,
            events: EventModel.sampleEvents(targetDate)
        )
    }

    // Consider it as a "preview"
    func getSnapshot(in context: Context, completion: @escaping @Sendable (WidgetModel) -> Void) {
        return completion(WidgetModel.sample)
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<WidgetModel>) -> Void) {
        Task {
            do {
                let config = try loadConfiguration()

                let factory = EventModelFactory(
                    targetLocation: config.0,
                    dataSourceURL: config.1
                )

                do {
                    let eventModel = try await factory.load()
                    // The default timeline updates once a day, at the
                    // of the day
                    let widgetModel = nextEventsFrom(eventModel: eventModel)

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
        let sortedKeys = events.keys.sorted()
        log(debug: "sortedKeys = \(sortedKeys)")
        guard let targetDate = events.keys.sorted().first, let nextEvents = events[targetDate] else {
            return WidgetModel(date: Date().plus(minutes: 5), eventsDate: nil, events: [])
        }
        return WidgetModel(eventsDate: targetDate, events: nextEvents)
    }

    private func loadConfiguration() throws -> (CLLocationCoordinate2D, URL) {
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
