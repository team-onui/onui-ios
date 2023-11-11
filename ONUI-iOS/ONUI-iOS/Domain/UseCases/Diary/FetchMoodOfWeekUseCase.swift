import Combine
import Foundation

struct FetchMoodOfWeekUseCase {
    private let diaryRepository: any DiaryRepository

    init(diaryRepository: any DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute() -> AnyPublisher<[ShortDiaryEntity], Error> {
        diaryRepository.fetchMoodOfWeek()
    }
}
