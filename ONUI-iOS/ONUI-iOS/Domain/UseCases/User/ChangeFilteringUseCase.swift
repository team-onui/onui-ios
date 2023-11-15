import Combine

struct ChangeFilteringUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute(isFiltering: Bool) -> AnyPublisher<ProfileEntity, Error> {
        userRepository.changeFiltering(isFiltering: isFiltering)
    }
}
