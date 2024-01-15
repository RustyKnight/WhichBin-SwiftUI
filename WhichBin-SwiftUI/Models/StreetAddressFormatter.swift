////
////  StreetAddressFormatter.swift
////  WhichBin-SwiftUI
////
////  Created by Shane Whitehead on 13/1/2024.
////
//
//import Foundation
//
///// A formatter to convert a `PostalAddressable` to a
///// human readable representation
//protocol StreetAddressFormatter {
//    associatedtype Address: PostalAddressable
//    func string(from: Address) -> String
//}
//
//struct AnyStreetAddressFormatter<Address>: StreetAddressFormatter where Address: PostalAddressable {
//    private let format: (Address) -> String
//    
//    init<Formatter: StreetAddressFormatter>(_ formatter: Formatter) where Formatter.Address == Address {
//        format = formatter.string
//    }
//    
//    func string(from address: Address) -> String {
//        return format(address)
//    }
//}
