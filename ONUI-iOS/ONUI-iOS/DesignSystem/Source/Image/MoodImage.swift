import SwiftUI

enum Mood: CaseIterable {
    case veryGood
    case good
    case normal
    case bad
    case veryBad

    func moodImage(isOn: Bool) -> MoodImage {
        switch self {
        case .good:
            MoodImage(.good, isOn: isOn)

        case .bad:
            MoodImage(.bad, isOn: isOn)

        case .normal:
            MoodImage(.normal, isOn: isOn)

        case .veryGood:
            MoodImage(.veryGood, isOn: isOn)

        case .veryBad:
            MoodImage(.veryBad, isOn: isOn)
        }
    }
}

public struct MoodImage: View {
    public enum Image: Hashable {
        case bad
        case good
        case normal
        case veryBad
        case veryGood
    }

    private var image: Image
    private var isOn: Bool
    private var renderingMode: SwiftUI.Image.TemplateRenderingMode

    public init(
        _ image: Image,
        isOn: Bool,
        renderingMode: SwiftUI.Image.TemplateRenderingMode = .original
    ) {
        self.image = image
        self.isOn = isOn
        self.renderingMode = renderingMode
    }

    public var body: some View {
        oriToImage()
            .resizable()
            .renderingMode(renderingMode)
    }

    private func oriToImage() -> SwiftUI.Image {
        switch image {
        case .bad:
            SwiftUI.Image(isOn ? ImageResource.bad : ImageResource.badOff)
        case .good:
            SwiftUI.Image(isOn ? ImageResource.good : ImageResource.goodOff)
        case .normal:
            SwiftUI.Image(isOn ? ImageResource.normal : ImageResource.normalOff)
        case .veryBad:
            SwiftUI.Image(isOn ? ImageResource.veryBad : ImageResource.veryBadOff)
        case .veryGood:
            SwiftUI.Image(isOn ? ImageResource.veryGood : ImageResource.veryGoodOff)
        }
    }
}
