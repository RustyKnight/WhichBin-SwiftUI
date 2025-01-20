//
//  WhichBinWidgetView.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 29/8/2024.
//

import SwiftUI
import WhichBinLib
import WidgetKit

struct WhichBinWidgetView: View {
    
    @Environment(\.widgetFamily) var widgetFamily
    
    let model: WidgetModel
    let currentDate: Date

    var iconSize: CGFloat {
        switch widgetFamily {
        case .systemSmall: return 24
        case .systemMedium: return 36
        case .systemLarge: return 48
        case .systemExtraLarge: return 48
        case .accessoryCircular: return 24
        case .accessoryRectangular: return 24
        case .accessoryInline: return 24
        @unknown default:
            return 36
        }
    }

    init(model: WidgetModel, currentDate: Date = .now) {
        self.model = model
        self.currentDate = currentDate
    }

    var body: some View {
        if widgetFamily == .systemSmall {
            smallView()
        } else if widgetFamily == .systemMedium {
            mediumView()
        } else if widgetFamily == .systemLarge || widgetFamily == .systemExtraLarge {
            largeView()
        } else if widgetFamily == .accessoryRectangular {
            rectangularView()
        }
    }
    
    @ViewBuilder
    private func largeView() -> some View {
        VStack(alignment: .leading) {
            dateLineView()
                .font(.title)
            nextEventInDaysView()
            timelineView()
            Spacer()
            messageView()
                .font(.caption2)
            HStack {
                Spacer()
                eventsView()
            }
        }
    }
    
    @ViewBuilder
    private func mediumView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    dateLineView()
                        .font(.title)
                    nextEventInDaysView()
                    timelineView()
                }
                Spacer()
            }
            HStack {
                messageView()
                    .font(.caption2)
//                debugView()
//                    .font(.caption)
                Spacer()
                eventsView()
            }
        }
    }
    
    @ViewBuilder
    private func smallView() -> some View {
        VStack(alignment: .leading) {
            dateLineView()
                .font(.subheadline)
            nextEventInDaysView()
                .font(.caption)
            timelineView()
            Spacer()
            messageView()
                .font(.caption)
            HStack {
                Spacer()
                eventsView()
            }
        }
    }
    
    @ViewBuilder
    private func rectangularView() -> some View {
        VStack(alignment: .leading) {
            dateLineView()
                .font(.subheadline)
            nextEventInDaysView()
                .font(.caption)
            timelineView()
            HStack {
                Spacer()
                eventsView()
            }
        }
    }
    
    @ViewBuilder
    private func inlineView() -> some View {
        VStack(alignment: .leading) {
            dateLineView()
                .font(.subheadline)
            nextEventInDaysView()
                .font(.caption)
        }
    }
    
    @ViewBuilder
    private func dateLineView() -> some View {
        if let date = model.eventsDate {
            Text(date.formattedWithSuffix())
        }
    }
    
    @ViewBuilder
    private func nextEventInDaysView() -> some View {
        if let date = model.eventsDate {
            let daysRemaining = Calendar.current.daysBetween(currentDate.startOfDay, and: date.startOfDay)
            if daysRemaining == 0 {
                Text("today")
            } else if daysRemaining == 1 {
                Text("tomorrow")
            } else {
                let duration = currentDate.startOfDay.distance(to: date.startOfDay)
                Text("in-number-of-days \(DateComponentsFormatter.days.string(from: duration) ?? "---")")
            }
        }
    }

    @ViewBuilder
    private func timelineView() -> some View {
        if let targetDate = model.eventsDate?.endOfDay,
           let previousEventDate = model.previousEventDate?.endOfDay,
           targetDate > previousEventDate &&
            currentDate.startOfDay < targetDate.startOfDay
        {
            let range = targetDate.timeIntervalSince1970 - previousEventDate.timeIntervalSince1970
            let value = currentDate.timeIntervalSince1970 - previousEventDate.timeIntervalSince1970

            ProgressView(value: value, total: range)
        }
    }
    
    @ViewBuilder func messageView() -> some View {
        if let date = model.eventsDate {
            messageView(daysTillEvent: Calendar.current.daysBetween(currentDate.startOfDay, and: date.startOfDay))
        }
    }
    
    @ViewBuilder
    private func messageView(daysTillEvent: Int) -> some View {
        if 0...1 ~= daysTillEvent {
            Text("have-you-taken-the-bins-out-yet")
                .padding(.top, 2)
        }
    }
    
    @ViewBuilder
    private func eventsView() -> some View {
        HStack {
            ForEach(model.events.mapToIdentifiableEvents(), id: \.id) { event in
                viewFor(event: event)
            }
        }
    }
    
    private func inNumberOfDaysView(from date: Date) -> some View {
        Text("in-number-of-days \(date.startOfDay, style: .relative)")
    }
    
    private func viewFor(event: IdentifiableEvent) -> some View {
        Image.imageFor(event: event.sourceEvent, family: widgetFamily)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: iconSize)
    }

    @ViewBuilder
    private func debugView() -> some View {
        Text("\(model.date.formatted(date: .abbreviated, time: .shortened))")
    }
}

private extension WhichBinWidgetView {
    static var dayOfWeekStyle: Date.FormatStyle {
        Date.FormatStyle()
            .day(.twoDigits)
            .weekday(.wide)
    }
}

private extension Date {
    func formattedWithSuffix() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE '\(self.daySuffix())'"
        return formatter.string(from: self)
    }
    
    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        
        return formatter.string(for: dayOfMonth) ?? ""
    }
}

#Preview(as: .systemMedium) {
    StaticWidget()
} timeline: {
    WidgetModel.sample
}
