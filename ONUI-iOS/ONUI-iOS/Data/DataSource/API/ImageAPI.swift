import Foundation
import Moya

enum ImageAPI {
    case uploadImage(data: Data, fileName: String)
}

extension ImageAPI: OnuiAPI {
    public typealias ErrorType = ImageError

    public var domain: JobisDomain {
        .image
    }

    public var urlPath: String {
        return ""
    }

    public var method: Moya.Method {
        return .post
    }

    public var task: Moya.Task {
        switch self {
        case let .uploadImage(data, fileName):
            let multipartData = MultipartFormData(
                provider: .data(data),
                name: "file",
                fileName: fileName
            )

            return .uploadMultipart([multipartData])
        }
    }

    public var jwtTokenType: JwtTokenType {
        .accessToken
    }

    public var errorMap: [Int: ErrorType] {
        return [:]
    }
}
