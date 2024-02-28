import XCTest
@testable import SBStandardLibrary

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
final class CaseIterableExtensionsTests: XCTestCase {
    
    enum Letters: String, Identifiable, CaseIterable {
        case a, b, c, d, e, f, g
        
        var id: String { rawValue }
    }
    
    func testNext() {
        XCTAssertEqual(Letters.a.next(), .b)
        XCTAssertEqual(Letters.g.next(), .a)
        XCTAssertEqual(Letters.g.next(loopingInfinitely: false), .g)
    }
    
    func testIdentifiedAllCases() {
        XCTAssertEqual(Letters.identifiedAllCases, [.a, .b, .c, .d, .e, .f, .g])
    }
}
