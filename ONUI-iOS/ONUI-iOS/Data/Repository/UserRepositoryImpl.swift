import Combine

struct UserRepositoryImpl: UserRepository {
    private let remoteUserDataSource: any RemoteUserDataSource

    init(remoteUserDataSource: any RemoteUserDataSource) {
        self.remoteUserDataSource = remoteUserDataSource
    }

    func rename(req: RenameRequestQuery) -> AnyPublisher<String, Error> {
        remoteUserDataSource.rename(req: req)
    }
}
