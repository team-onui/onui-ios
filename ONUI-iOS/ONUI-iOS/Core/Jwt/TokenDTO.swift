import Foundation

public struct TokenDTO: Equatable, Decodable {
    let accessToken: String
    let refreshToken: String
    let accessExpiredAt: String
    let refreshExpiredAt: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case accessExpiredAt = "access_expired_at"
        case refreshExpiredAt = "refresh_expired_at"
    }
}
