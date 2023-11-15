import Foundation

struct ShortDiaryEntity: Equatable {
    let id: String
    let mood: MoodType
    let createdAt: Date

    init(id: String, mood: MoodType, createdAt: Date) {
        self.id = id
        self.mood = mood
        self.createdAt = createdAt
    }
}
