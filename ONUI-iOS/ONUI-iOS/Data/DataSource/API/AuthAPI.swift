import Moya

enum AuthAPI {
    case googleSignin(token: String)
    case appleSignin(token: String)
    case refreshToken(token: String)
}

extension AuthAPI: OnuiAPI {
    typealias ErrorType = AuthError

    var domain: JobisDomain {
        .auth
    }

    var urlPath: String {
        switch self {
        case .googleSignin:
            return "/google"

        case .appleSignin:
            return "/apple"

        case .refreshToken:
            return "/re-issue"
        }
    }

    var method: Method {
        switch self {
        case .googleSignin, .appleSignin:
            return .post

        case .refreshToken:
            return .put
        }
    }

    var task: Task {
        switch self {
        case let .googleSignin(token):
            return .requestParameters(parameters: [
                "token": token
            ], encoding: URLEncoding.queryString)

        case let .appleSignin(token):
            return .requestParameters(parameters: [
                "token": token
            ], encoding: URLEncoding.queryString)

        case let .refreshToken(token):
            return .requestParameters(parameters: [
                    "token": token
                ], encoding: URLEncoding.queryString)
        }
    }

    var jwtTokenType: JwtTokenType {
        return .none
    }

    var errorMap: [Int: ErrorType] {
        return [:]
    }
}
