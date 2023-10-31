import Moya

enum AuthAPI {
    case fetchGoogleSigninUrl
    case googleSignin(code: String)
    case refreshToken(RefreshTokenRequestQuery)
}

extension AuthAPI: OnuiAPI {
    typealias ErrorType = AuthError

    var domain: JobisDomain {
        .auth
    }

    var urlPath: String {
        switch self {
        case .fetchGoogleSigninUrl:
            return "/google/link"

        case .googleSignin:
            return "/oauth/google/token"

        case .refreshToken:
            return "/token"
        }
    }

    var method: Method {
        switch self {
        case .fetchGoogleSigninUrl, .googleSignin:
            return .get

        case .refreshToken:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .fetchGoogleSigninUrl:
            return .requestPlain

        case let .googleSignin(code):
            return .requestParameters(parameters: [
                "code": code
            ], encoding: URLEncoding.queryString)

        case let .refreshToken(req):
            return .requestJSONEncodable(req)
        }
    }

    var jwtTokenType: JwtTokenType {
        return .none
    }

    var errorMap: [Int: ErrorType] {
        return [:]
    }
}
