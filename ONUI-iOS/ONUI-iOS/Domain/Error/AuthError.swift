import Foundation

public enum AuthError: Error {
    case error
}

extension AuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
