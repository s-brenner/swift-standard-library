import Foundation

extension FloatingPoint {
    
    /// Radian value of degree input.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var degreesToRadians: Self { self * .pi / 180 }
    
    /// Degree value of radian input.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var radiansToDegrees: Self { self * 180 / .pi }
    
    /// The ceiling of a number.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var ceil: Self { Foundation.ceil(self) }
    
    /// The floor of number.
    /// - Author: Scott Brenner | SBStandardLibrary
    public var floor: Self { Foundation.floor(self) }
}
