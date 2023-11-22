import Combine

protocol AnalysisRepository {
    func fetchMonthlyAnalysis() -> AnyPublisher<MonthlyAnalysisEntity, Error>
    func fetchMoodAnalysis() -> AnyPublisher<MoodAnalysisEntity, Error>
}
