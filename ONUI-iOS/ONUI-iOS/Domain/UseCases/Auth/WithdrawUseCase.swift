import Combine

struct WithdrawUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute() -> AnyPublisher<Void, Error> {
        authRepository.withdraw()
    }
}
