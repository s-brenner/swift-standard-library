import Foundation

extension Comparable {
    
    /// Moves the value to a range of allowed values.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Parameter range: The range of allowed values.
    public func clamped(to range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}

extension Comparable where Self: SignedNumeric {
    
    /// Check if a number is negative.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var isNegative: Bool { self < 0 }
    
    /// Check if a number is positive.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var isPositive: Bool { self > 0 }
    
    /// The absolute value of a number.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var abs: Self { return Swift.abs(self) }
}
