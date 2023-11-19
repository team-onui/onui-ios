import Combine

protocol RemoteMissionDataSource {
    func completeMission(id: String) -> AnyPublisher<[MissionEntity], Error>
    func fetchMissionList() -> AnyPublisher<[MissionEntity], Error>
}

final class RemoteMissionDataSourceImpl: BaseRemoteDataSource<MissionAPI>, RemoteMissionDataSource {
    func completeMission(id: String) -> AnyPublisher<[MissionEntity], Error> {
        request(.completeMission(id), dto: FetchMissionListResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchMissionList() -> AnyPublisher<[MissionEntity], Error> {
        request(.fetchMissionList, dto: FetchMissionListResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
