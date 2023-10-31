import Combine

protocol RemoteUserDataSource {
    func rename(req: RenameRequestQuery) -> AnyPublisher<String, Error>
}

final class RemoteUserDataSourceImpl: BaseRemoteDataSource<UserAPI>, RemoteUserDataSource {
    func rename(req: RenameRequestQuery) -> AnyPublisher<String, Error> {
        request(.rename(req), dto: RenameResponseDTO.self)
            .map { $0.name }
            .eraseToAnyPublisher()
    }
}
