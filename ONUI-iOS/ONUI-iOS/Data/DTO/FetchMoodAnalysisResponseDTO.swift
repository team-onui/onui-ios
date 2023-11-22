import Foundation

struct FetchMoodAnalysisResponseDTO: Decodable {
    let veryBad: Int
    let bad: Int
    let normal: Int
    let good: Int
    let veryGood: Int

    enum CodingKeys: String, CodingKey {
        case veryBad = "worst"
        case bad = "bad"
        case normal = "not_bad"
        case good = "fine"
        case veryGood = "good"
    }
}

extension FetchMoodAnalysisResponseDTO {
    func toDomain() -> MoodAnalysisEntity {
        MoodAnalysisEntity(
            veryBad: veryBad,
            bad: bad,
            normal: normal,
            good: good,
            veryGood: veryGood
        )
    }
}
