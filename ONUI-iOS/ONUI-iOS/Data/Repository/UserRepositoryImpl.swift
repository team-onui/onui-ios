import Combine

struct UserRepositoryImpl: UserRepository {
    private let remoteUserDataSource: any RemoteUserDataSource

    init(remoteUserDataSource: any RemoteUserDataSource) {
        self.remoteUserDataSource = remoteUserDataSource
    }

    func rename(name: String) -> AnyPublisher<ProfileEntity, Error> {
        remoteUserDataSource.rename(name: name)
    }
    
    func fetchProfile() -> AnyPublisher<ProfileEntity, Error> {
        remoteUserDataSource.fetchProfile()
    }
    
    func changeTheme(theme: String) -> AnyPublisher<ProfileEntity, Error> {
        remoteUserDataSource.changeTheme(theme: theme)
    }
    
    func changeFiltering(isFiltering: Bool) -> AnyPublisher<ProfileEntity, Error> {
        remoteUserDataSource.changeFiltering(isFiltering: isFiltering)
    }
}
