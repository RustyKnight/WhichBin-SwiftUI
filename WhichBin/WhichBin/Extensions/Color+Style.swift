//
//  Color+Style.swift
//  WhichBin
//
//  Created by Shane Whitehead on 8/9/2025.
//

import SwiftUI
import CoreExtensions

extension Color {
    static var navigationBarBackground: Color {
        Color.background.darken(by: 0.3)
    }
}

extension Color {
    func darken(by amount: Double) -> Color {
        Color(UIColor(self).darken(by: amount))
    }

    func brighten(by amount: Double) -> Color {
        Color(UIColor(self).darken(by: amount))
    }
}

extension UIColor {
    var asRGBA: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    func darken(by: Double) -> UIColor {
        let rgb = asRGBA
        
        let red = max(0, (rgb.red) - CGFloat(1.0 * by))
        let green = max(0, (rgb.green) - CGFloat(1.0 * by))
        let blue = max(0, (rgb.blue) - CGFloat(1.0 * by))
        let alpha = rgb.alpha
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func brighten(by: Double) -> UIColor {
        let rgb = asRGBA
        
        let red = min(1.0, (rgb.red) + CGFloat(1.0 * by))
        let green = min(1.0, (rgb.green) + CGFloat(1.0 * by))
        let blue = min(1.0, (rgb.blue) + CGFloat(1.0 * by))
        let alpha = rgb.alpha
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
