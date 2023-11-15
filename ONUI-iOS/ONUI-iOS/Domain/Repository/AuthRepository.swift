import Combine

protocol AuthRepository {
    func googleSignin(token: String) -> AnyPublisher<Void, Error>
    func appleSignin(token: String) -> AnyPublisher<Void, Error>
    func refreshToken() -> AnyPublisher<Void, Error>
    func withdraw() -> AnyPublisher<Void, Error>
    func logout()
}

