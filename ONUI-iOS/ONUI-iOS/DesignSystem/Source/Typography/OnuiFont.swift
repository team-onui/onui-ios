import SwiftUI

public struct OnuiFont: ViewModifier {
    public var style: OnuiFontStyle
    public var weight: OnuiFontWeight

    public func body(content: Content) -> some View {
        content
            .font(.custom("Roboto-\(weight.rawValue)", size: style.size.size))
            .lineSpacing(style.size.lineSpacing)
    }
}

public extension View {
    func xFont(_ style: OnuiFontStyle, weight: OnuiFontWeight = .medium) -> some View {
        self
            .modifier(OnuiFont(style: style, weight: weight))
    }

    func xFont(_ style: OnuiFontStyle, weight: OnuiFontWeight, color: Color) -> some View {
        self
            .xFont(style, weight: weight)
            .foregroundColor(color)
    }
}
