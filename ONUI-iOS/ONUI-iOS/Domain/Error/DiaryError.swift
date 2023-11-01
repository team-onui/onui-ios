import Foundation

public enum DiaryError: Error {
    case error
}

extension DiaryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
