import Foundation

struct ShortDiaryEntity: Equatable {
    let id: String
    let mood: MoodType
    let createdAt: String

    init(id: String, mood: MoodType, createdAt: String) {
        self.id = id
        self.mood = mood
        self.createdAt = createdAt
    }
}
