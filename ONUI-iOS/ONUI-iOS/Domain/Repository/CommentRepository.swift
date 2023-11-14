import Combine
import Foundation

protocol CommentRepository {
    func postComment(id: String, comment: String) -> AnyPublisher<CommentEntity, Error>
    func fetchComment(id: String) -> AnyPublisher<[CommentEntity], Error>
}
