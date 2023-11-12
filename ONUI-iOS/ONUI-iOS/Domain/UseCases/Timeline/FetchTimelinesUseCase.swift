import Combine

struct FetchTimelinesUseCase {
    private let timelineRepository: any TimelineRepository

    init(timelineRepository: any TimelineRepository) {
        self.timelineRepository = timelineRepository
    }

    func execute(index: Int, size: Int, date: String) -> AnyPublisher<TimelineListEntity, Error> {
        timelineRepository.fetchTimelines(index: index, size: size, date: date)
    }
}
