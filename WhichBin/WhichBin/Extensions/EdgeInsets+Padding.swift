//
//  Padding.swift
//  WhichBin
//
//  Created by Shane Whitehead on 13/9/2025.
//

import SwiftUI

extension EdgeInsets {
    struct Padding {
        static let extraSmall = EdgeInsets(
            top: .Padding.extraSmall,
            leading: .Padding.extraSmall,
            bottom: .Padding.extraSmall,
            trailing: .Padding.extraSmall
        )
        static let small = EdgeInsets(
            top: .Padding.small,
            leading: .Padding.small,
            bottom: .Padding.small,
            trailing: .Padding.small
        )
        static let standard = EdgeInsets(
            top: .Padding.standard,
            leading: .Padding.standard,
            bottom: .Padding.standard,
            trailing: .Padding.standard
        )
        static let large = EdgeInsets(
            top: .Padding.large,
            leading: .Padding.large,
            bottom: .Padding.large,
            trailing: .Padding.large
        )
        static let extraLarge = EdgeInsets(
            top: .Padding.extraLarge,
            leading: .Padding.extraLarge,
            bottom: .Padding.extraLarge,
            trailing: .Padding.extraLarge
        )
    }
}
