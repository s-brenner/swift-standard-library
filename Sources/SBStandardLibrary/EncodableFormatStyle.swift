import Foundation

/// - Author: Scott Brenner | SBStandardLibrary
public struct EncodableFormatStyle<T>: Foundation.FormatStyle
where T: Encodable {
    
    public enum Style: Codable {
        case prettyPrintedJSON
    }
    
    public let style: Style
    
    init(style: Style) {
        self.style = style
    }
    
    public static var prettyPrintedJSON: Self { Self(style: .prettyPrintedJSON) }
    
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

extension Encodable {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    @_disfavoredOverload
    public func formatted(_ style: EncodableFormatStyle<Self> = .prettyPrintedJSON) -> String {
        style.format(self)
    }
}
