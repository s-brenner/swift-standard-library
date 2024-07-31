/// Generic utility function that configures an object.
/// - Author: Scott Brenner | SBStandardLibrary
public func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}

/// Returns the `y` value for the given `x` value along the line between points `(x1, y1)` and `(x2, y2)`.
///- Author: Scott Brenner | SBStandardLibrary
///- Parameter x: The given `x` value. Must be between `x1` and `x2` or between `x2` and `x1`.
///- Parameter x1: The `x` value for the first point.
///- Parameter y2: The `y` value for the first point.
///- Parameter x2: The `x` value for the second point.
///- Parameter y2: The `y` value for the second point.
///- Returns: The `y` value for the given `x` value along the line between the two points or `nil` if the given `x` value is not along the line between the two points.
public func interpolate<T>(x: T, x1: T, y1: T, x2: T, y2: T) -> T?
where T: FloatingPoint {
    if x1 <= x2,
       (x1...x2).contains(x) {
        let m = (y2 - y1) / (x2 - x1)
        return (m * (x - x1)) + y1
    }
    else if x2 <= x1,
            (x2...x1).contains(x) {
        return interpolate(x: x, x1: x2, y1: y2, x2: x1, y2: y1)
    }
    else {
        return nil
    }
}
