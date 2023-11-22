import Combine

struct FetchMonthlyAnalysisUseCase {
    private let analysisRepository: AnalysisRepository

    init(analysisRepository: AnalysisRepository) {
        self.analysisRepository = analysisRepository
    }

    func execute() -> AnyPublisher<MonthlyAnalysisEntity, Error> {
        analysisRepository.fetchMonthlyAnalysis()
    }
}
