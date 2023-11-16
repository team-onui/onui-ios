import Combine

struct ChangeUserColorUseCase{
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute(hex: String) -> AnyPublisher<ProfileEntity, Error> {
        userRepository.changeUserColor(hex: hex)
    }
}
