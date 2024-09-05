//
//  WidgetsLiveActivity.swift
//  Widgets
//
//  Created by Shane Whitehead on 8/8/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI
import WhichBinLib

struct WidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var model: WidgetModel
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

//extension ActivityViewContext where Attributes == WidgetsAttributes {
//    var date: Date {
//        state.events.first?.nextDate ?? Date().startOfDay.next(.wednesday)
//    }
//}

struct WidgetsLiveActivity: Widget {
    static var dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = .current
        formatter.timeZone = .current
        return formatter
    }()

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            WhichBinWidgetView(model: context.state.model)
//            VStack {
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(context.state.model.date, format: .dateTime.weekday(.wide))
//                        if context.state.model.date.startOfDay == Date().startOfDay {
//                            Text("today")
//                        } else {
//                            inNumberOfDaysView(from: context.state.model.date)
//                        }
//                    }
//                    Spacer()
//                    HStack {
//                        ForEach(context.state.model.events.mapToIdentifiableEvents(), id: \.id) { event in
//                            viewFor(event: event)
//                        }
//                    }
//                }
//                .padding()
//            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.model.events.count)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.model.events.count)")
            } minimal: {
                Text("\(context.state.model.events.count)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetsAttributes {
    fileprivate static var preview: WidgetsAttributes {
        WidgetsAttributes(name: "World")
    }
}

extension WidgetsAttributes.ContentState {
    fileprivate static var smiley: WidgetsAttributes.ContentState {
        let targetDate = Date().next(.wednesday).startOfDay
        return WidgetsAttributes.ContentState(
            model: WidgetModel(
                eventsDate: targetDate,
                previousEventDate: .today,
                events: EventModel.sampleEvents(targetDate)
            )
        )
    }

    fileprivate static var starEyes: WidgetsAttributes.ContentState {
        WidgetsAttributes.ContentState(
            model: WidgetModel(
                eventsDate: Date().next(.wednesday).startOfDay,
                previousEventDate: .today,
                events: []
            )
        )
    }
}

#Preview("Notification", as: .content, using: WidgetsAttributes.preview) {
    WidgetsLiveActivity()
} contentStates: {
    WidgetsAttributes.ContentState.smiley
    WidgetsAttributes.ContentState.starEyes
}
