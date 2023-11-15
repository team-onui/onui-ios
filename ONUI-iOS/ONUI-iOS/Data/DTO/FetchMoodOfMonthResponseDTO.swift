import Foundation

struct FetchMoodOfMonthResponseDTO: Decodable {
    let diaries: [ShortDiaryResponseDTO]?

    init(diaries: [ShortDiaryResponseDTO]?) {
        self.diaries = diaries
    }
}

struct ShortDiaryResponseDTO: Decodable {
    let id: String
    let mood: MoodType
    let createdAt: String

    init(id: String, mood: MoodType, createdAt: String) {
        self.id = id
        self.mood = mood
        self.createdAt = createdAt
    }

    enum CodingKeys: String, CodingKey {
        case id
        case mood
        case createdAt = "created_at"
    }
}

extension FetchMoodOfMonthResponseDTO {
    func toDomain() -> [ShortDiaryEntity] {
        guard let diaries else { return [] }

        return diaries.map {
            ShortDiaryEntity(id: $0.id, mood: $0.mood, createdAt: $0.createdAt.toDate())
        }
    }
}
