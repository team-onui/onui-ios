import Combine

protocol RemoteTimelineDataSource {
    func postTimeline(id: String) -> AnyPublisher<TimelineEntity, Error>
    func fetchTimelines(index: Int, size: Int, date: String) -> AnyPublisher<TimelineListEntity, Error>
}

final class RemoteTimelineDataSourceImpl: BaseRemoteDataSource<TimelineAPI>, RemoteTimelineDataSource {
    func postTimeline(id: String) -> AnyPublisher<TimelineEntity, Error> {
        request(.postTimeline(id: id), dto: TimelineResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchTimelines(index: Int, size: Int, date: String) -> AnyPublisher<TimelineListEntity, Error> {
        request(
            .fetchTimelines(index: index, size: size, date: date),
            dto: FetchTimelinesResponseDTO.self
        )
        .map { $0.toDomain() }
        .eraseToAnyPublisher()
    }
}
