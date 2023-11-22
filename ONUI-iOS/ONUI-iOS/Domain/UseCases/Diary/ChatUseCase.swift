import Combine
import Foundation

struct ChatUseCase {
    private let diaryRepository: any DiaryRepository

    init(diaryRepository: any DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute(moodDetail: [String]) -> AnyPublisher<String, Error> {
        diaryRepository.chat(moodDetail: moodDetail)
    }
}
