import Combine
import Foundation

struct FetchMoodOfMonthUseCase {
    private let diaryRepository: any DiaryRepository

    init(diaryRepository: any DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute(year: Int, month: Int) -> AnyPublisher<[ShortDiaryEntity], Error> {
        diaryRepository.fetchMoodOfMonth(year: year, month: month)
    }
}
