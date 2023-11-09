import Foundation

public struct TokenDTO: Equatable, Decodable {
    let accessToken: String
    let accessExpiredAt: String
    let refreshToken: String
    let refreshExpiredAt: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessExpiredAt = "access_expired_at"
        case refreshToken = "refresh_token"
        case refreshExpiredAt = "refresh_expired_at"
    }
}
