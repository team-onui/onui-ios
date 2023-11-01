import Foundation

enum ImageError: Error {
    case error
}

extension ImageError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
