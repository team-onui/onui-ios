import Moya

enum AnalysisAPI {
    case fetchMonthlyAnalysis
    case fetchMoodAnalysis
}

extension AnalysisAPI: OnuiAPI {
    public typealias ErrorType = AnalysisError

    public var domain: JobisDomain {
        .analysis
    }

    public var urlPath: String {
        switch self {
        case .fetchMonthlyAnalysis:
            return "/monthly"
        case .fetchMoodAnalysis:
            return "/mood"
        }
    }

    public var method: Method {
        .get
    }

    public var task: Task {
        .requestPlain
    }

    public var jwtTokenType: JwtTokenType {
        .accessToken
    }

    public var errorMap: [Int: ErrorType] {
        return [:]
    }
}
