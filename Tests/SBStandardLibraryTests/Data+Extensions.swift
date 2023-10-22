import XCTest
@testable import SBStandardLibrary

final class DataExtensionsTests: XCTestCase {
        
    func testString() {
        let data = "Foo".data(using: .utf8)!
        XCTAssertEqual(data.formatted(), String(data: data, encoding: .utf8))
    }
}
