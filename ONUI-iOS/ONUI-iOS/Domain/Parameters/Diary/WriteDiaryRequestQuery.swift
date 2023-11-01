import Foundation

struct WriteDiaryRequestQuery: Encodable {
    let name: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?

    init(
        name: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?
    ) {
        self.name = name
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case name
        case content
        case mood
        case tagList = "tag_list"
        case image
    }
}
