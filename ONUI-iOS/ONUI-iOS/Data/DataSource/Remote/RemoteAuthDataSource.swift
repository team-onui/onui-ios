import Combine

protocol RemoteAuthDataSource {
    func googleSignin(token: String) -> AnyPublisher<Void, Error>
    func appleSignin(token: String) -> AnyPublisher<Void, Error>
    func refreshToken() -> AnyPublisher<Void, Error>
    func withdraw() -> AnyPublisher<Void, Error>
}

final class RemoteAuthDataSourceImpl: BaseRemoteDataSource<AuthAPI>, RemoteAuthDataSource {
    func googleSignin(token: String) -> AnyPublisher<Void, Error> {
        request(.googleSignin(token: token))
    }

    func appleSignin(token: String) -> AnyPublisher<Void, Error> {
        request(.appleSignin(token: token))
    }
    
    func refreshToken() -> AnyPublisher<Void, Error> {
        let refreshToken = keychain.load(type: .refreshToken)
        return request(.refreshToken(token: refreshToken))
    }

    func withdraw() -> AnyPublisher<Void, Error> {
        request(.withdraw)
    }
}
