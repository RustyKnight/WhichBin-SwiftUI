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
//
//struct WhichBinTimeLineProvider: TimelineProvider {
//
//    enum Error: Swift.Error {
//        case missingSharedDefaults
//        case missingSharedDataSource
//        case missingSharedLocation
//    }
//
//    typealias Entry = WidgetModel
//
//    func placeholder(in context: Context) -> WidgetModel {
//        let targetDate = Date().next(.wednesday).startOfDay
//        return WidgetModel(
//            eventsDate: targetDate,
//            previousEventDate: .today,
//            events: EventModel.sampleEvents(targetDate)
//        )
//    }
//
//    // Consider it as a "preview"
//    func getSnapshot(in context: Context, completion: @escaping @Sendable (WidgetModel) -> Void) {
//        return completion(WidgetModel.sample)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<WidgetModel>) -> Void) {
//        Task {
//            do {
//                let config = try loadConfiguration()
//
//                let factory = EventModelFactory(
//                    targetLocation: config.0,
//                    dataSourceURL: config.1
//                )
//
//                do {
//                    let eventModel = try await factory.load()
//                    /*
//                     We could re-load the timeline every hour, but because
//                     the data is unlikely to change over the course of the
//                     day, it seems like a waste.  Instead, in order to keep
//                     the progress bar moving (even a little), we establish
//                     a timeline of events for every hour from now till the
//                     end of the day, after which the time line is reloaded
//                     */
//
//                    let widgetModel = widgetModel(from: eventModel)
//
//                    var entries = [WidgetModel]()
//
//                    // This creates a date representing the current hour
//                    var currentTime = Date.now.topOfHour
//                    let endOfDay = Date.now.endOfDay
//                    while currentTime < endOfDay {
//                        currentTime = currentTime.adding(hours: 1)
//                        entries.append(widgetModel.expired(at: currentTime))
//                    }
//
//                    let timeLine = Timeline(
//                        entries: entries,
//                        policy: .atEnd
//                    )
//                    completion(timeLine)
//                } catch {
//                    completion(Timeline<WidgetModel>.emptyState(debugDetails: "\(error)"))
//                }
//            } catch {
//                completion(Timeline<WidgetModel>.emptyState(debugDetails: "\(error)"))
//            }
//        }
//    }
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
//}
