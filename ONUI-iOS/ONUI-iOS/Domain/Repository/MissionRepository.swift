import Combine

protocol MissionRepository {
    func completeMission(id: String) -> AnyPublisher<[MissionEntity], Error>
    func fetchMissionList() -> AnyPublisher<[MissionEntity], Error>
}
