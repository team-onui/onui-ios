import SwiftUI

protocol OnuiFontable {
    var size: FontSize { get }
    var weight: OnuiFontWeight { get }
}

public struct FontSize {
    var size: CGFloat
    var lineHeight: CGFloat

    init(size: CGFloat, lineHeight: CGFloat) {
        self.size = size
        self.lineHeight = lineHeight
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
                return .init(size: 36, lineHeight: 50)

            case .medium:
                return .init(size: 30, lineHeight: 42)

            case .small:
                return .init(size: 24, lineHeight: 34)
            }

        case let .title(sizeStyle):
            switch sizeStyle {
            case .large:
                return .init(size: 22, lineHeight: 34)

            case .medium:
                return .init(size: 20, lineHeight: 32)

            case .small:
                return .init(size: 18, lineHeight: 28)
            }

        case let .body(sizeStyle):
            switch sizeStyle {
            case .large:
                return .init(size:18, lineHeight: 28)

            case .medium:
                return .init(size: 16, lineHeight: 26)

            case .small:
                return .init(size: 14, lineHeight: 22)
            }

        case .label:
            return .init(size: 12, lineHeight: 22)
        }
    }

    var weight: OnuiFontWeight {
        switch self {
        case .headline:
            return .medium

        case .title:
            return .bold

        case .body, .label:
            return .regular
        }
    }
}
