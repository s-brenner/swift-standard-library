import Foundation

extension String {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public struct FormatStyle: Foundation.FormatStyle {
        
        enum Style: Codable, Hashable {
            case base64Encoded(Encoding)
            case base64URLEncoded(Encoding)
            case camelcased
        }
        
        let style: Style
        
        init(style: Style) {
            self.style = style
        }
        
        public static func base64Encoded(encoding: Encoding = .utf8) -> Self {
            Self(style: .base64Encoded(encoding))
        }
        
        public static func base64URLEncoded(encoding: Encoding = .utf8) -> Self {
            Self(style: .base64URLEncoded(encoding))
        }
        
        public static let camelcased = Self(style: .camelcased)
        
        public func format(_ value: String) -> String {
            switch style {
            case .base64Encoded(let encoding):
                guard let data = value.data(using: encoding)
                else { return value }
                return data.base64EncodedString()
            case .base64URLEncoded(let encoding):
                guard let data = value.data(using: encoding)
                else { return value }
                return data.formatted(.base64URLEncoded())
            case .camelcased:
                let source = value.capitalized.removingAll([" ", "\n", "_"])
                let first = source[..<source.index(after: source.startIndex)].lowercased()
                let rest = String(source.dropFirst())
                return first + rest
            }
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func formatted(_ style: FormatStyle? = nil) -> String {
        style?.format(self) ?? self
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public var bytes: [UInt8] { .init(self.utf8) }
    
    /// Returns the Base-64 decoding of the receiver.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 decoding of the receiver.
    public func base64Decoded(using encoding: Encoding = .utf8) -> Self? {
        guard let data = Data(base64Encoded: self)
        else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    /// Returns the Base-64 URL decoding of the receiver.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Parameter encoding: The text encoding to use.
    /// - Returns: The Base-64 URL decoding of the receiver.
    public func base64URLDecoded(using encoding: Encoding = .utf8) -> Self? {
        guard let data = Data(base64URLEncoded: self)
        else { return nil }
        return String(data: data, encoding: encoding)
    }
    
    /// A random string of a prescribed length including only the allowed characters.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Parameter length: The number of characters in the output.
    /// - Parameter allowed: The characters allowed in the output.
    public init(
        randomWithLength length: Int,
        allowedCharacters allowed: AllowedCharacters = .alphaNumeric
    ) {
        self = String((0..<length).map { _ in allowed.characters.randomElement()! })
    }
    
    /// Returns a Boolean value that indicates whether the receiver contains only the allowed characters.
    /// - Author: Scott Brenner | SBStandardLibrary
    /// - Complexity: O(n), where n is the length of the receiver.
    /// - Parameter allowed: The characters allowed in the receiver.
    /// - Returns: `true` if receiver contains only the allowed characters; otherwise, `false`.
    public func contains(only allowed: AllowedCharacters) -> Bool {
        allowed.characters.contains(self, matchedBy: { $0 == $1 })
    }
    
    public enum AllowedCharacters {
        /// Allow all numbers from 0 to 9.
        case numeric
        /// Allow all alphabetic characters ignoring case.
        case alphabetic
        /// Allow both numbers and alphabetic characters ignoring case.
        case alphaNumeric
        /// Allow all characters appearing within the specified String.
        case allCharactersIn(String)
        
        var characters: Set<Character> {
            switch self {
            case .numeric:
                return Set("0123456789")
            case .alphabetic:
                return Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
            case .alphaNumeric:
                return Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
            case .allCharactersIn(let allowed):
                return Set(allowed)
            }
        }
        
        public static func +(lhs: Self, rhs: Self) -> Self {
            .allCharactersIn(String(lhs.characters.union(rhs.characters)))
        }
        
        public static func -(lhs: Self, rhs: Self) -> Self {
            .allCharactersIn(String(lhs.characters.subtracting(rhs.characters)))
        }
    }
}

extension String.Encoding: Codable { }
