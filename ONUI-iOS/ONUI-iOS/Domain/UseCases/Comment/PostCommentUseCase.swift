import Combine

struct PostCommentUseCase {
    private let commentRepository: any CommentRepository

    init(commentRepository: any CommentRepository) {
        self.commentRepository = commentRepository
    }

    func execute(id: String, comment: String) -> AnyPublisher<CommentEntity, Error> {
        commentRepository.postComment(id: id, comment: comment)
    }
}
