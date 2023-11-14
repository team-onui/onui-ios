import Combine

struct FetchCommentUseCase {
    private let commentRepository: any CommentRepository

    init(commentRepository: any CommentRepository) {
        self.commentRepository = commentRepository
    }

    func execute(id: String) -> AnyPublisher<[CommentEntity], Error> {
        commentRepository.fetchComment(id: id)
    }
}
