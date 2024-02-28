import XCTest
@testable import SBStandardLibrary

final class SequenceExtensionsTests: XCTestCase {
    
    private struct Day: Hashable {
        
        let espressoShots: Int
        
        static let yesterday = Day(espressoShots: 4)
        static let today = Day(espressoShots: 2)
    }
    
    private let days: Set<Day> = [.yesterday, .today]
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    private enum Letter: String, Identifiable, CaseIterable {
        case a, b, c, d, e, f, g
        
        var id: String { rawValue }
        
        var number: Number {
            get async {
                await transform()
            }
        }
        
        var optionalNumber: Number? {
            get async {
                switch self {
                case .a: return nil
                default: return await transform()
                }
            }
        }
        
        private func transform() async -> Number {
            await withCheckedContinuation { continuation in
                DispatchQueue.global(qos: .background).async {
                    let index = Letter.identifiedAllCases.index(id: self.id)!
                    continuation.resume(returning: Number(rawValue: index + 1))
                }
            }
        }
    }
    
    private struct Number: RawRepresentable, Identifiable, Equatable, ExpressibleByIntegerLiteral {
        
        let rawValue: Int
        
        var id: Int { rawValue }
        
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        init(integerLiteral value: Int) {
            rawValue = value
        }
    }
    
    func testSum() {
        XCTAssertEqual(
            days.sum(for: \.espressoShots),
            Day.yesterday.espressoShots + Day.today.espressoShots
        )
    }
    
    func testMap() {
        let shots = days.map(\.espressoShots)
        XCTAssertEqual(shots.count, days.count)
        XCTAssertTrue(shots.contains(Day.yesterday.espressoShots))
        XCTAssertTrue(shots.contains(Day.today.espressoShots))
    }
    
    func testSorted() {
        XCTAssertEqual(
            days.sorted(by: \.espressoShots).first?.espressoShots,
            Day.today.espressoShots
        )
        XCTAssertEqual(
            days.sorted(by: \.espressoShots, ascending: false).first?.espressoShots,
            Day.yesterday.espressoShots
        )
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func testAsyncMap() async {
        let numbers = await Letter.identifiedAllCases.asyncMap { await $0.number }
        XCTAssertEqual(numbers, [1, 2, 3, 4, 5, 6, 7])
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func testAsyncCompactMap() async {
        let numbers = await Letter.identifiedAllCases.asyncCompactMap { await $0.optionalNumber }
        XCTAssertEqual(numbers, [2, 3, 4, 5, 6, 7])
    }
}
