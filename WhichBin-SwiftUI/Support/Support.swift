//
//  Support.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 30/8/2024.
//

import Foundation
import WhichBinLib
import NotificationCenter
import Cadmus

class Support: NSObject {
    static let shared = Support()

    static var preferredDataSource: URL {
        guard let value = ProcessInfo.processInfo.environment["sample"], let result = Bool(value), result else {
            return URL(string: "https://data.gov.au/data/dataset/0af93e4d-4ef7-4d45-855b-364039c52f98/resource/172777d4-b8dc-4579-a268-acf836da4362/download/frankston-city-council-garbage-collection-zones.json")!
        }
        return Bundle.main.url(forResource: "Sample", withExtension: "json")!
    }
    
    enum Key: String {
        case appGroupKey = "group.org.kaizen.whichbin.widget"
        case location = "location"
        case dataSource = "dataSource"
    }

    static func scheduleNotification(model: EventModel) {
        log(debug: "Schedule notifications")
        // Remove any pre-existing notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        let events = model.nextEventsOnOrAfterToday()
        guard !events.isEmpty, let targetDate = events.first?.date else {
            log(warning: "Could not find any events")
            return
        }
        // Back up one day...
        let notificationDate = targetDate.adding(days: -1)
        let weekDay = notificationDate.weekDay

        log(debug: "notificationDate = \(notificationDate); weekDay = \(weekDay)")

        scheduleNotification(on: weekDay, hour: 18)
        scheduleNotification(on: weekDay, hour: 20)
        scheduleNotification(on: weekDay, hour: 21)
    }

    private static func scheduleNotification(on weekDay: Int, hour: Int, minute: Int = 0) {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = weekDay
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0
        dateComponents.nanosecond = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = "which-bin".localized
        content.body = "have-you-taken-the-bins-out-yet".localized

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    static func debugNotification() {
        let content = UNMutableNotificationContent()
        content.title = "which-bin".localized
        content.body = "have-you-taken-the-bins-out-yet".localized
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil //UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        )

        log(debug: "Post notificiation")
        UNUserNotificationCenter.current().add(request)
    }

    static func requestNotificationAuthorisation() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { state, error in
            log(debug: "User notification state = \(state)")
        }
    }
}

extension Support: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler(.banner)
    }
}
