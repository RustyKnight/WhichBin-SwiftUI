//
//  String+CapitalizingFirstLetter.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2025.
//

extension String {
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
