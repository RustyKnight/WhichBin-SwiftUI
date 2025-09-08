//
//  ThemeModifier.swift
//  WhichBin
//
//  Created by Shane Whitehead on 8/9/2025.
//

import SwiftUI

struct ToolbarThemeModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .accentColor(Color.tint)
            .toolbarBackground(
                .visible,
                for: .navigationBar
            )
            .toolbarBackground(
                Color.background,
                for: .navigationBar
            )
            .tint(Color.tint)
    }
}

extension View {
    
    var toolbarTheme: some View {
        modifier(ToolbarThemeModifier())
    }
}
