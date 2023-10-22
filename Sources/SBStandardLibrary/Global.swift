/// Generic utility function that configures an object.
/// - Author: Scott Brenner | SBStandardLibrary
public func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}
