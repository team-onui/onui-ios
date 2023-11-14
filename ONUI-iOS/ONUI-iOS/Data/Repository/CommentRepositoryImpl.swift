import Foundation
import Combine

struct CommentRepositoryImpl: CommentRepository {
    private let remoteCommentDataSource: any RemoteCommentDataSource

    init(remoteCommentDataSource: any RemoteCommentDataSource) {
        self.remoteCommentDataSource = remoteCommentDataSource
    }

    func postComment(id: String, comment: String) -> AnyPublisher<CommentEntity, Error> {
        remoteCommentDataSource.postComment(id: id, comment: comment)
    }

    func fetchComment(id: String) -> AnyPublisher<[CommentEntity], Error> {
        remoteCommentDataSource.fetchComment(id: id)
    }
}
