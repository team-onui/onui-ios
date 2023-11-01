import Moya

enum TimelineAPI {
    case postTimeline(id: String)
    case fetchTimelines(index: Int, size: Int, dayOfWeek: DayOfWeekType)
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

        case let .fetchTimelines(index, size, dayOfWeek):
            return .requestParameters(parameters: [
                "idx": index,
                "size": size,
                "day_of_week": dayOfWeek
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
