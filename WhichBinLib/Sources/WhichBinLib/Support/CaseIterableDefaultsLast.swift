//
//  CaseIterableDefaultsLast.swift
//
//
//  Created by Shane Whitehead on 13/1/2024.
//

import Foundation

protocol CaseIterableDefaultsLast: Decodable & CaseIterable & RawRepresentable where RawValue: Decodable, AllCases: BidirectionalCollection { }

extension CaseIterableDefaultsLast {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }
}
