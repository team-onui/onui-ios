import Combine

protocol UserRepository {
    func rename(name: String) -> AnyPublisher<ProfileEntity, Error>
    func fetchProfile() -> AnyPublisher<ProfileEntity, Error>
    func changeTheme(theme: String) -> AnyPublisher<ProfileEntity, Error>
    func changeFiltering(isFiltering: Bool) -> AnyPublisher<ProfileEntity, Error>
    func changeUserColor(hex: String) -> AnyPublisher<ProfileEntity, Error>
}
