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
    case multiPolygonResponse
    case singlePolygonResponse

    var url: URL {
        switch self {
        case .mockedResponse: return url(for: "MockedResponse.json")
        case .mockedNewResponse: return url(for: "MockedNewResponse.json")
        case .multiPolygonResponse: return url(for: "MultiPolygonResponse.json")
        case .singlePolygonResponse: return url(for: "SinglePolygonResponse.json")
        }
    }

    private func url(for name: String) -> URL {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()

        return thisDirectory
//            .appending(component: "Resources", directoryHint: .isDirectory)
            .appendingPathComponent(name)
    }

    func data() throws -> Data {
        try Data(contentsOf: url)
    }
}
