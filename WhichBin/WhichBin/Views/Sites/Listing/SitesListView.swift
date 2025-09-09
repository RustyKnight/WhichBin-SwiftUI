//
//  SitesListView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 19/4/2025.
//

import SwiftUI
import WhichBinLib

struct SitesListView: View {
    
    @ObservedObject
    var viewModel: SitesListViewModel

    @SwiftUI.State
    private var addSite = false

    var body: some View {
        contentView
            .background(Color.background)
            .sheet(isPresented: $addSite) {
                SiteView(viewModel: .init())
            }
            .alert(
                "Could not delete site(s)",
                isPresented: $viewModel.deleteError
            ) {
                Button.okay()
            }
            .navigationBarTitle("Sites", displayMode: .inline)
            .toolbarTheme
            .navigationDestination(for: SitesListViewModel.Destination.self) { target in
                switch target {
                case .site(let site):
                    SiteView(viewModel: .init(site: site))
                }
            }
    }
}

extension SitesListView {

    @ViewBuilder
    private var contentView: some View {
        if viewModel.siteManager.sites.isEmpty {
            emptyView()
        } else {
            siteListView()
        }
    }

    private func emptyView() -> some View {
        NoSitesAvailableView {
            addSite.toggle()
        }
    }
}

extension SitesListView {
    
    private func siteListView() -> some View {
        List {
            ForEach(Array(viewModel.siteManager.sites)) { site in
//                NavigationLink(destination: SiteDetailView(siteManager: self.siteManager, site: site)) {
//                    Text(site.name)
//                }
                siteView(site)
                    .listRowBackground(Color.background)
            }
            .onDelete { indexSet in
                viewModel.deleteSites(at: indexSet)
            }
        }
        .background(Color.background.darken(by: 0.4))
        .scrollContentBackground(.hidden)
    }
    
    @ViewBuilder
    private func siteView(_ site: Site) -> some View {
        NavigationLink(value: SitesListViewModel.Destination.site(site)) {
            if let dataSource = DataSourceRegistry.shared.dataSources[site.dataSourceKey] {
                HStack {
                    VStack(alignment: .leading) {
                        Text(site.name)
                        Text(dataSource.locationDescription)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Image.Triangle.ExclamationMark.unfilled
                        Text("Invalid collection schedule")
                            .font(.caption)
                    }
                    .foregroundStyle(.red)
                    Text(site.name)
                    Text(site.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
