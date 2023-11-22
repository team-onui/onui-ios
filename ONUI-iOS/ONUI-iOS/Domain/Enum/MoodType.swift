import Foundation

enum MoodType: String, Codable {
    case worst = "WORST"
    case bad = "BAD"
    case notBad = "NOT_BAD"
    case fine = "FINE"
    case good = "GOOD"
}

extension MoodType {
    func toDomain() -> Mood {
        switch self {
        case .worst:
            return .veryBad
        case .bad:
            return .bad
        case .notBad:
            return .normal
        case .fine:
            return .good
        case .good:
            return .veryGood
        }
    }
}
