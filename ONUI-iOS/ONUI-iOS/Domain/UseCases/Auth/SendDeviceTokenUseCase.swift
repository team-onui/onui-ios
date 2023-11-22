import Combine

struct SendDeviceTokenUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute(token: String) -> AnyPublisher<Void, Error> {
        authRepository.sendDeviceToken(token: token)
    }
}
