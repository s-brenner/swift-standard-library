extension BinaryInteger {
    
    /// Returns the `y` value for the value of `self` along the line between points `p0` and `p1`.
    ///- Author: Scott Brenner | SBFoundation
    ///- Parameter p0: The first point.
    ///- Parameter p1: The second point.
    ///- Returns: The `y` value for the value of `self` along the line between the two points or `nil` if the value of `self` is not along the line between the two points.
    public func interpolate<T>(between p0: (x: T, y: T), and p1: (x: T, y: T)) -> T?
    where T: FloatingPoint {
        T(self).interpolate(between: p0, and: p1)
    }
}