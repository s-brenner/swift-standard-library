import Foundation

extension StringProtocol {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func firstIndex<S>(of string: S, options: String.CompareOptions = []) -> Index?
    where S: StringProtocol {
        range(of: string, options: options)?.lowerBound
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func endIndexOfFirstOccurrence<S>(of string: S, options: String.CompareOptions = []) -> Index?
    where S: StringProtocol {
        range(of: string, options: options)?.upperBound
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func indices<S>(of string: S, options: String.CompareOptions = []) -> [Index]
    where S: StringProtocol {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func ranges<S>(of string: S, options: String.CompareOptions = []) -> [Range<Index>]
    where S: StringProtocol {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
            result.append(range)
            startIndex = if range.lowerBound < range.upperBound {
                range.upperBound
            }
            else {
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
            }
        }
        return result
    }
}
