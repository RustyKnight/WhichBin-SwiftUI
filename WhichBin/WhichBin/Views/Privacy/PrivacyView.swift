//
//  PrivacyView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 13/9/2025.
//

import SwiftUI
import MarkdownUI

struct PrivacyView: View {
    
    @ObservedObject
    var viewModel: PrivacyViewModel
    
    var body: some View {
        VStack {
            Markdown(MarkdownContent(viewModel.privacyText))
                .padding()
            Spacer()
        }
        .containerRelativeFrame(
            [.horizontal, .vertical],
            alignment: .top
        )
        .background(Color.listBackground)
        .navigationTitle("Privacy")
    }
}
