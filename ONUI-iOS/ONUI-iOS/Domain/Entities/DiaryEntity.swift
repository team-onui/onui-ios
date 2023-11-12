import Foundation

struct DiaryEntity: Equatable {
    let id: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?

    init(
        id: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?
    ) {
        self.id = id
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
    }
}

