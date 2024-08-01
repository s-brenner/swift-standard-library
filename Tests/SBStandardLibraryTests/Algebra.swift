import XCTest
@testable import SBStandardLibrary

final class AlgebraTests: XCTestCase {
    
    func testInterpolate() {
        XCTAssertNil(4.interpolate(between: (5, 2), and: (10, 7)))
        XCTAssertEqual(6.interpolate(between: (5, 2), and: (10, 7)), 3)
        XCTAssertNil(4.interpolate(between: (10, 7), and: (5, 2)))
        XCTAssertEqual(6.interpolate(between: (10, 7), and: (5, 2)), 3)
        XCTAssertNil((-6).interpolate(between: (-5, -2), and: (10, 13)))
        XCTAssertEqual(6.interpolate(between: (-5, -2), and: (10, 5.5)), 3.5)
        XCTAssertNil(10.interpolate(between: (10, 10), and: (10, 20)))
    }
    
    func testExtrapolate() {
        XCTAssertEqual(4.extrapolate(from: (5, 2), and: (10, 7)), 1)
        XCTAssertNil(6.extrapolate(from: (5, 2), and: (10, 7)))
        XCTAssertEqual(4.extrapolate(from: (10, 7), and: (5, 2)), 1)
        XCTAssertNil(6.extrapolate(from: (10, 7), and: (5, 2)))
        XCTAssertEqual((-6).extrapolate(from: (-5, -2), and: (10, 13)), -3)
        XCTAssertNil(6.extrapolate(from: (-5, -2), and: (10, 5.5)))
        XCTAssertNil(11.extrapolate(from: (10, 10), and: (10, 20)))
    }
}
