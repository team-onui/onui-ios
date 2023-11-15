import Combine
import Foundation

protocol DiaryRepository {
    func writeDiary(req: WriteDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfMonth(year: Int, month: Int) -> AnyPublisher<[ShortDiaryEntity], Error>
    func fetchDiaryDetail(date: Date) -> AnyPublisher<DiaryDetailEntity, Error>
    func putDiary(req: PutDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfWeek() -> AnyPublisher<[ShortDiaryEntity], Error>
}
