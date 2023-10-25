import SwiftUI

public struct OnuiImage: View {
    public enum Image: Hashable {
        case SplashImage
        case Google
        case Link
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
            return SwiftUI.Image(ImageResource.오누이Splash)

        case .Google:
            return SwiftUI.Image(ImageResource.google)

        case .Link:
            return SwiftUI.Image(ImageResource.linkf)
        }
    }
}
