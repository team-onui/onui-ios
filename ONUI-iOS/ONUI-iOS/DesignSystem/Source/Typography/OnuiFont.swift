import SwiftUI

public struct OnuiFont: ViewModifier {
    public var style: OnuiFontStyle

    init(style: OnuiFontStyle) {
        self.style = style
    }

    public func body(content: Content) -> some View {
        let fontHeight = Roboto.fontHeight(weight: style.weight, size: style.size.size)
        content
            .font(.custom("Roboto-\(style.weight)", size: style.size.size))
            .lineSpacing(style.size.lineHeight - fontHeight)
            .padding(.vertical, (style.size.lineHeight - fontHeight) / 2)
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
