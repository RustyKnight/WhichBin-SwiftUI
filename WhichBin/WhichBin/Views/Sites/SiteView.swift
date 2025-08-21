//
//  SiteView.swift
//  WhichBin
//
//  Created by Shane Whitehead on 20/4/2025.
//

import SwiftUI

struct SiteView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var siteManager: SiteManager

    @ObservedObject
    var viewModel: SiteViewModel

    @State
    var selectLocation = false

    @State
    var selectDataSource = false

    var body: some View {
        VStack(spacing: 20) {
            titleView

            nameView

            locationView

            descriptionView

            dataSourceView

            Spacer()

            HStack {
                cancelButton
                saveButton
            }
        }
        .padding()
        .sheet(isPresented: $selectLocation) {
            LocationView(viewModel: .init())
        }
        .sheet(isPresented: $selectDataSource) {
            Text("Hello")
        }
    }
}

private extension SiteView {
    var titleView: some View {
        HStack {
            Text("Site Details")
                .font(.title)
            Spacer()
            Image.House.circle
                .resizable()
                .frame(width: 32, height: 32)
        }
    }

    var nameView: some View {
        HStack {
            Text("Name")
            Spacer()
            TextField(
                "Name",
                text: $viewModel.name
            )
            .multilineTextAlignment(.trailing)
            .lineLimit(1)
        }
    }

    var locationView: some View {
        Button {
            selectLocation.toggle()
        } label: {
            HStack {
                Text("Location")

                Spacer()

                if let coordinates = viewModel.coordinates {
                    Text("\(coordinates.latitude), \(coordinates.longitude)")
                } else {
                    Text("---")
                }

                Image.Chevron.right
                    .foregroundStyle(.secondary)
                    .padding(.leading)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    var descriptionView: some View {
        HStack {
            Text("Description")
            Spacer()
            TextField(
                "Description",
                text: $viewModel.description
            )
            .multilineTextAlignment(.trailing)
            //            .lineLimit(1)
        }
    }

    var dataSourceView: some View {
        Button {

        } label: {
            HStack {
                Text("Data source")

                Spacer()

                if let coordinates = viewModel.coordinates {
                    Text("\(coordinates.latitude), \(coordinates.longitude)")
                } else {
                    Text("---")
                }

                Image.Chevron.right
                    .foregroundStyle(.secondary)
                    .padding(.leading)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    var saveButton: some View {
        Button {
            // update site details ...
        } label: {
            Text("Save")
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(Color.green)

    }

    var cancelButton: some View {
        CancelButton {
            dismiss()
        }
    }
}

#Preview {
    SiteView(viewModel: .init())
}
