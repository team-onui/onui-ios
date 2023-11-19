import Foundation

final class MissionViewModel: BaseViewModel {
    @Published var missionList: [MissionEntity] = []
    private let fetchMissionListUseCase: FetchMissionListUseCase
    private let completeMissionUseCase: CompleteMissionUseCase

    init(fetchMissionListUseCase: FetchMissionListUseCase, completeMissionUseCase: CompleteMissionUseCase) {
        self.fetchMissionListUseCase = fetchMissionListUseCase
        self.completeMissionUseCase = completeMissionUseCase
    }

    func onAppear() {
        fetchMissionList()
    }

    private func fetchMissionList() {
        addCancellable(fetchMissionListUseCase.execute()) { mission in
            self.missionList = mission
        }
    }

    func completeMission(id: String) {
        addCancellable(completeMissionUseCase.execute(id: id)) { mission in
            self.missionList = mission
        }
    }
}
