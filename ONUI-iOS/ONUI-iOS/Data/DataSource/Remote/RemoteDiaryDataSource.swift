import Combine
import Foundation

protocol RemoteDiaryDataSource {
    func writeDiary(req: WriteDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfMonth(year: Int, month: Int) -> AnyPublisher<[ShortDiaryEntity], Error>
    func fetchDiaryDetail(date: Date) -> AnyPublisher<DiaryDetailEntity, Error>
    func putDiary(req: PutDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error>
    func fetchMoodOfWeek() -> AnyPublisher<[ShortDiaryEntity], Error>
    func chat(moodDetail: [String]) -> AnyPublisher<String, Error>
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

    func fetchDiaryDetail(date: Date) -> AnyPublisher<DiaryDetailEntity, Error> {
        request(.fetchDiaryDetail(date: date), dto: FetchDiaryDetailResponseDTO.self)
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
            .map { $0.toDomain().reversed() }
            .eraseToAnyPublisher()
    }

    func chat(moodDetail: [String]) -> AnyPublisher<String, Error> {
        request(.chat(moodDetail), dto: ChatResponseDTO.self)
            .map { $0.message }
            .eraseToAnyPublisher()
    }
}
