import SwiftUI

protocol OnuiFontable {
    var size: FontSize { get }
}

public struct FontSize {
    var size: CGFloat
    var lineSpacing: CGFloat

    init(size: CGFloat, lineSpacing: CGFloat) {
        self.size = size
        self.lineSpacing = lineSpacing - size
    }
}

public enum OnuiFontWeight: String, CaseIterable {
    case bold = "Bold"
    case medium = "Medium"
    case regular = "Regular"
}

public enum OnuiFontStyle: Hashable, OnuiFontable {
    case headline(OnuiFontStyle.SizeStyle)
    case title(OnuiFontStyle.SizeStyle)
    case body(OnuiFontStyle.SizeStyle)
    case label

    public enum SizeStyle {
        case large
        case medium
        case small
    }
}

extension OnuiFontStyle {
    var size: FontSize {
        switch self {
        case let .headline(sizeStyle):
            switch sizeStyle {
            case .large:
                return .init(size: 36, lineSpacing: 50)

            case .medium:
                return .init(size: 30, lineSpacing: 42)

            case .small:
                return .init(size: 24, lineSpacing: 34)
            }

        case let .title(sizeStyle):
            switch sizeStyle {
            case .large:
                return .init(size: 22, lineSpacing: 34)

            case .medium:
                return .init(size: 20, lineSpacing: 32)

            case .small:
                return .init(size: 18, lineSpacing: 28)
            }

        case let .body(sizeStyle):
            switch sizeStyle {
            case .large:
                return .init(size:18, lineSpacing: 28)

            case .medium:
                return .init(size: 26, lineSpacing: 26)

            case .small:
                return .init(size: 14, lineSpacing: 22)
            }

        case .label:
            return .init(size: 12, lineSpacing: 22)
        }
    }
}
