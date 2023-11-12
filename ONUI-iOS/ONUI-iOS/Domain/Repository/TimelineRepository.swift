import Combine
import Foundation

protocol TimelineRepository {
    func postTimeline(id: String) -> AnyPublisher<TimelineEntity, Error>
    func fetchTimelines(index: Int, size: Int, date: String) -> AnyPublisher<TimelineListEntity, Error>
}
