//
//  ScheduleView.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import SwiftUI
import WhichBinLib
import WidgetKit

struct ScheduleView: View {
    private let gridItems = [
        GridItem(.adaptive(minimum: 150)),
    ]

    @StateObject var model: ViewModel

    var body: some View {
        VStack {
            navigationView()
            Divider()
            eventsView()
            Divider()
            addressView()
            debugView()
        }
    }

    private func navigationView() -> some View {
        HStack {
            Button {
                model.previousWeek()
            } label: {
                Image(systemName: "chevron.left")
            }
            .help("previous-week")

            Spacer()
            VStack {
                Text(DateFormatter.fullDate.string(from: Date.today))
                HStack {
                    Text(DateFormatter.shortDate.string(from: model.events.weekStarting))
                    Text(" - ")
                    Text(DateFormatter.shortDate.string(from: model.events.weekEnding))
                }
                .font(.caption)
            }
            Spacer()

            Button {
                model.nextWeek()
            } label: {
                Image(systemName: "chevron.right")
            }
            .help("next-week")
        }
        .padding()
    }

    private func eventsView() -> some View {
        let events = model.events.eventsWithinPeriod()

        guard !events.isEmpty else {
            return AnyView(noEventsView())
        }

        let groupedEvents = Dictionary(grouping: events) { $0.date }
        let sortedKeys = Array(groupedEvents.keys).sorted { $0 > $1 }

        return AnyView(
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .leading, spacing: 8) {
                    ForEach(sortedKeys, id: \.self) { key in
                        let groupEvents = groupedEvents[key] ?? []
                        Section {
                            ForEach(groupEvents, id: \.id) { event in
                                viewFor(event: event)
                            }
                        } header: {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text(DateFormatter.relativeFullDate.string(from: key))
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    inNumberOfDaysView(from: key)
                                    Spacer()
                                }
                            }
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            .background(Color.secondary.opacity(0.25))
                            .roundedCorners([.topLeft, .topRight], radius: 8)
                        }
                    }
                }
                .padding(.horizontal)
            }
        )
    }

    private func inNumberOfDaysView(from date: Date) -> some View {
        let duration = Date.today.distance(to: date)
        if duration > 0 {
            return AnyView(
                Text("in-number-of-days \(DateComponentsFormatter.days.string(from: duration) ?? "---")")
                    .font(.footnote)
            )
        } else if duration == 0 {
            return AnyView(
                Text("today")
            )
        }
        return AnyView(EmptyView())
    }

    private func noEventsView() -> some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64)
                .foregroundStyle(.yellow)
            Text("no-events")
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }

    private func viewFor(event: EventModel.Event) -> some View {
        VStack {
            imageFor(event: event)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 125)
            HStack {
                Spacer()
                Text(LocalizedStringKey(descriptionFor(event: event)))
                Spacer()
            }
        }
        .padding()
        .background(
            Color.cellFill
                .opacity(0.9)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func imageFor(event: EventModel.Event) -> Image {
        switch event.collectionType {
        case .rubbish: Image(.redBinVector)
        case .recycling: Image(.yellowBinVector)
        case .green: Image(.greenBinVector)
        case .glass: Image(.purpleBinVector)
        }
    }

    private func descriptionFor(event: EventModel.Event) -> String {
        switch event.collectionType {
        case .rubbish: "event-rubbish"
        case .recycling: "event-recycle"
        case .green: "event-green"
        case .glass: "event-glass"
        }
    }

    private func addressView() -> some View {
        guard let address = model.streetAddress else { return AnyView(EmptyView()) }
        return AnyView(
            VStack(alignment: .center) {
                Text(address)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
        )
    }

    @ViewBuilder
    private func debugView() -> some View {
        Button("Reload Widget") {
            print(">> reload widget")
            WidgetCenter.shared.reloadAllTimelines()
        }
        .padding()
    }
}

#Preview {
    ScheduleView(
        model: ViewModel(
            streetAddress: "Address",
            events: EventModel.sample
        )
    )
}
