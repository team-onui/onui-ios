import Combine

struct AppleSigninUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute(token: String) -> AnyPublisher<Void, Error> {
        authRepository.appleSignin(token: token)
    }
}
