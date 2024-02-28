#if canImport(IdentifiedCollections)
extension IdentifiedArray {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func appending(_ item: Element) -> Self {
        var result = self
        result.append(item)
        return result
    }
}
#endif
