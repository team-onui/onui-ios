import Foundation

struct FetchCommentResponseDTO: Decodable {
    let commentList: [CommentResponseDTO]?
    
    enum CodingKeys: String, CodingKey {
        case commentList = "comment_list"
    }
}

struct CommentResponseDTO: Decodable {
    let id: String
    let timeline: String
    let userTheme: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case timeline
        case userTheme = "user_theme"
        case content
    }
}

extension FetchCommentResponseDTO {
    func toDomain() -> [CommentEntity] {
        guard let commentList else { return [] }
        return commentList.map { $0.toDomain() }
    }
}

extension CommentResponseDTO {
    func toDomain() -> CommentEntity {
        CommentEntity(id: id, timeline: timeline, userTheme: userTheme, content: content)
    }
}
