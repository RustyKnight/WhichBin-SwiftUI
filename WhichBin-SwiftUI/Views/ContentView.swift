//
//  ContentView.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import SwiftUI
import CoreLocation

struct ContentView: View{
    enum Route {
        case load(_ factory: ViewModelFactory)
        case schedule(_ model: ViewModel)
    }
    
    @State var route: Route
    
    init(factory: ViewModelFactory) {
        _route = State(initialValue: Route.load(factory))
    }
    
    var body: some View {
        VStack {
            switch route {
            case .load(let factory):
                LoadView(factory: factory, delegate: self)
                
            case .schedule(let model):
                ScheduleView(model: model)
            }
        }
        .padding()
    }
}

extension ContentView: LoadDelegate {
    func didLoadModel(viewModel: ViewModel) {
        route = .schedule(viewModel)
    }
    
    func loadDidFail(error: Error) {
    }
}

// MARK: - Preview

#Preview {
    ContentView(factory: DefaultViewModelFactory())
}

// MARK: Preview -
