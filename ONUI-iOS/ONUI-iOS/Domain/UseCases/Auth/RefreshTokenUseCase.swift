import Combine

struct RefreshTokenUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute(token: String) -> AnyPublisher<Void, Error> {
        authRepository.refreshToken(token: token)
    }
}
