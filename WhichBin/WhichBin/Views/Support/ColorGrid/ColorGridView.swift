//
//  ColorGridView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 11/9/2025.
//

import SwiftUI

struct ColorGridView: View {
    
    @ObservedObject
    var viewModel: ColorGridViewModel
    
    var body: some View {
        EqualSizeGridLayout(constraint: .columns(5)) {
            ForEach(viewModel.colors) { color in
                ColorGridCellView(color: color, viewModel: viewModel)
            }
        }
    }
}

extension Color: @retroactive Identifiable {
    public var id: Self { self }
}
