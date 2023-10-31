import Foundation

struct RefreshTokenRequestQuery: Encodable {
    let refreshToken: String

    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
