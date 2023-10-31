import Combine

protocol RemoteAuthDataSource {
    func fetchGoogleSigninUrl() -> AnyPublisher<GoogleSigninUrlEntity, Error>
    func googleSignin(code: String) -> AnyPublisher<Void, Error>
    func refreshToken(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error>
}

final class RemoteAuthDataSourceImpl: BaseRemoteDataSource<AuthAPI>, RemoteAuthDataSource {
    func fetchGoogleSigninUrl() -> AnyPublisher<GoogleSigninUrlEntity, Error> {
        request(.fetchGoogleSigninUrl, dto: FetchGoogleSigninUrlResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func googleSignin(code: String) -> AnyPublisher<Void, Error> {
        request(.googleSignin(code: code))
    }
    
    func refreshToken(req: RefreshTokenRequestQuery) -> AnyPublisher<Void, Error> {
        request(.refreshToken(req))
    }
}
