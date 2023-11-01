import Foundation

struct WriteDiaryRequestQuery: Encodable {
    let title: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?

    init(
        title: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?
    ) {
        self.title = title
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case title
        case content
        case mood
        case tagList = "tag_list"
        case image
    }
}
