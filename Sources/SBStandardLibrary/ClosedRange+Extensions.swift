import Foundation

extension ClosedRange {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public static func ~=(lhs: Self, rhs: Self) -> Bool {
        rhs.clamped(to: lhs) == rhs
    }
}
