import Foundation

struct ShortDiaryEntity: Equatable {
    let id: String
    let mood: MoodType
    let createdDay: Int

    init(id: String, mood: MoodType, createdDay: Int) {
        self.id = id
        self.mood = mood
        self.createdDay = createdDay
    }
}
