//
//  Event.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

import Foundation

/// Describes a collection event.
public protocol Event {
    /// Bin for this collection event.
    var bin: Bin { get }
    /// Date of this collection event.
    var date: Date { get }
}
