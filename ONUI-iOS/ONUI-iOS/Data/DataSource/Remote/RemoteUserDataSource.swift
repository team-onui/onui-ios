import Combine

protocol RemoteUserDataSource {
    func rename(name: String) -> AnyPublisher<ProfileEntity, Error>
    func fetchProfile() -> AnyPublisher<ProfileEntity, Error>
    func changeTheme(theme: String) -> AnyPublisher<ProfileEntity, Error>
    func changeFiltering(isFiltering: Bool) -> AnyPublisher<ProfileEntity, Error>
    func changeUserColor(hex: String) -> AnyPublisher<ProfileEntity, Error>
    func fetchMyTheme() -> AnyPublisher<[Theme], Error>
    func fetchMyRice() -> AnyPublisher<Int, Error>
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

    func changeUserColor(hex: String) -> AnyPublisher<ProfileEntity, Error> {
        request(.changeUserColor(hex), dto: ProfileResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchMyTheme() -> AnyPublisher<[Theme], Error> {
        request(.fetchMyTheme, dto: FetchMyThemeResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }

    func fetchMyRice() -> AnyPublisher<Int, Error> {
        request(.fetchMyRice, dto: FetchMyRiceResponseDTO.self)
            .map { $0.rice }
            .eraseToAnyPublisher()
    }
}
