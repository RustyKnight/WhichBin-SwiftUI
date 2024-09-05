//
//  NextEventsTests.swift
//  WhichBinLib
//
//  Created by Shane Whitehead on 4/9/2024.
//
import XCTest
import Foundation
@testable import WhichBinLib
import MapKit

final class NextEventsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func mockedData() throws -> Data {
        // Should be using `Bundle.module`, but I can't see
        // to get it to work
        return try Data(contentsOf: mockedDataSourceUrl)
    }

    private var mockedDataSourceUrl: URL = {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory
            .appending(component: "Resources", directoryHint: .isDirectory)
            .appendingPathComponent("MockedResponse.json")
        return resourceURL
    }()

    private func mockedModel() async throws -> EventModel {
        try await EventModelFactory(
            targetLocation: CLLocationCoordinate2D(latitude: -38.1468737, longitude: 145.1201503),
            dataSourceURL: mockedDataSourceUrl
        ).load()
    }

    func testNextEventsOnOrAfterToday() throws {
        let waitFor = expectation(description: "Waiting for stuff")
        Task {
            let mockedModel = try await mockedModel()
            print("\n==========\n")
            let model = mockedModel.nextEventsOnOrAfterToday()

            print(">> model = \(model.map { $0.date.formattedDateTime })")

            let events = Dictionary(grouping: model) {
                $0.date.startOfDay
            }
            let sortedKeys = events.keys.sorted()
            print(">> sortedKeys = \(sortedKeys.map { $0.formattedDateTime })")

            waitFor.fulfill()
        }
        wait(for: [waitFor])
    }

    func testPreviousEventsBeforeToday() throws {
        let waitFor = expectation(description: "Waiting for stuff")
        Task {
            let mockedModel = try await mockedModel()
            print("\n==========\n")
            let model = mockedModel.previousEventsBeforeToday()

            print(">> model = \(model.map { $0.date.formattedDateTime })")

            let events = Dictionary(grouping: model) {
                $0.date.startOfDay
            }
            let sortedKeys = events.keys.sorted()
            print(">> sortedKeys = \(sortedKeys.map { $0.formattedDateTime })")

            waitFor.fulfill()
        }
        wait(for: [waitFor])
    }
}
