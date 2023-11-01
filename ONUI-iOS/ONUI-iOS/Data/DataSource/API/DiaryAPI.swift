import Moya

enum DiaryAPI {
    case writeDiary(WriteDiaryRequestQuery)
    case fetchMoodOfMonth(year: Int, month: Int)
    case fetchDiaryDetail(id: String)
    case putDiary(PutDiaryRequestQuery)
}

extension DiaryAPI: OnuiAPI {
    typealias ErrorType = DiaryError

    var domain: JobisDomain {
        .diary
    }

    var urlPath: String {
        switch self {
        case .writeDiary, .fetchMoodOfMonth, .putDiary:
            return ""

        case .fetchDiaryDetail:
            return "/detail"
        }
    }

    var method: Method {
        switch self {
        case .writeDiary:
            return .post

        case .fetchMoodOfMonth, .fetchDiaryDetail:
            return .post

        case .putDiary:
            return .put
        }
    }

    var task: Task {
        switch self {
        case let .writeDiary(req):
            return .requestJSONEncodable(req)

        case let .fetchMoodOfMonth(year, month):
            return .requestParameters(parameters: [
                "year": year,
                "month": month
            ], encoding: URLEncoding.queryString)

        case let .fetchDiaryDetail(id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)

        case let .putDiary(req):
            return .requestJSONEncodable(req)
        }
    }

    var jwtTokenType: JwtTokenType {
        return .accessToken
    }

    var errorMap: [Int: ErrorType] {
        return [:]
    }
}
