//
//  BinConfigutationView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI

struct BinConfigurationView: View {

    @Environment(\.dismiss) var dismiss

    @ObservedObject
    var viewModel: BinConfigurationViewModel
    
    var body: some View {
        VStack {
            Text("Description")
                .foregroundStyle(.secondary)
                .padding(.top)

            TextField(text: $viewModel.description) {
                EmptyView()
            }
            .font(.title)
            .multilineTextAlignment(.center)
            .padding(.bottom)
            .padding(.horizontal)

            let color = viewModel.binFillColor
            WheelyBinView(
                strokeStyle: color.darken(by: 0.5),
                strokeWidth: 4,
                fillColor: color,
                size: .custom(256)
            )
            
            ColorGridView(viewModel: .init(selectedColor: $viewModel.binFillColor))
            
            Spacer()
            
            actionButtons
        }
        .containerRelativeFrame(
            [.horizontal, .vertical],
            alignment: .top
        )        
        .background(Color.listBackground)
        .navigationTitle(viewModel.bin.localisedDescription)
        .toolbarTheme
    }
}

struct WheelyBinView: View {
    
    let strokeStyle: Color
    let strokeWidth: CGFloat
    
    let fillColor: Color
    
    let size: StandardImageSizeModifier.Size
    
    var body: some View {
        WheelyBinShape()
            .stroke(strokeStyle, lineWidth: strokeWidth)
            .fill(fillColor)
            .standard(size: size)
    }
}


private extension BinConfigurationView {
    
    var actionButtons: some View {
        VStack {
            Divider()
            HStack {
                cancelButton
                saveButton
            }
        }
        .background(Color.listBackground)
    }
    
    var saveButton: some View {
        Button {
            //viewModel.save(siteManager)
//            dismiss()
        } label: {
            Text("Save")
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(Color.green)
        .disabled(viewModel.canSave == false)
        
    }
    
    var cancelButton: some View {
        CancelButton {
            dismiss()
        }
//        .tint(.secondary)
    }
}
