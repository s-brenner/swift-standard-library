import Foundation

extension Data {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public init?(base64URLEncoded input: String) {
        var base64 = input
        base64 = base64.replacingOccurrences(of: "-", with: "+")
        base64 = base64.replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64 = base64.appending("=")
        }
        self.init(base64Encoded: base64)
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public struct FormatStyle: Foundation.FormatStyle {
        
        enum Style: Codable, Hashable {
            case base64Encoded(Data.Base64EncodingOptions)
            case base64URLEncoded(Data.Base64EncodingOptions)
            case prettyPrintedJSON
            case string(String.Encoding)
        }
        
        let style: Style
        
        init(style: Style) {
            self.style = style
        }
        
        /// - Author: Scott Brenner | SBStandardLibrary
        public static func base64Encoded(options: Data.Base64EncodingOptions = []) -> Self {
            Self(style: .base64Encoded(options))
        }
        
        /// - Author: Scott Brenner | SBStandardLibrary
        public static func base64URLEncoded(options: Data.Base64EncodingOptions = []) -> Self {
            Self(style: .base64URLEncoded(options))
        }
        
        /// - Author: Scott Brenner | SBStandardLibrary
        public static let prettyPrintedJSON = Self(style: .prettyPrintedJSON)
        
        /// - Author: Scott Brenner | SBStandardLibrary
        public static func string(encoding: String.Encoding = .utf8) -> Self {
            Self(style: .string(encoding))
        }
        
        /// - Author: Scott Brenner | SBStandardLibrary
        public func format(_ value: Data) -> String {
            switch style {
            case .base64Encoded(let options):
                return value.base64EncodedString(options: options)
            case .base64URLEncoded(let options):
                var result = value.formatted(.base64Encoded(options: options))
                result = result.replacingOccurrences(of: "+", with: "-")
                result = result.replacingOccurrences(of: "/", with: "_")
                result = result.replacingOccurrences(of: "=", with: "")
                return result
            case .prettyPrintedJSON:
                guard let object = try? JSONSerialization.jsonObject(with: value, options: []),
                    let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                    let string = String(data: data, encoding: .utf8)
                else { return "" }
                return string
            case .string(let encoding):
                return String(data: value, encoding: encoding) ?? ""
            }
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func formatted(_ style: FormatStyle = .string()) -> String {
        style.format(self)
    }
}

extension Data.Base64EncodingOptions: Codable, Hashable { }
