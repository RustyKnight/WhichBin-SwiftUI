//
//  SitesListView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 19/4/2025.
//

import SwiftUI

struct SitesListView: View {
    @EnvironmentObject var siteManager: SiteManager

    var body: some View {
        if siteManager.sites.isEmpty {
            emptyView()
        } else {
            Text("All your sites are belong to us")
        }
    }
}

extension SitesListView {
    private func emptyView() -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Image(.mapPin)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 256, height: 256)
                Text("No sites configured")
                    .font(.title)

                RoundButton {
                    //
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
        .background(.cellFill)
    }
}
