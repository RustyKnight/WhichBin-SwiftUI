//
//  NoSitesAvailableView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 7/9/2025.
//

import SwiftUI

struct NoSitesAvailableView: View {
    
    var onAddSite: (() -> Void)?
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Image.House.slash
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 128, height: 128)
                    .foregroundStyle(.secondary)
                Text("No sites available")
                    .font(.title)

                if let onAddSite {
                    RoundButton {
                        onAddSite()
                    } content: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                    Text("Add site")
                        .font(.caption)
                }


                Spacer()
            }
            Spacer()
        }
    }
}
