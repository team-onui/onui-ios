import Combine

struct RenameUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute(name: String) -> AnyPublisher<ProfileEntity, Error> {
        userRepository.rename(name: name)
    }
}
