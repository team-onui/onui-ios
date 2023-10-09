import SwiftUI

public extension Color {
    struct ErrorVariant { }
}

public extension Color.ErrorVariant {
    private static let white = Color(type: .errorLighten1)
    private static let lighten1 = Color(type: .errorLighten1)
    private static let lighten2 = Color(type: .errorLighten2)
    private static let `default` = Color(type: .ErrorDefault)
    private static let darken1 = Color(type: .errorDarken1)
    private static let darken2 = Color(type: .errorDarken2)

    static let error: Color = .ErrorVariant.default
    static let onError: Color = .white
    static let errorContainer: Color = lighten2.darkModeColor(lighten1)
    static let onErrorContainer: Color = darken2
}
