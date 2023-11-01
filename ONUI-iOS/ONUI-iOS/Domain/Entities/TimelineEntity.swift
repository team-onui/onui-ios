import Foundation

struct TimelineEntity: Equatable {
    let id: String
    let title: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?
    let dayOfWeek: DayOfWeekType
    let createdAt: String
    let isUpdated: Bool

    init(
        id: String,
        title: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?,
        dayOfWeek: DayOfWeekType,
        createdAt: String,
        isUpdated: Bool
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
        self.dayOfWeek = dayOfWeek
        self.createdAt = createdAt
        self.isUpdated = isUpdated
    }
}

