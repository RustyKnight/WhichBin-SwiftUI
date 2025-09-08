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

    // Need ability to determine if any sites exist or not
    // and show the site list if not and the
    // schedule view if to does ...
    
    var body: some View {
        NavigationStack {
            SchedulesView(viewModel: .init(siteManager: siteManager))
        }
        .toolbarTheme
        .background(Color.background)
    }
}

#Preview {
    ContentView()
}
