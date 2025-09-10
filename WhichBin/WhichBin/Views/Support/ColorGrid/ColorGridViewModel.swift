//
//  ColorGridViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 11/9/2025.
//

import SwiftUI

class ColorGridViewModel: ObservableObject {
    
    @Binding
    var selectedColor: Color
    
    let colors: [Color] = [
        .red, .orange, .yellow,
        .green, .mint, .teal,
        .cyan, .blue, .indigo,
        .purple, .pink, .brown,
        .gray, .white, .black,
    ]
    
    init(selectedColor: Binding<Color>) {
        self._selectedColor = selectedColor
    }
}
