//
//  WhichBin_SwiftUIApp.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import SwiftUI
import CoreLocation
import WhichBinLib

@main
struct WhichBin_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(factory: DefaultViewModelFactory())
                .navigationTitle("Which Bin")
                .onAppear {
                    // At some point this needs to move to
                    // some kind of user configuration concept
                    print(">> Set initial default values...")
                    UserDefaults.shared?.set(
                        Secrets.home,
                        forKey: Support.Key.location
                    )
                    UserDefaults.shared?.set(
                        Support.preferredDataSource,
                        forKey: Support.Key.dataSource
                    )
                }
        }
    }
}
