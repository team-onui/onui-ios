import Combine

struct CompleteMissionUseCase {
    private let missionRepository: MissionRepository

    init(missionRepository: MissionRepository) {
        self.missionRepository = missionRepository
    }

    func execute(id: String) -> AnyPublisher<[MissionEntity], Error> {
        missionRepository.completeMission(id: id)
    }
}
