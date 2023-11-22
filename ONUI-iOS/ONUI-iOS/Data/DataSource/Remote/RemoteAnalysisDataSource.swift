import Combine

protocol RemoteAnalysisDataSource {
    func fetchMonthlyAnalysis() -> AnyPublisher<MonthlyAnalysisEntity, Error>
    func fetchMoodAnalysis() -> AnyPublisher<MoodAnalysisEntity, Error>
}

final class RemoteAnalysisDataSourceImpl: BaseRemoteDataSource<AnalysisAPI>, RemoteAnalysisDataSource {
    func fetchMonthlyAnalysis() -> AnyPublisher<MonthlyAnalysisEntity, Error> {
        request(.fetchMonthlyAnalysis, dto: FetchMonthlyAnalysisResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchMoodAnalysis() -> AnyPublisher<MoodAnalysisEntity, Error> {
        request(.fetchMoodAnalysis, dto: FetchMoodAnalysisResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
