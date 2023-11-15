import Moya
import Foundation

enum DiaryAPI {
    case writeDiary(WriteDiaryRequestQuery)
    case fetchMoodOfMonth(year: Int, month: Int)
    case fetchDiaryDetail(date: Date)
    case putDiary(PutDiaryRequestQuery)
    case fetchMoodOfWeek
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

        case .fetchMoodOfWeek:
            return "/ago"
        }
    }

    var method: Moya.Method {
        switch self {
        case .writeDiary:
            return .post

        case .fetchMoodOfMonth, .fetchDiaryDetail, .fetchMoodOfWeek:
            return .get

        case .putDiary:
            return .put
        }
    }

    var task: Moya.Task {
        switch self {
        case let .writeDiary(req):
            return .requestJSONEncodable(req)

        case let .fetchMoodOfMonth(year, month):
            return .requestParameters(parameters: [
                "year": year,
                "month": month
            ], encoding: URLEncoding.queryString)

        case let .fetchDiaryDetail(date):
            return .requestParameters(parameters: [
                "date": date.toString()
            ], encoding: URLEncoding.queryString)

        case let .putDiary(req):
            return .requestJSONEncodable(req)

        case .fetchMoodOfWeek:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        return .accessToken
    }

    var errorMap: [Int: ErrorType] {
        return [:]
    }
}
