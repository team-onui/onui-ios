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

    func shiftCount() -> Int {
        let now = Date()
        let autoUpdatingSystemCalendar = Calendar.autoupdatingCurrent
        var selectedDateComponents = DateComponents()

        guard let firstDate = moodOfWeekList.first?.createdAt else { return 0 }
        selectedDateComponents.year = firstDate.year
        selectedDateComponents.month = firstDate.month
        selectedDateComponents.day = firstDate.day
        let selectedDate = autoUpdatingSystemCalendar.date(from: selectedDateComponents)
        let days = autoUpdatingSystemCalendar.dateComponents([.day], from: selectedDate!, to: now).day

        return days!
    }
}
