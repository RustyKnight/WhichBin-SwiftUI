//
//  ContentView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import SwiftUI
import WhichBinLib

struct ContentView: View {
    @EnvironmentObject var siteManager: SiteManager

    var body: some View {
        switch siteManager.state {
        case .error(let error):
            errorView(error)
        default:
            siteListView()
        }
    }
}

private extension ContentView {
    func errorView(_ error: Error) -> some View {
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
    
    func siteListView() -> some View {
        SitesListView()
    }
}

#Preview {
    ContentView()
}
