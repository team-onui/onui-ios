import Combine

struct GoogleSigninUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute(code: String) -> AnyPublisher<Void, Error> {
        authRepository.googleSignin(code: code)
    }
}
