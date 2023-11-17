import Foundation

enum ShopError: Error {
    case error
}

extension ShopError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
