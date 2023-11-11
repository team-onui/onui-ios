import Combine

protocol DiaryRepository {
    func writeDiary(req: WriteDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfMonth(year: Int, month: Int) -> AnyPublisher<[ShortDiaryEntity], Error>
    func fetchDiaryDetail(id: String) -> AnyPublisher<DiaryDetailEntity, Error>
    func putDiary(req: PutDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfWeek() -> AnyPublisher<[ShortDiaryEntity], Error>
}
