import Moya

enum UserAPI {
    case rename(RenameRequestQuery)
    case fetchProfile
    case changeTheme(String)
    case changeFiltering(Bool)
    case changeUserColor(String)
    case fetchMyTheme
    case fetchMyRice
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
        case .fetchProfile, .changeUserColor:
            return "/profile"
        case .changeTheme:
            return "/theme"
        case .changeFiltering:
            return "/filter"
        case .fetchMyTheme:
            return "/bought/theme"
        case .fetchMyRice:
            return "/rice"
        }
    }

    var method: Method {
        switch self {
        case .fetchProfile, .fetchMyRice, .fetchMyTheme:
            return .get
        case .rename, .changeTheme, .changeFiltering, .changeUserColor:
            return .patch
        }
    }

    var task: Task {
        switch self {
        case let .rename(req):
            return .requestJSONEncodable(req)
        case .fetchProfile, .fetchMyRice, .fetchMyTheme:
            return .requestPlain
        case let .changeTheme(theme):
            return .requestParameters(parameters: [
                "theme": theme
            ], encoding: JSONEncoding.default)
        case let .changeFiltering(isFiltering):
            return .requestParameters(parameters: [
                "on_filtering": isFiltering
            ], encoding: JSONEncoding.default)
        case let .changeUserColor(hex):
            return .requestParameters(parameters: [
                "profile_theme": hex
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
