import Combine

struct RenameUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func execute(req: RenameRequestQuery) -> AnyPublisher<String, Error> {
        userRepository.rename(req: req)
    }
}
