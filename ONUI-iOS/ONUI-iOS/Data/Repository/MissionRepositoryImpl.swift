import Foundation
import Combine

struct MissionRepositoryImpl: MissionRepository {
    private let remoteMissionDataSource: any RemoteMissionDataSource

    init(remoteMissionDataSource: any RemoteMissionDataSource) {
        self.remoteMissionDataSource = remoteMissionDataSource
    }

    func completeMission(id: String) -> AnyPublisher<[MissionEntity], Error> {
        remoteMissionDataSource.completeMission(id: id)
    }

    func fetchMissionList() -> AnyPublisher<[MissionEntity], Error> {
        remoteMissionDataSource.fetchMissionList()
    }
}
