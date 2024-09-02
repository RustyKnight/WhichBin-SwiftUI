import XCTest
@testable import WhichBinLib

final class DateTests: XCTestCase {
    func testTimeTillNextHour() throws {

        let durationTillNextHour = Calendar
            .current
            .date(bySettingHour: 1, minute: 59, second: 0, of: Date())!
            .durationTillNextHour

        XCTAssertTrue(durationTillNextHour == 60)
    }
}
