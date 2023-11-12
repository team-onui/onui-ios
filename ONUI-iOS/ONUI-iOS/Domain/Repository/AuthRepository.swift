import Combine

protocol AuthRepository {
    func googleSignin(token: String) -> AnyPublisher<Void, Error>
    func appleSignin(token: String) -> AnyPublisher<Void, Error>
    func refreshToken(token: String) -> AnyPublisher<Void, Error>
    func logout()
}

