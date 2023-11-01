import Combine

struct PostTimelineUseCase {
    private let timelineRepository: any TimelineRepository

    init(timelineRepository: any TimelineRepository) {
        self.timelineRepository = timelineRepository
    }

    func execute(id: String) -> AnyPublisher<TimelineEntity, Error> {
        timelineRepository.postTimeline(id: id)
    }
}
