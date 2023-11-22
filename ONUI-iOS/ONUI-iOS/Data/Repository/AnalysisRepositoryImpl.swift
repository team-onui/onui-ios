import Combine

struct AnalysisRepositoryImpl: AnalysisRepository {
    private let remoteAnalysisDataSource: RemoteAnalysisDataSource

    init(remoteAnalysisDataSource: RemoteAnalysisDataSource) {
        self.remoteAnalysisDataSource = remoteAnalysisDataSource
    }

    func fetchMonthlyAnalysis() -> AnyPublisher<MonthlyAnalysisEntity, Error> {
        remoteAnalysisDataSource.fetchMonthlyAnalysis()
    }
    func fetchMoodAnalysis() -> AnyPublisher<MoodAnalysisEntity, Error> {
        remoteAnalysisDataSource.fetchMoodAnalysis()
    }
}
