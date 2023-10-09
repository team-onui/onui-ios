import SwiftUI

public extension Color {
    struct Primary { }
}

public extension Color.Primary {
    private static let lighten1 = Color(type: .lighten1)
    private static let lighten2 = Color(type: .lighten2)
    private static let `default` = Color(type: .default)
    private static let darken1 = Color(type: .darken1)
    private static let darken2 = Color(type: .darken2)

    static let primary: Color = .Primary.default
    static let onPrimary: Color = .white
    static let primaryContainer: Color = lighten2.darkModeColor(lighten1)
    static let onPrimaryContainer: Color = darken2
}
