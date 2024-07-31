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
    
    /// Returns the `y` value for the value of `self` along the line between points `p0` and `p1`.
    ///- Author: Scott Brenner | SBStandardLibrary
    ///- Parameter p0: The first point.
    ///- Parameter p1: The second point.
    ///- Returns: The `y` value for the value of `self` along the line between the two points or `nil` if the value of `self` is not along the line between the two points.
    ///- Note: A `nil` return value indicates that extrapolation is necessary.
    public func interpolate(between p0: (x: Self, y: Self), and p1: (x: Self, y: Self)) -> Self? {
        if p0.x <= p1.x,
           (p0.x...p1.x).contains(self) {
            let m = (p1.y - p0.y) / (p1.x - p0.x)
            return (m * (self - p0.x)) + p0.y
        }
        else if p1.x <= p0.x,
                (p1.x...p0.x).contains(self) {
            return interpolate(between: p1, and: p0)
        }
        else {
            return nil
        }
    }
    
    /// Returns the `y` value for the value of `self` along the line extended from points `p0` and `p1`.
    ///- Author: Scott Brenner | SBStandardLibrary
    ///- Parameter p0: The first point.
    ///- Parameter p1: The second point.
    ///- Returns: The `y` value for the value of `self` along the line extended from the two points or `nil` if the value of `self` is along the line between the two points.
    ///- Note: A `nil` return value indicates that interpolation is necessary.
    public func extrapolate(from p0: (x: Self, y: Self), and p1: (x: Self, y: Self)) -> Self? {
        if p0.x <= p1.x,
           !(p0.x...p1.x).contains(self) {
            let m = (p1.y - p0.y) / (p1.x - p0.x)
            return (m * (self - p0.x)) + p0.y
        }
        else if p1.x <= p0.x,
                !(p1.x...p0.x).contains(self) {
            return extrapolate(from: p1, and: p0)
        }
        else {
            return nil
        }
    }
}
