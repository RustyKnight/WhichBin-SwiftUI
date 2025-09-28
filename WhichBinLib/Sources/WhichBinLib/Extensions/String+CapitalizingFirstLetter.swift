//
//  String+CapitalizingFirstLetter.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 3/9/2025.
//

extension String {
    
    /// Capitalize's the first letter of the string.
    /// - Returns: Capitalize's the first letter of the string.
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    /// Capitalize's the first letter of the string.
    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
