import Combine

struct GoogleSigninUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute(token: String) -> AnyPublisher<Void, Error> {
        authRepository.googleSignin(token: token)
    }
}
