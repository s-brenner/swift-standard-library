import Foundation

extension Double {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public var float: Float { Float(self) }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public var cgFloat: CGFloat { CGFloat(self) }
    
    /// Rounded to nearest or away from zero.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var int: Int { Int(self.rounded(.toNearestOrAwayFromZero)) }
}
