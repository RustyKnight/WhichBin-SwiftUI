//
//  CGFloat+Padding.swift
//  WhichBin
//
//  Created by Shane Whitehead on 4/9/2025.
//

import Foundation

extension CGFloat {
    enum Padding {
        static let extraSmall: CGFloat = 4.0
        static let small: CGFloat = 8.0
        static let standard: CGFloat = 16.0
        static let large: CGFloat = 24.0
        static let extraLarge: CGFloat = 32.0
    }

    enum Size: CGFloat {
        case small4 = 4.0
        case small8 = 8.0
        case medium16 = 16.0
        case medium24 = 24.0
        case large32 = 32.0
        case extraLarge64 = 64.0
    }
}

