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

#if canImport(IdentifiedCollections) && (os(iOS) || os(macOS) || os(watchOS) || os(tvOS))
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension CaseIterable where Self: Identifiable {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public static var identifiedAllCases: IdentifiedArrayOf<Self> { IdentifiedArrayOf(uniqueElements: allCases) }
}
#endif
