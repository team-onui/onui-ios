import Combine

struct FetchGoogleSigninUrlUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute() -> AnyPublisher<GoogleSigninUrlEntity, Error> {
        authRepository.fetchGoogleSigninUrl()
    }
}
