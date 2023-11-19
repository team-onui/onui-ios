import Foundation

enum MissionError: Error {
    case error
}

extension MissionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
