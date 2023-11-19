import Moya

enum MissionAPI {
    case completeMission(String)
    case fetchMissionList
}

extension MissionAPI: OnuiAPI {
    typealias ErrorType = MissionError

    var domain: JobisDomain {
        .mission
    }

    var urlPath: String {
        return ""
    }

    var method: Method {
        switch self {
        case .completeMission:
            return .post

        case .fetchMissionList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .completeMission(id):
            return .requestParameters(parameters: [
                "mission_id": id
            ], encoding: JSONEncoding.default)

        case .fetchMissionList:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        .accessToken
    }

    var errorMap: [Int: ErrorType] {
        return [:]
    }
}
