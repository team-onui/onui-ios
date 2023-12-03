import Foundation

final class MainViewModel: BaseViewModel {
    @Published var isNavigatedToCalendar = false
    @Published var rice = 0
    @Published var moodOfWeekList: [ShortDiaryEntity] = []
    @Published var missionList: [MissionEntity] = []

    private let fetchMoodOfWeekUseCase: FetchMoodOfWeekUseCase
    private let fetchMissionListUseCase: FetchMissionListUseCase
    private let fetchMyRiceUseCase: FetchMyRiceUseCase

    init(
        fetchMoodOfWeekUseCase: FetchMoodOfWeekUseCase,
        fetchMissionListUseCase: FetchMissionListUseCase,
        fetchMyRiceUseCase: FetchMyRiceUseCase
    ) {
        self.fetchMoodOfWeekUseCase = fetchMoodOfWeekUseCase
        self.fetchMissionListUseCase = fetchMissionListUseCase
        self.fetchMyRiceUseCase = fetchMyRiceUseCase
    }

    func onAppear() {
        fetchMoodOfWeek()
        fetchMissionList()
        fetchMyRice()
    }

    private func fetchMyRice() {
        addCancellable(fetchMyRiceUseCase.execute()) { rice in
            self.rice = rice
        }
    }

    private func fetchMissionList() {
        addCancellable(fetchMissionListUseCase.execute()) { missionList in
            self.missionList = missionList
        }
    }

    private func fetchMoodOfWeek() {
        addCancellable(fetchMoodOfWeekUseCase.execute()) { moodOfWeek in
            self.moodOfWeekList = moodOfWeek
        }
    }

    func sevenDaysAgoDay() -> [Date] {
        let range = Array(0..<7)
        return range.map {
            Date(timeIntervalSinceNow: TimeInterval((-86400) * $0))
        }.reversed()
    }
}
