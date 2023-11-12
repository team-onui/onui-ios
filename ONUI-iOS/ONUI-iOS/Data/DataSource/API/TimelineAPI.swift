import Moya

enum TimelineAPI {
    case postTimeline(id: String)
    case fetchTimelines(index: Int, size: Int, date: String)
}

extension TimelineAPI: OnuiAPI {
    public typealias ErrorType = TimelineError

    public var domain: JobisDomain {
        .timeline
    }

    public var urlPath: String {
        return ""
    }

    public var method: Method {
        switch self {
        case .postTimeline:
            return .post

        case .fetchTimelines:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case let .postTimeline(id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)

        case let .fetchTimelines(index, size, date):
            return .requestParameters(parameters: [
                "idx": index,
                "size": size,
                "date": date
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
