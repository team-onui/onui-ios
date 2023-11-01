import Foundation

struct FetchDiaryDetailResponseDTO: Decodable {
    let id: String
    let name: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let createdAt: String
    let image: String?

    init(
        id: String,
        name: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        createdAt: String,
        image: String?
    ) {
        self.id = id
        self.name = name
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.createdAt = createdAt
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case content
        case mood
        case tagList = "tag_list"
        case createdAt = "created_at"
        case image
    }
}

extension FetchDiaryDetailResponseDTO {
    func toDomain() -> DiaryDetailEntity {
        DiaryDetailEntity(
            id: id,
            name: name,
            content: content,
            mood: mood,
            tagList: tagList,
            createdAt: createdAt,
            image: image
        )
    }
}
