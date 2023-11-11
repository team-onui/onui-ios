import Combine

final class AuthRepositoryImpl: AuthRepository {
    private let remoteAuthDataSource: any RemoteAuthDataSource
    private let localAuthDataSource: any LocalAuthDataSource

    init(
        remoteAuthDataSource: any RemoteAuthDataSource,
        localAuthDataSource: any LocalAuthDataSource
    ) {
        self.remoteAuthDataSource = remoteAuthDataSource
        self.localAuthDataSource = localAuthDataSource
    }
    func googleSignin(token: String) -> AnyPublisher<Void, Error> {
        remoteAuthDataSource.googleSignin(token: token)
    }

    func appleSignin(token: String) -> AnyPublisher<Void, Error> {
        remoteAuthDataSource.appleSignin(token: token)
    }

    func refreshToken(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error> {
        remoteAuthDataSource.refreshToken(req: req)
    }

    func logout() {
        localAuthDataSource.clearTokens()
    }
}
