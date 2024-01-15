//
//  WhichBin_SwiftUIApp.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import SwiftUI
import CoreLocation

@main
struct WhichBin_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(factory: DefaultViewModelFactory())
                .navigationTitle("Which Bin")
        }
    }
}
