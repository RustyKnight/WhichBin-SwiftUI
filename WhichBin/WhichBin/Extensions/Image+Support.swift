//
//  Image+Support.swift
//  WhichBin
//
//  Created by Shane Whitehead on 21/4/2025.
//

import SwiftUI

extension Image {
    enum Chevron {
        static let right = Image(systemName: "chevron.right")
    }

    static let magnifyingGlass = Image(systemName: "magnifyingglass")

    enum Multiply {
        enum Circle {
            static let fill = Image(systemName: "multiply.circle.fill")
        }
    }

    enum House {
        static let circle = Image(systemName: "house.circle")

        static let slash = Image(systemName: "house.slash")
    }

    enum Location {
        static let circle = Image(systemName: "location.circle")
    }
}
