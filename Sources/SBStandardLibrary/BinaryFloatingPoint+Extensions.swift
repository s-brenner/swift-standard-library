import Foundation

extension BinaryFloatingPoint {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public var int: Int { Int(self) }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func roundedTo(places: Int = 0, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        let divisor = Self(pow(10, Double(places)))
        return (self * divisor).rounded(rule) / divisor
    }
}
