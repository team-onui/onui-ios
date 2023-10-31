import Moya

enum UserAPI {
    case rename(RenameRequestQuery)
}

extension UserAPI: OnuiAPI {
    typealias ErrorType = UserError

    var domain: JobisDomain {
        .user
    }

    var urlPath: String {
        switch self {
        case .rename:
            return "/rename"
        }
    }

    var method: Method {
        switch self {
        case .rename:
            return .patch
        }
    }

    var task: Task {
        switch self {
        case let .rename(req):
            return .requestJSONEncodable(req)
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        case .rename:
            return .accessToken
        }
    }

    var errorMap: [Int: ErrorType] {
        return [:]
    }
}
