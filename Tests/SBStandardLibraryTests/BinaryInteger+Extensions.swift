import XCTest
@testable import SBStandardLibrary

final class BinaryIntegerExtensionsTests: XCTestCase {
    
    func testInterpolate() {
        XCTAssertNil(4.interpolate(between: (5, 2), and: (10, 7)))
        XCTAssertEqual(6.interpolate(between: (5, 2), and: (10, 7)), 3)
        XCTAssertNil(4.interpolate(between: (10, 7), and: (5, 2)))
        XCTAssertEqual(6.interpolate(between: (10, 7), and: (5, 2)), 3)
        XCTAssertNil((-6).interpolate(between: (-5, -2), and: (10, 7)))
        XCTAssertEqual(6.interpolate(between: (-5, -2), and: (10, 5.5)), 3.5)
    }
}
