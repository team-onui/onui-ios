import Foundation
import Combine

struct TimelineRepositoryImpl: TimelineRepository {
    private let remoteTimelineDataSource: any RemoteTimelineDataSource

    init(remoteTimelineDataSource: any RemoteTimelineDataSource) {
        self.remoteTimelineDataSource = remoteTimelineDataSource
    }
    
    func postTimeline(id: String) -> AnyPublisher<TimelineEntity, Error> {
        remoteTimelineDataSource.postTimeline(id: id)
    }

    func fetchTimelines(index: Int, size: Int, dayOfWeek: DayOfWeekType) -> AnyPublisher<[TimelineEntity], Error> {
        remoteTimelineDataSource.fetchTimelines(index: index, size: size, dayOfWeek: dayOfWeek)
    }
}
