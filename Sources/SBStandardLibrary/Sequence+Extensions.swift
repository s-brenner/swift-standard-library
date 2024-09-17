import Foundation

extension Sequence {
    
    /// Returns the sum of the values of a given numeric property within this sequence.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Parameter keyPath: The numeric property to sum.
    /// - Returns: The sum of the values of a given numeric property within this sequence.
    public func sum<T>(for keyPath: KeyPath<Element, T>) -> T
    where T: Numeric {
        reduce(0) { sum, element in
            sum + element[keyPath: keyPath]
        }
    }
    
    /// Returns an array containing the results of mapping the given property over the sequence’s elements.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Parameter keyPath: The property to map.
    /// - Returns: An array of the results of mapping the given property over the this sequence's elements.
    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
    
    /// Returns an array containing the `non-nil`elements  of this sequence.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Complexity: O(m + n), where n is the length of this sequence and m is the length of the result.
    /// - Returns: An array containing the `non-nil`elements  of this sequence.
    public func compact<T>() -> [T]
    where Element == Optional<T> {
        compactMap { $0 }
    }
    
    /// Returns the elements of the sequence sorted according to any comparable property.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Complexity: O(n log n), where n is the length of the sequence.
    /// - Parameter keyPath: The comparable property by which to sort to the sequence.
    /// - Parameter ascending: The order in which to sort the sequence.
    /// - Returns: An array of sorted elements.
    public func sorted<T>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element]
    where T: Comparable {
        sorted { a, b in
            let aa = a[keyPath: keyPath]
            let bb = b[keyPath: keyPath]
            return ascending ? aa < bb : aa > bb
        }
    }
    
    /// Returns a Boolean value indicating whether every element of a given sequence contains an element of the receiver that satisfies the matcher.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Complexity: O(n * m), where n and m are the lengths of the sequences.
    /// - Parameter values: The given sequence.
    /// - Parameter matcher: A function that compares an element of the receiver to an element of the given sequence.
    /// - Parameter element: An element of the receiver sequence.
    /// - Parameter valuesElement: An element of the provided sequence.
    /// - Returns: `true` if the sequence contains only elements matched by the matcher; otherwise, `false`.
    public func contains<T: Sequence>(
        _ values: T,
        matchedBy matcher: (_ element: Element, _ valuesElement: T.Element) -> Bool
    ) -> Bool {
        values.allSatisfy { value in
            contains(where: { matcher($0, value) })
        }
    }
    
    /// Returns the count of elements that should be counted based on the given closure.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Parameter shouldBeCounted: A closure that determines if a given element should be counted.
    /// - Parameter element: The element of the sequence.
    /// - Returns: The count of elements that satisfy the given closure.
    /// - Complexity: O(n), where n is the length of the sequence.
    /// - Note: Based on `reduce(_:_:)`.
    public func count(where shouldBeCounted: (_ element: Element) throws -> Bool) rethrows -> Int {
        try reduce(0) {
            let additive = try shouldBeCounted($1) ? 1 : 0
            return $0 + additive
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @_disfavoredOverload
    public func asyncMap<ElementOfResult>(
        _ transform: (Element) async throws -> ElementOfResult
    ) async rethrows -> [ElementOfResult] {
        try await reduce(into: [ElementOfResult]()) { collection, element in
            try await collection.append(transform(element))
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func asyncForEach(_ operation: (Element) async throws -> Void) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func reduce<Result>(
        into initialResult: Result,
        _ updateAccumulatingResult: (inout Result, Element) async throws -> ()
    ) async rethrows -> Result {
        var initialResult = initialResult
        for element in self {
            try await updateAccumulatingResult(&initialResult, element)
        }
        return initialResult
    }
}

#if canImport(IdentifiedCollections)
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension Sequence where Element: Identifiable {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func asyncMap<ElementOfResult>(
        _ transform: (Element) async throws -> ElementOfResult
    ) async rethrows -> IdentifiedArrayOf<ElementOfResult>
    where ElementOfResult: Identifiable {
        try await reduce(into: IdentifiedArrayOf<ElementOfResult>()) { collection, element in
            try await collection.append(transform(element))
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func asyncCompactMap<ElementOfResult>(
        _ transform: (Element) async throws -> ElementOfResult?
    ) async rethrows -> IdentifiedArrayOf<ElementOfResult>
    where ElementOfResult: Identifiable {
        try await reduce(into: IdentifiedArrayOf<ElementOfResult>()) { collection, element in
            if let transformed = try await transform(element) {
                collection.append(transformed)
            }
        }
    }
}
#endif
