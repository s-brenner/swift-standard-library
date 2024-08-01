import XCTest
@testable import SBStandardLibrary

final class FloatingPointExtensionsTests: XCTestCase {
    
    func testCeil() {
        XCTAssertEqual(Float(9.3).ceil, Float(10.0))
        XCTAssertEqual(Double(9.3).ceil, Double(10.0))
    }
    
    func testDegreesToRadians() {
        XCTAssertEqual(Float(180).degreesToRadians, .pi)
        XCTAssertEqual(Double(180).degreesToRadians, .pi)
    }
    
    func testFloor() {
        XCTAssertEqual(Float(9.3).floor, Float(9.0))
        XCTAssertEqual(Double(9.3).floor, Double(9.0))
    }
    
    func testRadiansToDegrees() {
        XCTAssertEqual(Float.pi.radiansToDegrees, Float(180))
        XCTAssertEqual(Double.pi.radiansToDegrees, Double(180))
    }
    
    func testClamped() {
        XCTAssertEqual(Float(9.3).clamped(to: 3.2...6.1), 6.1)
        XCTAssertEqual(Double(-2.3).clamped(to: 0...1), 0)
        XCTAssertEqual(Double(-4.2).clamped(to: -10...10), -4.2)
    }
    
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
