import Combine
import Foundation

struct WriteDiaryUseCase {
    private let diaryRepository: any DiaryRepository

    init(diaryRepository: any DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute(req: WriteDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error> {
        diaryRepository.writeDiary(req: req)
    }
}
