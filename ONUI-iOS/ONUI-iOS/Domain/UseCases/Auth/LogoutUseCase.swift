import Combine

struct LogoutUseCase {
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    private let authRepository: AuthRepository

    func execute() {
        authRepository.logout()
    }
}
