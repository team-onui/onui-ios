import Combine

protocol RemoteAuthDataSource {
    func fetchGoogleSigninUrl() -> AnyPublisher<GoogleSigninUrlEntity, Error>
    func googleSignin(token: String) -> AnyPublisher<Void, Error>
    func refreshToken(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error>
}

final class RemoteAuthDataSourceImpl: BaseRemoteDataSource<AuthAPI>, RemoteAuthDataSource {
    func fetchGoogleSigninUrl() -> AnyPublisher<GoogleSigninUrlEntity, Error> {
        request(.fetchGoogleSigninUrl, dto: FetchGoogleSigninUrlResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func googleSignin(token: String) -> AnyPublisher<Void, Error> {
        request(.googleSignin(token: token))
    }
    
    func refreshToken(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error> {
        request(.refreshToken(req))
    }
}
