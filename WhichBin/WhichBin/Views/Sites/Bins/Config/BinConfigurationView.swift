//
//  BinConfigutationView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI
import WhichBinLib

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
        .onReceive(viewModel.dismissView) { shouldDismiss in
            if shouldDismiss {
                self.dismiss()
            }
        }
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

    init(strokeStyle: Color, strokeWidth: CGFloat, fillColor: Color, size: StandardImageSizeModifier.Size) {
        self.strokeStyle = strokeStyle
        self.strokeWidth = strokeWidth
        self.fillColor = fillColor
        self.size = size
    }
    
    init(
        dataSourceKey: DataSourceRegistry.Key,
        bin: Bin,
        strokeWidth: CGFloat = 4,
        size: StandardImageSizeModifier.Size
    ) {
        self.init(
            strokeStyle: bin.fillColor(for: dataSourceKey).darken(by: 0.5),
            strokeWidth: strokeWidth,
            fillColor: bin.fillColor(for: dataSourceKey),
            size: size
        )
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
            viewModel.save()
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
    }
}
