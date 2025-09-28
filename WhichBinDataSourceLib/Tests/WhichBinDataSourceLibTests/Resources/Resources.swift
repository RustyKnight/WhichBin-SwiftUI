//
//  Resource.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 19/3/2025.
//

import Foundation

enum Resource {
    case mockedResponse
    case mockedNewResponse
    case mockedRestrictedResponse
    case multiPolygonResponse
    case singlePolygonResponse

    var url: URL {
        switch self {
        case .mockedResponse:
            return Bundle.module.url(forResource: "MockedResponse", withExtension: "json")!
        case .mockedNewResponse:
            return Bundle.module.url(forResource: "MockedNewResponse", withExtension: "json")!
        case .mockedRestrictedResponse:
            return Bundle.module.url(forResource: "MockedRestrictedResponse", withExtension: "json")!
        case .multiPolygonResponse:
            return Bundle.module.url(forResource: "MultiPolygonResponse", withExtension: "json")!
        case .singlePolygonResponse:
            return Bundle.module.url(forResource: "SinglePolygonResponse", withExtension: "json")!
        }
    }
    
    func data() throws -> Data {
        try Data(contentsOf: url)
    }
}
