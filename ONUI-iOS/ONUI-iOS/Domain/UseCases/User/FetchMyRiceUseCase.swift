import Combine

struct FetchMyRiceUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute() -> AnyPublisher<Int, Error> {
        userRepository.fetchMyRice()
    }
}
