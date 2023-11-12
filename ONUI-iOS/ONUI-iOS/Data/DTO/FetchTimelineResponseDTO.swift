import Foundation

struct FetchTimelinesResponseDTO: Decodable {
    let content: [TimelineResponseDTO]
    let last: Bool

    init(content: [TimelineResponseDTO], last: Bool) {
        self.content = content
        self.last = last
    }
}

struct TimelineResponseDTO: Decodable {
    let id: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?
    let writer: String
    let commentCount: Int

    init(
        id: String,
        content: String,
        mood: MoodType,
        tagList: [String],
        image: String?,
        writer: String,
        commentCount: Int
    ) {
        self.id = id
        self.content = content
        self.mood = mood
        self.tagList = tagList
        self.image = image
        self.writer = writer
        self.commentCount = commentCount
    }

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case mood
        case tagList = "tag_list"
        case image
        case writer
        case commentCount = "comment_count"
    }
}

extension FetchTimelinesResponseDTO {
    func toDomain() -> TimelineListEntity {
        TimelineListEntity(content: content.map { $0.toDomain() }, last: last)
    }
}

extension TimelineResponseDTO {
    func toDomain() -> TimelineEntity {
        TimelineEntity(
            id: id,
            content: content,
            mood: mood,
            tagList: tagList,
            image: image,
            writer: writer,
            commentCount: commentCount
        )
    }
}
