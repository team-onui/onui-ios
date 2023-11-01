import Foundation
import Moya 

protocol OnuiAPI: TargetType, JwtAuthorizable {
    associatedtype ErrorType: Error
    var domain: JobisDomain { get }
    var urlPath: String { get }
    var errorMap: [Int: ErrorType] { get }
}

extension OnuiAPI {
    var baseURL: URL {
        URL(
            string: Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        ) ?? URL(string: "https://www.google.com")!
    }

    var path: String {
        domain.asURLString + urlPath
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

enum JobisDomain: String {
    case auth
    case user
    case image = "img"
    case diary
    case timeline = "tl"
}

extension JobisDomain {
    var asURLString: String {
        "/\(self.rawValue)"
    }
}
