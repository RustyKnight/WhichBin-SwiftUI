//
//  DataSource+Description.swift
//  WhichBin
//
//  Created by Shane Whitehead on 4/9/2025.
//

import WhichBinLib

extension DataSource {
    public var locationDescription: String {
        "\(city.description), \(city.state.description), \(city.state.country.description)"
    }
}
