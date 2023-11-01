import Foundation

struct DiaryResponseDTO: Decodable {
    let id: String
    let name: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?

    init(
        id: String,
        name: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?
    ) {
        self.id = id
        self.name = name
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case content
        case mood
        case tagList = "tag_list"
        case image
    }
}

extension DiaryResponseDTO {
    func toDomain() -> DiaryEntity {
        DiaryEntity(
            id: id,
            name: name,
            content: content,
            mood: mood,
            tagList: tagList,
            image: image
        )
    }
}

