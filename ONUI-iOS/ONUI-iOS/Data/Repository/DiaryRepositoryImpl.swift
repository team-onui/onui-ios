import Foundation
import Combine

struct DiaryRepositoryImpl: DiaryRepository {
    private let remoteDiaryDataSource: any RemoteDiaryDataSource

    init(remoteDiaryDataSource: any RemoteDiaryDataSource) {
        self.remoteDiaryDataSource = remoteDiaryDataSource
    }

    func writeDiary(req: WriteDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error> {
        remoteDiaryDataSource.writeDiary(req: req)
    }
    
    func fetchMoodOfMonth(year: Int, month: Int) -> AnyPublisher<[ShortDiaryEntity], Error> {
        remoteDiaryDataSource.fetchMoodOfMonth(year: year, month: month)
    }
    
    func fetchDiaryDetail(id: String) -> AnyPublisher<DiaryDetailEntity, Error> {
        remoteDiaryDataSource.fetchDiaryDetail(id: id)
    }
    
    func putDiary(req: PutDiaryRequestQuery) -> AnyPublisher<DiaryEntity, Error> {
        remoteDiaryDataSource.putDiary(req: req)
    }

    func fetchMoodOfWeek() -> AnyPublisher<[ShortDiaryEntity], Error> {
        remoteDiaryDataSource.fetchMoodOfWeek()
    }
}
