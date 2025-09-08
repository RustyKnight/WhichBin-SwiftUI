//
//  SettingsView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI

struct SettingsView: View {
    
    let viewModel: SettingsViewModel
    
    var body: some View {
        List {
            settingsSection
            
            privacySection
        }
        .listStyle(.grouped)
        .background(Color.background.darken(by: 0.4))
        .scrollContentBackground(.hidden)
        .toolbarTheme
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: SettingsViewModel.Destination.self) { target in
            switch target {
            case .siteManagement:
                SitesListView(viewModel: .init(siteManager: viewModel.siteManager))
            case .privacy:
                EmptyView()
            }
        }
    }
}

extension SettingsView {

    var settingsSection: some View {
        Section {
            settingsView
        }
    }
    
    var settingsView: some View {
        NavigationLink(value: SettingsViewModel.Destination.siteManagement) {
            HStack {
                Label {
                    Text("Site Management")
                } icon: {
                    Image.House.circle
                }

            }
        }
    }
}

extension SettingsView {

    var privacySection: some View {
        Section {
            privacyView
        }
    }
    
    var privacyView: some View {
        NavigationLink(value: SettingsViewModel.Destination.privacy) {
            HStack {
                Label {
                    Text("Privacy")
                } icon: {
                    Image.Lock.Shield.unfilled
                }

            }
        }
    }
}
