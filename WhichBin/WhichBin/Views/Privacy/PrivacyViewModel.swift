//
//  PrivacyViewModel.swift
//  WhichBin
//
//  Created by Shane Whitehead on 13/9/2025.
//

import Foundation
import SwiftUI

class PrivacyViewModel: ObservableObject {
    
    var privacyText: String {
        guard let url = Bundle.main.url(forResource: "Privacy", withExtension: "md") else {
            return "Can not locate privacy statement"
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return "Could not load privacy statement"
        }
        
        guard let text = String(data: data, encoding: .utf8) else {
            return "Could not decode privacy statement"
        }
        
        return text
    }
    
}
