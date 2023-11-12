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

    private let fetchTimelinesUseCase: FetchTimelinesUseCase

    init(fetchTimelinesUseCase: FetchTimelinesUseCase) {
        self.page = startPage
        self.fetchTimelinesUseCase = fetchTimelinesUseCase
    }

    func onAppear() {
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
