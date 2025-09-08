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
            static let filled = Image(systemName: "multiply.circle.fill")
            static let unfilled = Image(systemName: "multiply.circle")
        }
    }

    enum House {
        static let circle = Image(systemName: "house.circle")

        static let slash = Image(systemName: "house.slash")
    }

    enum Location {
        static let circle = Image(systemName: "location.circle")
    }

    enum Trash {
        enum Circle {
            static let unfilled = Image(systemName: "trash.circle")
            static let filled = Image(systemName: "trash.circle.fill")
        }
    }

    enum Question {
        enum Circle {
            static let filled = Image(systemName: "questionmark.circle.fill")
            static let unfilled = Image(systemName: "questionmark.circle")
        }
    }

    enum Checkmark {
        enum Circle {
            static let filled = Image(systemName: "checkmark.circle.fill")
            static let unfilled = Image(systemName: "checkmark.circle")
        }
    }
    
    enum Triangle {
        enum ExclamationMark {
            static let filled = Image(systemName: "exclamationmark.triangle.fill")
            static let unfilled = Image(systemName: "exclamationmark.triangle")
        }
    }
    
    enum Gear {
        static let filled = Image(systemName: "gearshape.fill")
        static let unfilled = Image(systemName: "gearshape")
    }
    
    enum Lock {
        enum Shield {
            static let filled = Image(systemName: "lock.shield.fill")
            static let unfilled = Image(systemName: "lock.shield")
        }
    }
}
