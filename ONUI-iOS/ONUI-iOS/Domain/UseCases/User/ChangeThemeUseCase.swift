import Combine

struct ChangeThemeUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute(theme: String) -> AnyPublisher<ProfileEntity, Error> {
        userRepository.changeTheme(theme: theme)
    }
}
