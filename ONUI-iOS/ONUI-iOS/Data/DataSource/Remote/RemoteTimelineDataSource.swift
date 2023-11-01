import Combine

protocol RemoteTimelineDataSource {
    func postTimeline(id: String) -> AnyPublisher<TimelineEntity, Error>
    func fetchTimelines(index: Int, size: Int, dayOfWeek: DayOfWeekType) -> AnyPublisher<[TimelineEntity], Error>
}

final class RemoteTimelineDataSourceImpl: BaseRemoteDataSource<TimelineAPI>, RemoteTimelineDataSource {
    func postTimeline(id: String) -> AnyPublisher<TimelineEntity, Error> {
        request(.postTimeline(id: id), dto: TimelineResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchTimelines(index: Int, size: Int, dayOfWeek: DayOfWeekType) -> AnyPublisher<[TimelineEntity], Error> {
        request(
            .fetchTimelines(index: index, size: size, dayOfWeek: dayOfWeek),
            dto: FetchTimelinesResponseDTO.self
        )
        .map { $0.content.map { $0.toDomain() } }
        .eraseToAnyPublisher()
    }
}
