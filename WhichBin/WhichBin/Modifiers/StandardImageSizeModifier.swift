//
//  StandardImageSizeModifier.swift
//  WhichBin
//
//  Created by Shane Whitehead on 9/9/2025.
//

import SwiftUI

struct StandardImageSizeModifier: ViewModifier {
    
    enum Size {
        case extraSmall8
        case small12
        case medium16
        case large24
        case extraLarge32
        case big64
        case custom(Double)
        
        var size: Double {
            switch self {
            case .extraSmall8: return 8
            case .small12: return 12
            case .medium16: return 16
            case .large24: return 24
            case .extraLarge32: return 32
            case .big64: return 64
            case .custom(let value): return value
            }
        }
    }
    
    let size: Size

    public func body(content: Content) -> some View {
        content
            .frame(width: size.size, height: size.size)
    }
}

extension View {
    func standard(size: StandardImageSizeModifier.Size) -> some View {
        modifier(StandardImageSizeModifier(size: size))
    }
}
