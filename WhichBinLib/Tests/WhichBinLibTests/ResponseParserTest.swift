//
//  ResponseParserTest.swift
//  WhichBin-SwiftUITests
//
//  Created by Shane Whitehead on 13/1/2024.
//

import XCTest
import Foundation
@testable import WhichBinLib
import MapKit

final class ResponseParserTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func mockedData() throws -> Data {
        // Should be using `Bundle.module`, but I can't see
        // to get it to work
        
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory
            .appending(component: "Resources", directoryHint: .isDirectory)
            .appendingPathComponent("MockedResponse.json")
        return try Data(contentsOf: resourceURL)
    }
    
    func mockedSinglePolygonData() throws -> Data {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory
            .appending(component: "Resources", directoryHint: .isDirectory)
            .appendingPathComponent("SinglePolygonResponse.json")
        return try Data(contentsOf: resourceURL)
    }
    
    func mockedMultiPolygonData() throws -> Data {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory
            .appending(component: "Resources", directoryHint: .isDirectory)
            .appendingPathComponent("MultiPolygonResponse.json")
        return try Data(contentsOf: resourceURL)
    }

    func testParseNewCollection() throws {
        let data = try mockedData()
        let collection = try JSONDecoder().decode(Collection.self, from: data)
    }

    func testParseNewEvents() throws {
        let data = try mockedData()
        let collection = try JSONDecoder().decode(Collection.self, from: data)
        
        assert(!collection.features.isEmpty, "Features can't be empty")
        
        let events = collection.features[0].events
        assert(!events.isEmpty, "Events can't be empty")
    }
}
