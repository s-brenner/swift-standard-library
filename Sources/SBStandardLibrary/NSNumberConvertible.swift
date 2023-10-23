import Foundation

/// - Author: Scott Brenner | SBStandardLibrary
public protocol NSNumberConvertible {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    var nsNumber: NSNumber { get }
}

extension Decimal: NSNumberConvertible {
    
    public var nsNumber: NSNumber { self as NSNumber }
}

extension Double: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension Float: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension Int8: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension Int32: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension Int: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension Int64: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension Int16: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension UInt8: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension UInt32: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension UInt: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension UInt64: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}

extension UInt16: NSNumberConvertible {
    
    public var nsNumber: NSNumber { NSNumber(value: self) }
}
