import Combine

protocol UserRepository {
    func rename(req: RenameRequestQuery) -> AnyPublisher<String, Error>
}
