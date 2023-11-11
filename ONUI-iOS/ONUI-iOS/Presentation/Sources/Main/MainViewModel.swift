import Foundation

final class MainViewModel: BaseViewModel {
    @Published var isNavigatedToCalendar = false
    @Published var moodOfWeekList: [ShortDiaryEntity] = []

    private let fetchMoodOfWeekUseCase: FetchMoodOfWeekUseCase

    init(fetchMoodOfWeekUseCase: FetchMoodOfWeekUseCase) {
        self.fetchMoodOfWeekUseCase = fetchMoodOfWeekUseCase
    }

    func onAppear() {
        fetchMoodOfWeek()
    }

    private func fetchMoodOfWeek() {
        addCancellable(fetchMoodOfWeekUseCase.execute()) { moodOfWeek in
            self.moodOfWeekList = moodOfWeek
        }
    }
}
