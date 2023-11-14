import Foundation

enum CommentError: Error {
    case error
}

extension CommentError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
