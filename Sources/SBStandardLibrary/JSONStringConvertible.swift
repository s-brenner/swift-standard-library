import Foundation

/// - Author: Scott Brenner | SBStandardLibrary
public protocol JSONStringConvertible: Encodable {
    
    /// A pretty printed JSON description of this instance.
    /// - Author: Scott Brenner | SBStandardLibrary
    var jsonDescription: String { get }
}

extension JSONStringConvertible {
    
    public var jsonDescription: String {
        guard let data = try? JSONEncoder().encode(self)
        else { return "" }
        return data.formatted(.prettyPrintedJSON)
    }
}
