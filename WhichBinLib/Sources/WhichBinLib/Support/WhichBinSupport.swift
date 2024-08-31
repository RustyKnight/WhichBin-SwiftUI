//
//  WhichBinSupport.swift
//
//
//  Created by Shane Whitehead on 9/8/2024.
//

import Foundation

public struct WhichBinSupport {
    public static let rubbishEpoch = PropertyDTO.date(from: "20170103")!
    public static let recycleEpoch = PropertyDTO.date(from: "20120110")!
    public static let greenEpoch = PropertyDTO.date(from: "20120103")!
    public static let glassEpoch = PropertyDTO.date(from: "20231010")!
}
