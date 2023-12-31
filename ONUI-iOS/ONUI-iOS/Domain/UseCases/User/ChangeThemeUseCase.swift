import Combine

struct ChangeThemeUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute(theme: ThemeType) -> AnyPublisher<ProfileEntity, Error> {
        userRepository.changeTheme(theme: theme.rawValue)
    }
}
