import XCTest
@testable import SBStandardLibrary

final class GlobalTests: XCTestCase {
    
    func testInterpolate() {
        XCTAssertNil(interpolate(x: 4, x1: 5, y1: 2, x2: 10, y2: 7))
        XCTAssertEqual(interpolate(x: 6, x1: 5, y1: 2, x2: 10, y2: 7), 3)
        XCTAssertNil(interpolate(x: 4, x1: 10, y1: 7, x2: 5, y2: 2))
        XCTAssertEqual(interpolate(x: 6, x1: 10, y1: 7, x2: 5, y2: 2), 3)
        XCTAssertNil(interpolate(x: -6, x1: -5, y1: -2, x2: 10, y2: 7))
        XCTAssertEqual(interpolate(x: 6, x1: -5, y1: -2, x2: 10, y2: 5.5), 3.5)
    }
}
