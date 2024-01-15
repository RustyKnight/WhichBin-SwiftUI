//
//  Image+RawRepresentable.swift
//  WhichBin-SwiftUI
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation
import SwiftUI

extension Image {
    init<ImageName: RawRepresentable>(_ name: ImageName) where ImageName.RawValue == String {
        self.init(name.rawValue)
    }
}
