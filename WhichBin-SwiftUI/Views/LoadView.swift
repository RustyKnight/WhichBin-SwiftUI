//
//  LoadView.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import SwiftUI

@MainActor
protocol LoadDelegate {
    func didLoadModel(viewModel: ViewModel)
    func loadDidFail(error: Error)
}

struct LoadView: View {
    let factory: ViewModelFactory
    var delegate: (any LoadDelegate)?
    
    var body: some View {
        VStack {
            ZStack {
                Image("WhichBin")
                    .blur(radius: 8)
            }
            .overlay(alignment: .center) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .onAppear {
            Task {
                do {
                    let model = try await factory.make()
                    delegate?.didLoadModel(viewModel: model)
                } catch {
                    delegate?.loadDidFail(error: error)
                }
            }
        }
    }
}

#Preview {
    LoadView(factory: DefaultViewModelFactory())
}
