//
//  RoundButton.swift
//  WhichBin
//
//  Created by Shane Whitehead on 19/4/2025.
//

import SwiftUI

public struct RoundButton<ButtonContent: View>: View {

    let action: () -> Void
    let content: () -> ButtonContent

    public var body: some View {
        Button {
            action()
        } label: {
            content()
        }
        .buttonStyle(CircleButtonStyle())
    }
}

struct CircleButtonStyle: ButtonStyle {

    let fillColor: Color = .blue

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .padding()
            .modifier(MakeSquareBounds())
            .background(
                Circle()
                    .fill(fillColor)
            )

    }
}

struct MakeSquareBounds: ViewModifier {

    @State var size: CGFloat = 1000
    func body(content: Content) -> some View {
        let c = ZStack {
            content.alignmentGuide(HorizontalAlignment.center) { (vd) -> CGFloat in
                DispatchQueue.main.async {
                    self.size = max(vd.height, vd.width)
                }
                return vd[HorizontalAlignment.center]
            }
        }
        return c.frame(width: size, height: size)
    }
}
