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

    func fetchTimelines(index: Int, size: Int, date: String) -> AnyPublisher<TimelineListEntity, Error> {
        remoteTimelineDataSource.fetchTimelines(index: index, size: size, date: date)
    }
}
