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
    }
}

extension SchedulesView {
    
    @ViewBuilder
    var contentView: some View {
        if viewModel.hasAvailableSites {
            Text("Site schedules")
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
