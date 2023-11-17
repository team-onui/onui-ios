import Combine

struct FetchMyThemeUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute() -> AnyPublisher<[Theme], Error> {
        userRepository.fetchMyTheme()
    }
}
