import Moya

enum ShopAPI {
    case buyTheme(String)
    case fetchThemeList
}

extension ShopAPI: OnuiAPI {
    public typealias ErrorType = ShopError

    public var domain: JobisDomain {
        .shop
    }

    public var urlPath: String {
        switch self {
        case .buyTheme:
            return "/buy"
        case .fetchThemeList:
            return "/all"
        }
    }

    public var method: Method {
        switch self {
        case .buyTheme:
            return .post
        case .fetchThemeList:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case let .buyTheme(id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        case .fetchThemeList:
            return .requestPlain
        }
    }

    public var jwtTokenType: JwtTokenType {
        .accessToken
    }

    public var errorMap: [Int: ErrorType] {
        return [:]
    }
}
