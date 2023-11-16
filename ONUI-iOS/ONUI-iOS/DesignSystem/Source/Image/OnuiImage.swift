import SwiftUI

public struct OnuiImage: View {
    public enum Image: Hashable {
        case SplashImage
        case Google
        case Link
        case chatProfile
        case chevronLeft
        case chevronRight
    }

    private var image: Image
    private var renderingMode: SwiftUI.Image.TemplateRenderingMode

    public init(
        _ image: Image,
        renderingMode: SwiftUI.Image.TemplateRenderingMode = .original
    ) {
        self.image = image
        self.renderingMode = renderingMode
    }

    public var body: some View {
        oriToImage()
            .resizable()
            .renderingMode(renderingMode)
    }

    private func oriToImage() -> SwiftUI.Image {
        switch image {
        case .SplashImage:
            return SwiftUI.Image(.오누이Splash)

        case .Google:
            return SwiftUI.Image(.google)

        case .Link:
            return SwiftUI.Image(.link)

        case .chatProfile:
            return SwiftUI.Image(.onuiChat)

        case .chevronLeft:
            return SwiftUI.Image(.chevronLeft)

        case .chevronRight:
            return SwiftUI.Image(.chevronRight)
        }
    }
}
