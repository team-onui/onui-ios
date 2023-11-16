import SwiftUI

struct Onui: View {
    enum FaceType {
        case chat
        case profile

        func imageResource() -> (ImageResource, ImageResource) {
            switch self {
            case .chat:
                return (.chatOnuiBody, .chatOnuiFace)
            case .profile:
                return (.onuiBody, .onuiFace)
            }
        }
    }
    private let type: FaceType
    private let color: Color
    private let frame: CGFloat

    init(_ type: FaceType, colorHex: String, frame: CGFloat) {
        self.type = type
        self.color = .init(hexCode: colorHex)
        self.frame = frame
    }
    var body: some View {
        ZStack {
            Image(type.imageResource().0)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(color)
                .frame(frame)

            Image(type.imageResource().1)
                .resizable()
                .frame(frame)
        }
    }
}
