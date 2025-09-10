//
//  ColorGridCellView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 11/9/2025.
//

import SwiftUI

struct ColorGridCellView: View {
    
    let color: Color
    
    @ObservedObject
    var viewModel: ColorGridViewModel
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 24, height: 24)
                .foregroundStyle(color)
            
            if isSelected {
                Rectangle()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.clear)
                    .border(borderColor)
            }
        }
        .onTapGesture {
            viewModel.selectedColor = color
        }
    }
    
    var isSelected: Bool {
        viewModel.selectedColor == color
    }
    
    var borderColor: Color {
        .primary
//        // Need a decent selected and unselected color
//        if viewModel.selectedColor == color {
//            return .primary
//        }
//        
//        return .secondary
    }
}
