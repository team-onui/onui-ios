import Foundation

enum AnalysisError: Error {
    case error
}

extension AnalysisError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            return "error!!!!!!!!!"
        }
    }
}
