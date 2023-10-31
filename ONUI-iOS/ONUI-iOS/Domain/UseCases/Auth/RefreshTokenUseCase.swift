import Combine

struct RefreshTokenUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error> {
        authRepository.refreshToken(req: req)
    }
}
