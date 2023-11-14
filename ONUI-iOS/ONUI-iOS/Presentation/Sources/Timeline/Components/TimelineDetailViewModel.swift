import Foundation
import SwiftUI

final class TimelineDetailViewModel: BaseViewModel {
    @Published var myComment: String = ""

    private let currentDate = Date()
    var title: String {
        "\(currentDate.month)월 \(currentDate.day)일"
    }

    @Published var commentList: [CommentEntity] = []
    
    private let postCommentUseCase: PostCommentUseCase
    private let fetchCommentUseCase: FetchCommentUseCase

    init(
        postCommentUseCase: PostCommentUseCase,
        fetchCommentUseCase: FetchCommentUseCase
    ) {
        self.postCommentUseCase = postCommentUseCase
        self.fetchCommentUseCase = fetchCommentUseCase
    }

    func onAppear(id: String) {
        fetchComment(id: id)
    }

    private func fetchComment(id: String) {
        addCancellable(fetchCommentUseCase.execute(id: id)) { [weak self] comment in
            self?.commentList = comment
        }
    }

    func postComment(id: String) {
        addCancellable(postCommentUseCase.execute(id: id, comment: myComment)) { [weak self] comment in
            self?.commentList.append(comment)
            self?.myComment = ""
        }
    }
}
