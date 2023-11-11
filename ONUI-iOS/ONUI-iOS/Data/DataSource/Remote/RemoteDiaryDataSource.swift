import Combine

protocol RemoteDiaryDataSource {
    func writeDiary(req: WriteDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfMonth(year: Int, month: Int) -> AnyPublisher<[ShortDiaryEntity], Error>
    func fetchDiaryDetail(id: String) -> AnyPublisher<DiaryDetailEntity, Error>
    func putDiary(req: PutDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfWeek() -> AnyPublisher<[ShortDiaryEntity], Error>
}

final class RemoteDiaryDataSourceImpl: BaseRemoteDataSource<DiaryAPI>, RemoteDiaryDataSource {
    func writeDiary(req: WriteDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error> {
        request(.writeDiary(req), dto: DiaryResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchMoodOfMonth(year: Int, month: Int) -> AnyPublisher<[ShortDiaryEntity], Error> {
        request(.fetchMoodOfMonth(year: year, month: month), dto: FetchMoodOfMonthResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchDiaryDetail(id: String) -> AnyPublisher<DiaryDetailEntity, Error> {
        request(.fetchDiaryDetail(id: id), dto: FetchDiaryDetailResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func putDiary(req: PutDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error> {
        request(.putDiary(req), dto: DiaryResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchMoodOfWeek() -> AnyPublisher<[ShortDiaryEntity], Error> {
        request(.fetchMoodOfWeek, dto: FetchMoodOfMonthResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
