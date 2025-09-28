import Testing
import Foundation
@testable import WhichBinLib

fileprivate let dateFormat = Date.FormatStyle().weekday(.abbreviated).day().month(.abbreviated).year()

@Test func testCalendar() {
    let calendar = Calendar.autoupdatingCurrent
    print(calendar.previous(.monday).formatted(dateFormat))
    print(calendar.next(.monday).formatted(dateFormat))
}
