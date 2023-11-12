import Combine

protocol RemoteAuthDataSource {
    func googleSignin(token: String) -> AnyPublisher<Void, Error>
    func appleSignin(token: String) -> AnyPublisher<Void, Error>
    func refreshToken(token: String) -> AnyPublisher<Void, Error>
}

final class RemoteAuthDataSourceImpl: BaseRemoteDataSource<AuthAPI>, RemoteAuthDataSource {
    func googleSignin(token: String) -> AnyPublisher<Void, Error> {
        request(.googleSignin(token: token))
    }

    func appleSignin(token: String) -> AnyPublisher<Void, Error> {
        request(.appleSignin(token: token))
    }
    
    func refreshToken(token: String) -> AnyPublisher<Void, Error> {
        request(.refreshToken(token: token))
    }
}
