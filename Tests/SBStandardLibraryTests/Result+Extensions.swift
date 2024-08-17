import XCTest
@testable import SBStandardLibrary

final class ResultExtensionsTests: XCTestCase {
    
    func testReplacements() throws {
        var result = Result<String?, URLError>.failure(URLError(.badServerResponse))
        XCTAssertEqual(result.replaceError(with: "Hello"), "Hello")
        result = .success(nil)
        XCTAssertTrue(try result.replaceNil(with: true).get())
    }
    
    enum Error: Swift.Error, Codable {
        case somethingBadHappened
    }
    
    func testCodable() throws {
        let success = Result<Bool, Error>.success(true)
        let failure = Result<Bool, Error>.failure(.somethingBadHappened)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        XCTAssertEqual(try decoder.decode(Result<Bool, Error>.self, from: try encoder.encode(success)), success)
        XCTAssertEqual(try decoder.decode(Result<Bool, Error>.self, from: try encoder.encode(failure)), failure)
        XCTAssertNotEqual(try decoder.decode(Result<Bool, Error>.self, from: try encoder.encode(failure)), success)
    }
}
