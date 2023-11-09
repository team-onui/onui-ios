import Foundation

struct WriteDiaryRequestQuery: Encodable {
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?

    init(
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?
    ) {
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case content
        case mood
        case tagList = "tag_list"
        case image
    }
}
