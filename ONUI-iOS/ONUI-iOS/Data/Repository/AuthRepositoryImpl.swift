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

    func fetchGoogleSigninUrl() -> AnyPublisher<GoogleSigninUrlEntity, Error> {
        remoteAuthDataSource.fetchGoogleSigninUrl()
    }

    func googleSignin(code: String) -> AnyPublisher<Void, Error> {
        remoteAuthDataSource.googleSignin(code: code)
    }

    func refreshToken(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error> {
        remoteAuthDataSource.refreshToken(req: req)
    }

    func logout() {
        localAuthDataSource.clearTokens()
    }
}
