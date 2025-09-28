//
//  Bin.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 10/4/2025.
//

/// Available bin types.
public enum Bin: Sendable, CaseIterable, Hashable, Identifiable {
    public var id: Self { self }
    
    case rubbish
    case recycling
    case greenWaste
    case glass
}
