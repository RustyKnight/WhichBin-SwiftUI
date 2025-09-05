//
//  SizeModifier.swift
//  WhichBin
//
//  Created by Shane Whitehead on 5/9/2025.
//

import SwiftUI

extension Image {
    func size(_ size: CGFloat.Size) -> some View {
        self.resizable()
            .frame(
                width: size.rawValue,
                height: size.rawValue
            )
    }
}
