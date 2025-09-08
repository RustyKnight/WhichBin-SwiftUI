//
//  Button+Okay.swift
//  WhichBin
//
//  Created by Shane Whitehead on 6/9/2025.
//

import SwiftUI

extension Button where Label == Text {
    static func okay(_ action: (() -> Void)? = nil) -> some View {
        Button("Okay") {
            action?()
        }
    }
}
