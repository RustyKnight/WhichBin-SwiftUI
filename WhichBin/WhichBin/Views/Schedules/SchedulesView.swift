//
//  SchedulesView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 7/9/2025.
//

import SwiftUI

struct SchedulesView: View {
    
    @ObservedObject var viewModel: SchedulesViewModel
    
    var body: some View {
        contentView
            .background(Color.background)
            .navigationTitle("Schedules")
            .toolbar {
                settingsButton
            }
            .sheet(isPresented: $viewModel.addNewSite) {
                SiteView(viewModel: .init())
            }
            .navigationDestination(for: SchedulesViewModel.Destination.self) { target in
                switch target {
                case .settings:
                    SettingsView(viewModel: .init(siteManager: viewModel.siteManager))
                }
            }
            .toolbarTheme
            .task {
                await viewModel.load()
            }
    }
}

extension SchedulesView {
    
    @ViewBuilder
    var contentView: some View {
        if viewModel.hasAvailableSites {
            siteCollectionsView
        } else {
            if let error = viewModel.siteLoadError {
                siteLoadErrorView(error)
            } else {
                noSitesView
            }
        }
    }
}

extension SchedulesView {
    
    @ViewBuilder
    var siteCollectionsView: some View {
        switch viewModel.viewState {
        case .initial, .loading:
            loadingCollectionsView
            
        case .loaded(let schedules, let errors):
            collectionsView(
                schedules: schedules,
                errors: errors
            )
        }
    }
    
    var loadingCollectionsView: some View {
        VStack {
            Spacer()
            Text("Calculating the schedule")
                .font(.title)
            
            Text("We know, it's exciting")
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .containerRelativeFrame(
            [.horizontal, .vertical],
            alignment: .top
        )
        .background(Color.listBackground)
    }
    
    func collectionsView(schedules: [EventGroup], errors: [Error]) -> some View {
        List {
            collectionErrorsView(errors)
            
            schedulesView(schedules)
        }
        .padding()
        .listTheme
    }
    
    @ViewBuilder
    func collectionErrorsView(_ errors: [Error]) -> some View {
        if errors.isEmpty {
            EmptyView()
        } else {
            Text("That didn't go well")
        }
    }
    
    @ViewBuilder
    func schedulesView(_ schedules: [EventGroup]) -> some View {
        collectionEventsView(schedules)
    }
    
    @ViewBuilder
    func collectionEventsView(_ events: [EventGroup]) -> some View {
        let sorted = events.sorted { $0.date < $1.date }
        
        ForEach(sorted, id: \.date) { eventGroup in
            let date = eventGroup.date
            
            let dateText = date.formatted(viewModel.dayDateStyle)
            
            Section(dateText) {
                eventGroupView(eventGroup)
            }
        }
    }
    
    func daysTillDescription(_ date: Date) -> String {
        let daysTill = Date.today.daysBetween(date)
        if daysTill < 1 {
            return "Today"
        } else if daysTill < 2 {
            return "Tomorrow"
        } else {
            return "in \(daysTill) days"
        }
    }
    
    func eventGroupView(_ eventGroup: EventGroup) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(eventGroup.scheduleGroup.dataSource.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                let sites = eventGroup.scheduleGroup.sites
                    .map { $0.name }
                    .joined(separator: ", ")
                
                Text(sites)
                    .padding(.bottom)
                
                Spacer()
            }
            .padding(.top, .Padding.small)

            Spacer()
            
            VStack {
                Text(daysTillDescription(eventGroup.date))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, .Padding.small)
                Spacer()

                HStack {
                    ForEach(eventGroup.bins, id: \.id) { bin in
                        WheelyBinView(
                            dataSourceKey: eventGroup.scheduleGroup.dataSourceKey,
                            bin: bin,
                            strokeWidth: 2.0,
                            size: .large24
                        )
                    }
                }
            }
            .padding(.bottom, .Padding.small)
        }
    }
}

extension SchedulesView {
    
    var settingsButton: some View {
        NavigationLink(value: SchedulesViewModel.Destination.settings) {
            Image.Gear.unfilled
                .size(.medium24)
        }
        .tint(Color.tint)
    }
    
    var addSiteButton: some View {
        Button {
            viewModel.addNewSite.toggle()
        } label: {
            Image("house.circle.plus")
                .size(.large32)
        }
        .tint(Color.tint)
    }
    
    var siteSettingsButton: some View {
        NavigationLink(value: SchedulesViewModel.Destination.settings) {
            Image("house.circle.cog")
                .size(.large32)
        }
        .tint(Color.tint)
    }
}

extension SchedulesView {
    
    var noSitesView: some View {
        NoSitesAvailableView(onAddSite: nil)
    }
    
    func siteLoadErrorView(_ error: Error) -> some View {
        HStack {
            Spacer()
            ErrorView(
                title: "Failed to load site details",
                subTitle: error.localizedDescription
            )
            Spacer()
        }
        .background(.cellFill)
    }
}
