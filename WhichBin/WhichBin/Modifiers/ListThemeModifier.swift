//
//  ListThemeModifier.swift
//  WhichBin
//
//  Created by Shane Whitehead on 10/9/2025.
//

import SwiftUI

struct ListThemeModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(Color.listBackground)
            .scrollContentBackground(.hidden)
    }
}

extension View {
    
    var listTheme: some View {
        modifier(ListThemeModifier())
    }
}
