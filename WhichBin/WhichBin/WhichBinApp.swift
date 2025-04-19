//
//  WhichBinApp.swift
//  WhichBin
//
//  Created by Shane Whitehead on 18/4/2025.
//

import SwiftUI

@main
struct WhichBinApp: App {
    @StateObject private var siteManager = SiteManager()

    init() {
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(siteManager)
        }
    }
}
