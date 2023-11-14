import Foundation

struct TimelineListEntity: Equatable, Hashable {
    let content: [TimelineEntity]
    let last: Bool

    init(content: [TimelineEntity], last: Bool) {
        self.content = content
        self.last = last
    }
}

struct TimelineEntity: Equatable, Hashable {
    let id: String
    let content: String
    let mood: MoodType
    let tagList: [String]
    let image: String?
    let writer: String
    var commentCount: Int

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
}

