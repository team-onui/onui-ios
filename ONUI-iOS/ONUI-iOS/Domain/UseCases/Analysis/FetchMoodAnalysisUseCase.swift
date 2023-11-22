import Combine

struct FetchMoodAnalysisUseCase {
    private let analysisRepository: AnalysisRepository

    init(analysisRepository: AnalysisRepository) {
        self.analysisRepository = analysisRepository
    }

    func execute() -> AnyPublisher<MoodAnalysisEntity, Error> {
        analysisRepository.fetchMoodAnalysis()
    }
}
