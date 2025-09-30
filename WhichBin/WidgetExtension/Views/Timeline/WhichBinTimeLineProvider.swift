//
//  WhichBinTimeLineProvider.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/9/2025.
//

import WidgetKit
import SwiftUI
import WhichBinLib
import CoreLocation
import Cadmus
import CoreExtensions

struct WhichBinTimeLineProvider: TimelineProvider {

    enum Error: Swift.Error {
        case missingSharedDefaults
        case missingSharedDataSource
        case missingSharedLocation
    }

    typealias Entry = WidgetModel

    func placeholder(in context: Context) -> WidgetModel {
        let targetDate = Calendar
            .autoupdatingCurrent
            .next(.wednesday)
            .startOfDay
        return WidgetModel(date: targetDate)
    }

    // Consider it as a "preview"
    func getSnapshot(in context: Context, completion: @escaping @Sendable (WidgetModel) -> Void) {
        return completion(WidgetModel.sample)
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<WidgetModel>) -> Void) {
        Task {
            do {
                let results = try await ScheduleService.load()
                let futureEvents = results.futureEvents
                let lastEvent = results.lastEvent
                
                let dateGroup = futureEvents.groupedByDate
                let sorted = dateGroup.sorted { $0.date < $1.date }
                let nextEvent = sorted.first
                
                let model = WidgetModel(
                    date: .today + 1.hours,
                    nextEvent: nextEvent,
                    lastEvent: lastEvent
                )
                
                completion(
                    Timeline<WidgetModel>(
                        entries: [model],
                        policy: .atEnd
                    )
                )
            } catch {
                completion(Timeline<WidgetModel>.emptyState(debugDetails: "\(error)"))
            }
        }
    }
//
//    private func widgetModel(from eventModel: EventModel) -> WidgetModel {
//        guard let nextEvents = nextEventsFrom(from: eventModel) else {
//            return WidgetModel(date: Date().plus(minutes: 5), eventsDate: nil, previousEventDate: nil, events: [])
//        }
//
//        return WidgetModel(
//            eventsDate: nextEvents.0,
//            previousEventDate: previousEventDate(from: eventModel),
//            events: nextEvents.1)
//    }
//
//    private func nextEventsFrom(from eventModel: EventModel) -> (Date, [EventModel.Event])? {
//        let events = Dictionary(grouping: eventModel.nextEventsOnOrAfterToday()) {
//            $0.date.startOfDay
//        }
//        let sortedKeys = events.keys.sorted()
//        guard let targetDate = sortedKeys.first, let nextEvents = events[targetDate] else {
//            //return WidgetModel(date: Date().plus(minutes: 5), eventsDate: nil, events: [])
//            return nil
//        }
////        return WidgetModel(eventsDate: targetDate, events: nextEvents)
//        return (targetDate, nextEvents)
//    }
//
//    private func previousEventDate(from eventModel: EventModel) -> Date? {
//        eventModel.previousEventsBeforeToday().map { $0.date }.sorted().first
//    }
//
//    private func loadConfiguration() throws -> (CLLocationCoordinate2D, URL) {
//        guard let defaults = UserDefaults.shared else {
//            throw Error.missingSharedDefaults
//        }
//        guard let location = defaults.location(forKey: Support.Key.location) else {
//            throw Error.missingSharedLocation
//        }
//        guard let dataSource = defaults.url(forKey: Support.Key.dataSource) else {
//            throw Error.missingSharedDataSource
//        }
//
//        return (location, dataSource)
//    }
}
