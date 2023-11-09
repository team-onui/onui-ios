import Combine

protocol AuthRepository {
    func fetchGoogleSigninUrl() -> AnyPublisher<GoogleSigninUrlEntity, Error>
    func googleSignin(token: String) -> AnyPublisher<Void, Error>
    func refreshToken(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error>
    func logout()
}

