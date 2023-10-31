import Foundation

public enum UserError: Error {
    case error
}

extension UserError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
