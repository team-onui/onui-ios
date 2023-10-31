import Foundation

struct FetchGoogleSigninUrlResponseDTO: Decodable {
    var loginLink: String

    init(loginLink: String) {
        self.loginLink = loginLink
    }

    enum CodingKeys: String, CodingKey {
        case loginLink = "login_link"
    }
}

extension FetchGoogleSigninUrlResponseDTO {
    func toDomain() -> GoogleSigninUrlEntity {
        GoogleSigninUrlEntity(loginLink: loginLink)
    }
}
