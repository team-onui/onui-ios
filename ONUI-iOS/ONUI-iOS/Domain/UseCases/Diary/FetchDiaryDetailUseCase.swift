import Combine
import Foundation

struct FetchDiaryDetailUseCase {
    private let diaryRepository: any DiaryRepository

    init(diaryRepository: any DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute(date: Date) -> AnyPublisher<DiaryDetailEntity, Error> {
        diaryRepository.fetchDiaryDetail(date: date)
    }
}
