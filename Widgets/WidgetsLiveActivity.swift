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
        var date: Date
        var events: [Event]
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
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(context.state.date, format: .dateTime.weekday(.wide))
                        inNumberOfDaysView(from: context.state.date)
                    }
                    Spacer()
                    HStack {
                        ForEach(context.state.events.mapToIdentifiableEvents(), id: \.id) { event in
                            viewFor(event: event)
                        }
                    }
//                    .padding()
//                    .background(
//                        Color.cellFill
//                            .opacity(0.2)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
                //Text("Hello \(context.state.events.count)")
            }
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
                    Text("Bottom \(context.state.events.count)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.events.count)")
            } minimal: {
                Text("\(context.state.events.count)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }

    private func inNumberOfDaysView(from date: Date) -> some View {
        HStack {
            Text("in-number-of-days \(date.startOfDay, style: .relative)")
        }
//        let duration = Date.today.startOfDay.distance(to: date)
//        if duration > 0 {
//            return AnyView(
//                //Text("in-number-of-days \(DateComponentsFormatter.days.string(from: duration) ?? "---")")
//                Text(date, style: .relative)
//                    .font(.footnote)
//            )
//        } else if duration == 0 {
//            return AnyView(
//                Text("today")
//            )
//        }
//        return AnyView(Text("---"))
    }

    private func viewFor(event: IdentifiableEvent) -> some View {
            imageFor(event: event.sourceEvent)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 36)
    }

    private func imageFor(event: Event) -> Image {
        switch event.collectionType {
        case .rubbish: Image(.redBinVector)
        case .recycling: Image(.yellowBinVector)
        case .green: Image(.greenBinVector)
        case .glass: Image(.purpleBinVector)
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
        WidgetsAttributes.ContentState(
            date: Date().next(.wednesday).startOfDay,
            events: [
                Event(
                    day: .wednesday,
                    weeks: 1,
                    epoch: Support.rubbishEpoch,
                    collectionType: .rubbish
                ),
                Event(
                    day: .wednesday,
                    weeks: 1,
                    epoch: Support.glassEpoch,
                    collectionType: .glass
                ),
                Event(
                    day: .wednesday,
                    weeks: 1,
                    epoch: Support.recyleEpoch,
                    collectionType: .recycling
                ),
                Event(
                    day: .wednesday,
                    weeks: 1,
                    epoch: Support.greenEpoch,
                    collectionType: .green
                )
            ])
     }
     
     fileprivate static var starEyes: WidgetsAttributes.ContentState {
         WidgetsAttributes.ContentState(
            date: Date().next(.wednesday).startOfDay,
            events: []
         )
     }
}

#Preview("Notification", as: .content, using: WidgetsAttributes.preview) {
   WidgetsLiveActivity()
} contentStates: {
    WidgetsAttributes.ContentState.smiley
    WidgetsAttributes.ContentState.starEyes
}
