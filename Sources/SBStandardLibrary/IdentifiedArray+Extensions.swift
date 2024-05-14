#if canImport(IdentifiedCollections)
extension IdentifiedArray {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func appending(_ item: Element) -> Self {
        var result = self
        result.append(item)
        return result
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func dictionary<T>(uncheckedUniqueKey keypath: KeyPath<Element, T>) -> [T: Element] {
        var dictionary = [T: Element]()
        for element in elements {
            let key = element[keyPath: keypath]
            dictionary.updateValue(element, forKey: key)
        }
        return dictionary
    }
}
#endif
