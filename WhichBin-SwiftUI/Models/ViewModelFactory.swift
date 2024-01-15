//
//  ViewModelFactory.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation

protocol ViewModelFactory {
    func make() async throws -> ViewModel 
}
