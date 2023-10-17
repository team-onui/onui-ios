import SwiftUI

public struct OnuiFont: ViewModifier {
    public var style: OnuiFontStyle

    public func body(content: Content) -> some View {
        content
            .font(.custom("Roboto-\(style.weight.rawValue)", size: style.size.size))
            .lineSpacing(style.size.lineSpacing)
    }
}

public extension View {
    func onuiFont(_ style: OnuiFontStyle) -> some View {
        self
            .modifier(OnuiFont(style: style))
    }

    func onuiFont(_ style: OnuiFontStyle, color: Color) -> some View {
        self
            .onuiFont(style)
            .foregroundColor(color)
    }
}
