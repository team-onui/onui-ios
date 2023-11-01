import Foundation

struct FetchTimelinesResponseDTO: Decodable {
    let content: [TimelineResponseDTO]

    init(content: [TimelineResponseDTO]) {
        self.content = content
    }
}

struct TimelineResponseDTO: Decodable {
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

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case mood
        case tagList = "tag_list"
        case image
        case dayOfWeek = "day_of_week"
        case createdAt = "created_at"
        case isUpdated = "is_updated"
    }
}

extension TimelineResponseDTO {
    func toDomain() -> TimelineEntity {
        TimelineEntity(
            id: id,
            title: title,
            content: content,
            mood: mood,
            tagList: tagList,
            image: image,
            dayOfWeek: dayOfWeek,
            createdAt: createdAt,
            isUpdated: isUpdated
        )
    }
}
