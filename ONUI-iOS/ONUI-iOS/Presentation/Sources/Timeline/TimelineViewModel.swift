import Foundation

class TimelineViewModel: BaseViewModel {
    private let startPage = 0
    private var last = false
    var page: Int
    @Published var date = Date()
    @Published var timelineList: [TimelineEntity] = []
    var title: String {
        "\(date.month)월 \(date.day)일"
    }

    let fetchTimelinesUseCase: FetchTimelinesUseCase
    let fetchCommentUseCase: FetchCommentUseCase
    let postCommentUseCase: PostCommentUseCase

    init(
        fetchTimelinesUseCase: FetchTimelinesUseCase,
        fetchCommentUseCase: FetchCommentUseCase,
        postCommentUseCase: PostCommentUseCase
    ) {
        self.page = startPage
        self.fetchTimelinesUseCase = fetchTimelinesUseCase
        self.fetchCommentUseCase = fetchCommentUseCase
        self.postCommentUseCase = postCommentUseCase
    }
    
    func moveToNextMonth() {
        date = date.adding(by: .day, value: 1)
        onAppear()
    }
    func moveToPreviousMonth() {
        date = date.adding(by: .day, value: -1)
        onAppear()
    }

    func onAppear() {
        last = false
        self.page = startPage
        fetchTimelines()
    }

    func fetchTimelines() {
        if !last {
            addCancellable(
                fetchTimelinesUseCase.execute(index: page, size: 10, date: date.toString())
            ) { [weak self] timelines in
                self?.timelineList = timelines.content
                self?.last = timelines.last
            }
        }
    }

    func pagingTimelines() {
        page += 1
        fetchTimelines()
    }
}
