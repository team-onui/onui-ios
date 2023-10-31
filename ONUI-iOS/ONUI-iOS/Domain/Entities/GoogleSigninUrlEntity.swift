import Foundation

struct GoogleSigninUrlEntity: Equatable {
    var loginLink: String

    init(loginLink: String) {
        self.loginLink = loginLink
    }
}
