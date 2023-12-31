import Foundation

struct DiaryDetailEntity: Equatable {
    let id: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let createdAt: String
    let image: String?

    init(
        id: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        createdAt: String,
        image: String?
    ) {
        self.id = id
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.createdAt = createdAt
        self.image = image
    }
}

