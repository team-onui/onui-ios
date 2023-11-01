import Combine
import Foundation

protocol TimelineRepository {
    func postTimeline(id: String) -> AnyPublisher<TimelineEntity, Error>
    func fetchTimelines(index: Int, size: Int, dayOfWeek: DayOfWeekType) -> AnyPublisher<[TimelineEntity], Error>
}
