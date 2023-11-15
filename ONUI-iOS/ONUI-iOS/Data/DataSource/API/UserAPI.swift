import Moya

enum UserAPI {
    case rename(RenameRequestQuery)
    case fetchProfile
    case changeTheme(String)
    case changeFiltering(Bool)
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
        case .fetchProfile:
            return "/profile"
        case .changeTheme:
            return "/theme"
        case .changeFiltering:
            return "/filter"
        }
    }

    var method: Method {
        switch self {
        case .fetchProfile:
            return .get
        case .rename, .changeTheme, .changeFiltering:
            return .patch
        }
    }

    var task: Task {
        switch self {
        case let .rename(req):
            return .requestJSONEncodable(req)
        case .fetchProfile:
            return .requestPlain
        case let .changeTheme(theme):
            return .requestParameters(parameters: [
                "theme": theme
            ], encoding: JSONEncoding.default)
        case let .changeFiltering(isFiltering):
            return .requestParameters(parameters: [
                "on_filtering": isFiltering
            ], encoding: JSONEncoding.default)
        }
    }

    var jwtTokenType: JwtTokenType {
        return .accessToken
    }

    var errorMap: [Int: ErrorType] {
        return [:]
    }
}
