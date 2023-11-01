import Foundation

struct PutDiaryRequestQuery: Encodable {
    let id: String
    let title: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?

    init(
        id: String,
        title: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case mood
        case tagList = "tag_list"
        case image
    }
}
