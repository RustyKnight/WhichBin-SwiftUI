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

    private let trailingPadding: CGFloat = 36

    var body: some View {
        VStack(spacing: 20) {
            titleView

            nameView

            locationView

            descriptionView

            dataSourceView

            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    verifyActionView
                    verificationStatusView
                }
            }

            Spacer()

            HStack {
                cancelButton
                saveButton
            }
        }
        .padding()
        .sheet(isPresented: $selectLocation) {
            LocationView(viewModel: .init(target: $viewModel.locationTarget))
        }
        .sheet(isPresented: $selectDataSource) {
            if let location = viewModel.locationTarget?.location {
                DataSourceListView(viewModel: .init(location: location))
            } else {
                EmptyView()
            }
        }
    }
}

private extension SiteView {

    var titleView: some View {
        HStack {
            Image.Trash.Circle.unfilled
                .resizable()
                .frame(width: 32, height: 32)
            Text("Site Details")
                .font(.title)
            Spacer()
        }
        .padding(.bottom, 32)
    }

    var nameView: some View {
        HStack {
            Text("Name")
                .foregroundStyle(.secondary)

            Spacer()
            TextField(
                "Friendly Name",
                text: $viewModel.name
            )
            .multilineTextAlignment(.trailing)
            .lineLimit(1)
            .padding(.trailing, trailingPadding)
        }
    }

    var locationView: some View {
        Button {
            selectLocation.toggle()
        } label: {
            HStack {
                Text("Location")
                    .foregroundStyle(.secondary)

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
        HStack(alignment: .top) {
            Text("Description")
                .foregroundStyle(.secondary)
            Spacer()
            TextField(
                "Address or other descriptive details",
                text: $viewModel.description,
                axis: .vertical
            )
            .multilineTextAlignment(.trailing)
            .lineLimit(5...10)
        }
        .padding(.trailing, trailingPadding)
    }

    var dataSourceView: some View {
        Button {
            selectDataSource.toggle()
        } label: {
            HStack {
                Text("Collection schedule")
                    .foregroundStyle(.secondary)

                Spacer()

                Text("---")

                Image.Chevron.right
                    .foregroundStyle(.secondary)
                    .padding(.leading)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(viewModel.locationTarget == nil)
    }

    @ViewBuilder
    var verifyActionView: some View {
        if viewModel.isVerifying {
            ProgressView()
        } else {
            Button {

            } label: {
                HStack {
                    Text("Verify")
                    verifyImageView
                }
            }
            .disabled(viewModel.canVerify == false)
        }
    }

    var verificationColor: Color {
        switch viewModel.verificationState {
        case .none:
            return .secondary
        case .failed:
            return .red
        case .successful:
            return .green
        }
    }

    @ViewBuilder
    var verificationStatusView: some View {
        switch viewModel.verificationState {
        case .none:
            EmptyView()

        case .failed:
            Text("Verification failed - location may not be within specified collection area!")
                .multilineTextAlignment(.trailing)
                .foregroundStyle(.red)
                .font(.caption)

        case .successful:
            Text("Verification was successful")
                .multilineTextAlignment(.trailing)
                .foregroundStyle(.green)
                .font(.caption)
        }
    }

    @ViewBuilder
    var verifyImageView: some View {
        switch viewModel.verificationState {
        case .none:
            Image(systemName: "checkmark.circle")

        case .failed, .successful:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(verificationColor)
        }
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
        .disabled(viewModel.canSave == false)

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
