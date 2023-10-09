import SwiftUI

public extension Color {
    struct GrayScale { }
}

public extension Color.GrayScale {
    private static let gray0 = Color(type: .gray0)
    private static let gray3 = Color(type: .gray3)
    private static let gray5 = Color(type: .gray5)
    private static let gray7 = Color(type: .gray7)
    private static let gray10 = Color(type: .gray10)
}

public extension Color.GrayScale {
    struct Background { }
    struct Surface { }
    struct Outline { }
}

public extension Color.GrayScale.Background {
    static let background: Color = .GrayScale.gray3.darkModeColor(.GrayScale.gray10)
    static let onBackground: Color = .GrayScale.gray10.darkModeColor(.GrayScale.gray0)
    static let backgroundVariant: Color = .GrayScale.gray7.darkModeColor(.GrayScale.gray3)
    static let onBackgroundVariant: Color = .GrayScale.gray5
}

public extension Color.GrayScale.Surface {
    static let surface: Color = .GrayScale.gray0.darkModeColor(.GrayScale.gray7)
    static let onSurface: Color = .GrayScale.gray10.darkModeColor(.GrayScale.gray0)
    static let surfaceVariant: Color = .GrayScale.gray7.darkModeColor(.GrayScale.gray3)
    static let onSurfaceVariant: Color = .GrayScale.gray5
}

public extension Color.GrayScale.Outline {
    static let outline: Color = .GrayScale.gray5
    static let outlineVariant: Color = .GrayScale.gray3.darkModeColor(.GrayScale.gray7)
}
