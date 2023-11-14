import Combine

protocol RemoteCommentDataSource {
    func postComment(id: String, comment: String) -> AnyPublisher<CommentEntity, Error>
    func fetchComment(id: String) -> AnyPublisher<[CommentEntity], Error>
}

final class RemoteCommentDataSourceImpl: BaseRemoteDataSource<CommentAPI>, RemoteCommentDataSource {
    
    func postComment(id: String, comment: String) -> AnyPublisher<CommentEntity, Error> {
        request(.postComment(id: id, comment: comment), dto: CommentResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchComment(id: String) -> AnyPublisher<[CommentEntity], Error> {
        request(.fetchComment(id: id), dto: FetchCommentResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
