import Combine
import Foundation

struct PutDiaryUseCase {
    private let diaryRepository: any DiaryRepository

    init(diaryRepository: any DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute(req: PutDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error> {
        diaryRepository.putDiary(req: req)
    }
}
