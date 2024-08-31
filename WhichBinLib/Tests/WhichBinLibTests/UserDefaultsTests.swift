import XCTest
@testable import WhichBinLib
import CoreLocation

final class UserDefaultsTests: XCTestCase {
    func testLocation() throws {
        let defaults = UserDefaults()
        defaults.set(.init(latitude: 100, longitude: 200), forKey: "location.test")

        let location = defaults.location(forKey: "location.test")
        XCTAssertNotNil(location)
        XCTAssertEqual(location?.latitude ?? 0, 100)
        XCTAssertEqual(location?.longitude ?? 0, 200)
    }
}
