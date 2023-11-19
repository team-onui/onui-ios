import Combine

struct FetchMissionListUseCase {
    private let missionRepository: MissionRepository

    init(missionRepository: MissionRepository) {
        self.missionRepository = missionRepository
    }

    func execute() -> AnyPublisher<[MissionEntity], Error> {
        missionRepository.fetchMissionList()
    }
}
