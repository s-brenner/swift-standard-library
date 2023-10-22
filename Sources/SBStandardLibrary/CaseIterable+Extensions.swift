#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
extension CaseIterable where AllCases.Element: Equatable {
    
    /// Returns the next element in the array of all cases.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Returns: The next element.
    public func next(loopingInfinitely: Bool = true) -> Self {
        let index = Self.allCases.firstIndex(of: self)!
        var nextIndex = Self.allCases.index(after: index)
        if nextIndex == Self.allCases.endIndex {
            if loopingInfinitely {
                nextIndex = Self.allCases.startIndex
            }
            else {
                nextIndex = index
            }
        }
        return Self.allCases[nextIndex]
    }
}
#endif
