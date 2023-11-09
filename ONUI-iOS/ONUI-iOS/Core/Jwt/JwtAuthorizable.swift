import Moya

public enum JwtTokenType: String {
    case accessToken = "Authorization"
    case none
}

public protocol JwtAuthorizable {
    var jwtTokenType: JwtTokenType { get }
}
