import Combine

struct FetchProfileUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute() -> AnyPublisher<ProfileEntity, Error> {
        userRepository.fetchProfile()
    }
}
