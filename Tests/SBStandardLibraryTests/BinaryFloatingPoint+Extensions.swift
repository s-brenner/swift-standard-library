import XCTest
@testable import SBStandardLibrary

final class BinaryFloatingPointExtensionsTests: XCTestCase {
    
    func testInt() {
        XCTAssertEqual(Double(-1).int, -1)
        XCTAssertEqual(Double(2).int, 2)
        XCTAssertEqual(Double(4.3).int, 4)
        
        XCTAssertEqual(Float(-1).int, -1)
        XCTAssertEqual(Float(2).int, 2)
        XCTAssertEqual(Float(4.3).int, 4)
        
        XCTAssertEqual(CGFloat(-1).int, -1)
        XCTAssertEqual(CGFloat(2).int, 2)
        XCTAssertEqual(CGFloat(4.3).int, 4)
    }
    
    func testRoundedTo() {
        XCTAssertEqual(Double.pi.roundedTo(places: 5), 3.14159)
        XCTAssertEqual(-Double.pi.roundedTo(places: 4), -3.1416)
    }
}
