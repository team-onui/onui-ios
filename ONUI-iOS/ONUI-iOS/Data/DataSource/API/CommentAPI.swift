import Moya

enum CommentAPI {
    case postComment(id: String, comment: String)
    case fetchComment(id: String)
}

extension CommentAPI: OnuiAPI {
    public typealias ErrorType = CommentError

    public var domain: JobisDomain {
        .comment
    }

    public var urlPath: String {
        return ""
    }

    public var method: Method {
        switch self {
        case .postComment:
            return .post

        case .fetchComment:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case let .postComment(id, comment):
            return .requestCompositeParameters(
                bodyParameters: ["comment": comment],
                bodyEncoding: JSONEncoding.default,
                urlParameters: ["timeline_id": id]
            )

        case let .fetchComment(id):
            return .requestParameters(parameters: [
                "timeline_id": id
            ], encoding: URLEncoding.queryString)
        }
    }

    public var jwtTokenType: JwtTokenType {
        .accessToken
    }

    public var errorMap: [Int: ErrorType] {
        return [:]
    }
}
