//
//  CancelButton.swift
//  WhichBin
//
//  Created by Shane Whitehead on 21/4/2025.
//

import SwiftUI

struct CancelButton: View {

    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text("Cancel")
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .tint(Color.secondary)
    }
}
