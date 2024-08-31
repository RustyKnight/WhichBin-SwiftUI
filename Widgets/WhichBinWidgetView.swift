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
        VStack {
            VStack(alignment: .leading) {
                dateLineView()
                    .font(.title)
                nextEventInDaysView()
            }
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    messageView()
                    eventsView()
                }
            }
        }
    }

    @ViewBuilder
    private func mediumView() -> some View {
        VStack {
            VStack(alignment: .leading) {
                dateLineView()
                    .font(.title)
                nextEventInDaysView()
                messageView()
                    .font(.caption)
            }
            HStack {
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
            messageView()
                .font(.caption)
            eventsView()
        }
    }

    @ViewBuilder
    private func rectangularView() -> some View {
        VStack(alignment: .leading) {
            dateLineView()
                .font(.subheadline)
            nextEventInDaysView()
                .font(.caption)
            eventsView()
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
            if date.startOfDay == Date().startOfDay {
                Text("today")
            } else {
                inNumberOfDaysView(from: date)
            }
        }
    }

    @ViewBuilder
    private func textDescriptionView() -> some View {
        VStack(alignment: .leading) {
            if let date = model.eventsDate {
                Text(date.formattedWithSuffix())
                    .font(.title)
                if date.startOfDay == Date().startOfDay {
                    Text("today")
                } else {
                    inNumberOfDaysView(from: date)
                }

                messageView(daysTillEvent: Calendar.current.daysBetween(date, and: Date()))
            } else {
                Text("no-data-available")
                Text(model.date, format: .dateTime)
                if let debug = model.debugDetails {
                    Text(debug)
                }
            }
        }
    }

    @ViewBuilder func messageView() -> some View {
        if let date = model.eventsDate {
            messageView(daysTillEvent: Calendar.current.daysBetween(date, and: Date()))
        }
    }

    @ViewBuilder
    private func messageView(daysTillEvent: Int) -> some View {
        //        if 0...1 ~= daysTillEvent {
        Text("have-you-taken-the-bins-out-yet")
            .padding(.top, 2)
        //        }
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

private extension Calendar {
    func daysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = from.startOfDay
        let toDate = to.startOfDay
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>

        return numberOfDays.day!
    }
}

#Preview(as: .accessoryRectangular) {
    StaticWidget()
} timeline: {
    WidgetModel.sample
}
