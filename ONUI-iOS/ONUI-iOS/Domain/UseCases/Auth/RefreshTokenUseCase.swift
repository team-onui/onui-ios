import Combine

struct RefreshTokenUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute() -> AnyPublisher<Void, Error> {
        authRepository.refreshToken()
    }
}
