import Foundation

enum TimelineError: Error {
    case error
}

extension TimelineError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
