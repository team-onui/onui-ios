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
    
    func changeUserColor(hex: String) -> AnyPublisher<ProfileEntity, Error> {
        remoteUserDataSource.changeUserColor(hex: hex)
    }

    func fetchMyRice() -> AnyPublisher<Int, Error> {
        remoteUserDataSource.fetchMyRice()
    }

    func fetchMyTheme() -> AnyPublisher<[Theme], Error> {
        remoteUserDataSource.fetchMyTheme()
    }
}
