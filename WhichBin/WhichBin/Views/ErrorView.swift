//
//  ErrorView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 19/4/2025.
//

import SwiftUI

struct ErrorView: View {

    let title: String
    let subTitle: String?

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(.dumpsterDive)
                .renderingMode(.original)
                .resizable()
                .frame(width: 256, height: 256, alignment: .center)
            Text(title)
                .font(.title)
            if let subTitle {
                Text(subTitle)
            }
            Spacer()
        }
    }
}
