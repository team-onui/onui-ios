import Foundation

struct ShortDiaryEntity: Equatable, Hashable {
    let id: String
    let mood: Mood
    let createdAt: Date

    init(id: String, mood: Mood, createdAt: Date) {
        self.id = id
        self.mood = mood
        self.createdAt = createdAt
    }
}
