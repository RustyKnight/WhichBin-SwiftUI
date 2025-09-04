//
//  SitesListView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 19/4/2025.
//

import SwiftUI

struct SitesListView: View {
    @EnvironmentObject var siteManager: SiteManager

    @State
    private var addSite = false

    var body: some View {
        contentView
            .sheet(isPresented: $addSite) {
                SiteView(viewModel: .init())
            }
    }
}

extension SitesListView {

    @ViewBuilder
    private var contentView: some View {
        if siteManager.sites.isEmpty {
            emptyView()
        } else {
            Text("All your sites are belong to us")
        }
    }

    private func emptyView() -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Image.House.slash
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 128, height: 128)
                    .foregroundStyle(.secondary)
                Text("No sites configured")
                    .font(.title)

                RoundButton {
                    addSite.toggle()
                } content: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundStyle(.primary)
                }
                Text("Add site")
                    .font(.caption)


                Spacer()
            }
            Spacer()    
        }
    }
}
