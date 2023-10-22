import Foundation

extension Float {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public var double: Double { Double(self) }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public var cgFloat: CGFloat { CGFloat(self) }
    
    /// Rounded to nearest or away from zero.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var int: Int { Int(self.rounded(.toNearestOrAwayFromZero)) }
}
