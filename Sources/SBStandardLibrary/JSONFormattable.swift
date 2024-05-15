import Foundation

/// Conform to this protocol and `Encodable` to be able to use `formatted(.prettyPrintedJSON)`.
/// - Author: Scott Brenner | SBStandardLibrary
public protocol JSONFormattable { }

/// - Author: Scott Brenner | SBStandardLibrary
public struct JSONFormatStyle<T>: Foundation.FormatStyle
where T: JSONFormattable & Encodable {
    
    public enum Style: Codable {
        case prettyPrintedJSON
    }
    
    public let style: Style
    
    init(style: Style) {
        self.style = style
    }
    
    public static var prettyPrintedJSON: Self { JSONFormatStyle(style: .prettyPrintedJSON) }
    
    public func format(_ value: T) -> String {
        switch style {
        case .prettyPrintedJSON:
            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(value)
            else { return "" }
            return data.formatted(.prettyPrintedJSON)
        }
    }
}

extension Encodable
where Self: JSONFormattable {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func formatted(_ style: JSONFormatStyle<Self> = .prettyPrintedJSON) -> String {
        style.format(self)
    }
}
