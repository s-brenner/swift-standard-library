import XCTest
@testable import SBStandardLibrary

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
final class IdentifiedArrayExtensionsTests: XCTestCase {
    
    private enum Letter: String, CaseIterable, Identifiable {
        case a, b, c, d, e, f, g
        
        var id: String { rawValue }
        
        var code: String { rawValue + rawValue }
    }
    
    func testAppending() {
        var letters = Letter.identifiedAllCases
        letters.removeFirst()
        XCTAssertEqual(letters.appending(.a), [.b, .c, .d, .e, .f, .g, .a])
    }
    
    func testDictionary() {
        XCTAssertEqual(
            Letter.identifiedAllCases.dictionary(uncheckedUniqueKey: \.code),
            ["aa": .a, "bb": .b, "cc": .c, "dd": .d, "ee": .e, "ff": .f, "gg": .g]
        )
    }
}
