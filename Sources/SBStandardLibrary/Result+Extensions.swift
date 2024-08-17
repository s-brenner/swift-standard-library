import Foundation

extension Result {
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func replaceError(with replacement: Success) -> Success {
        replaceError { _ in replacement }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func replaceError(_ transform: (Failure) -> Success) -> Success {
        switch self {
        case .success(let success): return success
        case .failure(let error): return transform(error)
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func fatalError(_ transform: (Failure) -> String) -> Success {
        switch self {
        case .success(let success): return success
        case .failure(let error): Swift.fatalError(transform(error))
        }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func replaceNil<NewSuccess>(with replacement: NewSuccess) -> Result<NewSuccess, Failure> {
        replaceNil { _ in replacement }
    }
    
    /// - Author: Scott Brenner | SBStandardLibrary
    public func replaceNil<NewSuccess>(_ transform: (Success?) -> NewSuccess) -> Result<NewSuccess, Failure> {
        map(transform)
    }
}

extension Result: Codable
where Success: Codable, Failure: Codable & Error {
    
    enum CodingKeys: String, CodingKey {
        case success
        case failure
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .success(let success):
            try container.encode(success, forKey: .success)
        case .failure(let failure):
            try container.encode(failure, forKey: .failure)
        }
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self = .success(try container.decode(Success.self, forKey: .success))
        }
        catch {
            self = .failure(try container.decode(Failure.self, forKey: .failure))
        }
    }
}
