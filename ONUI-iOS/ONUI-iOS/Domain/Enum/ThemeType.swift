import Foundation
import SwiftUI

enum ThemeType: String, Codable {
    case standard = "default"
    case hong = "홍조쓰"
    case ssac = "새싹쓰"
    case nya = "애옹쓰"
}

extension ThemeType {
    func toDomain() -> Theme {
        switch self {
        case .standard:
            return .standard
        case .hong:
            return .hong
        case .ssac:
            return .ssac
        case .nya:
            return .nya
        }
    }
}
