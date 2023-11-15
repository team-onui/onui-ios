import Combine

protocol RemoteUserDataSource {
    func rename(name: String) -> AnyPublisher<ProfileEntity, Error>
    func fetchProfile() -> AnyPublisher<ProfileEntity, Error>
    func changeTheme(theme: String) -> AnyPublisher<ProfileEntity, Error>
    func changeFiltering(isFiltering: Bool) -> AnyPublisher<ProfileEntity, Error>
}

final class RemoteUserDataSourceImpl: BaseRemoteDataSource<UserAPI>, RemoteUserDataSource {
    func rename(name: String) -> AnyPublisher<ProfileEntity, Error> {
        request(.rename(.init(name: name)), dto: ProfileResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchProfile() -> AnyPublisher<ProfileEntity, Error> {
        request(.fetchProfile, dto: ProfileResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func changeTheme(theme: String) -> AnyPublisher<ProfileEntity, Error> {
        request(.changeTheme(theme), dto: ProfileResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func changeFiltering(isFiltering: Bool) -> AnyPublisher<ProfileEntity, Error> {
        request(.changeFiltering(isFiltering), dto: ProfileResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
