import SwiftUI

public enum Theme: Hashable, CaseIterable {
    case standard
    case hong
    case ssac
    case nya
    
    func toKorean() -> String {
        switch self {
        case .standard:
            return "기본"
        case .hong:
            return "홍조쓰"
        case .ssac:
            return "새싹쓰"
        case .nya:
            return "애옹쓰"
        }
    }

    func toImages() -> [MoodImage] {
        switch self {
        case .standard:
            return MoodImage.Image.Mood.allCases.map { mood in
                MoodImage(.standard(mood), isOn: true)
            }
        case .hong:
            return MoodImage.Image.Mood.allCases.map { mood in
                MoodImage(.hong(mood), isOn: true)
            }
        case .ssac:
            return MoodImage.Image.Mood.allCases.map { mood in
                MoodImage(.ssac(mood), isOn: true)
            }
        case .nya:
            return MoodImage.Image.Mood.allCases.map { mood in
                MoodImage(.nya(mood), isOn: true)
            }
        }
    }

    func toNormalImage() -> some View {
        var image: MoodImage.Image {
            switch self {
            case .standard:
                return .standard(.normal)
            case .hong:
                return .hong(.normal)
            case .ssac:
                return .ssac(.normal)
            case .nya:
                return .nya(.normal)
            }
        }
        return MoodImage(image, isOn: true, renderingMode: .template)
            .foregroundColor(Color.GrayScale.gray3)
    }
}

enum Mood: CaseIterable {
    case veryGood
    case good
    case normal
    case bad
    case veryBad
    
    var foregroundColor: Color {
        switch self {
        case .veryGood:
            return .init(hexCode: "FA8BAC")
        case .good:
            return .init(hexCode: "FFCF71")
        case .normal:
            return .init(hexCode: "F4F1D7")
        case .bad:
            return .init(hexCode: "4F9568")
        case .veryBad:
            return .init(hexCode: "6B7773")
        }
    }

    func moodImage() -> MoodImage.Image.Mood {
        switch self {
        case .good:
            .good

        case .bad:
            .bad

        case .normal:
            .normal

        case .veryGood:
            .veryGood

        case .veryBad:
            .veryBad
        }
    }

    func toKorean() -> String {
        switch self {
        case .veryGood:
            return "매우 좋음"
        case .good:
            return "좋음"
        case .normal:
            return "보통"
        case .bad:
            return "나쁨"
        case .veryBad:
            return "매우 나쁨"
        }
    }
}

public struct MoodImage: View, Hashable {
    public enum Image: Hashable {
        case stroke(Theme)
        case standard(Mood)
        case hong(Mood)
        case ssac(Mood)
        case nya(Mood)
        
        public enum Mood: Hashable, CaseIterable {
            case bad
            case good
            case normal
            case veryBad
            case veryGood
        }
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
        case let .stroke(theme):
            switch theme {
            case .standard:
                SwiftUI.Image(.standardStroke)
            case .hong:
                SwiftUI.Image(.hongStroke)
            case .ssac:
                SwiftUI.Image(.ssacStroke)
            case .nya:
                SwiftUI.Image(.nyaStroke)
            }
        case let .standard(mood):
            switch mood {
            case .bad:
                SwiftUI.Image(isOn ? ImageResource.standardBad : ImageResource.standardBadOff)
            case .good:
                SwiftUI.Image(isOn ? ImageResource.standardGood : ImageResource.standardGoodOff)
            case .normal:
                SwiftUI.Image(isOn ? ImageResource.standardNormal : ImageResource.standardNormalOff)
            case .veryBad:
                SwiftUI.Image(isOn ? ImageResource.standardVeryBad : ImageResource.standardVeryBadOff)
            case .veryGood:
                SwiftUI.Image(isOn ? ImageResource.standardVeryGood : ImageResource.standardVeryGoodOff)
            }
        case let .hong(mood):
            switch mood {
            case .bad:
                SwiftUI.Image(isOn ? ImageResource.hongBad : ImageResource.hongBadOff)
            case .good:
                SwiftUI.Image(isOn ? ImageResource.hongGood : ImageResource.hongGoodOff)
            case .normal:
                SwiftUI.Image(isOn ? ImageResource.hongNormal : ImageResource.hongNormalOff)
            case .veryBad:
                SwiftUI.Image(isOn ? ImageResource.hongVeryBad : ImageResource.hongVeryBadOff)
            case .veryGood:
                SwiftUI.Image(isOn ? ImageResource.hongVeryGood : ImageResource.hongVeryGoodOff)
            }
        case let .ssac(mood):
            switch mood {
            case .bad:
                SwiftUI.Image(isOn ? ImageResource.ssacBad : ImageResource.ssacBadOff)
            case .good:
                SwiftUI.Image(isOn ? ImageResource.ssacGood : ImageResource.ssacGoodOff)
            case .normal:
                SwiftUI.Image(isOn ? ImageResource.ssacNormal : ImageResource.ssacNormalOff)
            case .veryBad:
                SwiftUI.Image(isOn ? ImageResource.ssacVeryBad : ImageResource.ssacVeryBadOff)
            case .veryGood:
                SwiftUI.Image(isOn ? ImageResource.ssacVeryGood : ImageResource.ssacVeryGoodOff)
            }
        case let .nya(mood):
            switch mood {
            case .bad:
                SwiftUI.Image(isOn ? ImageResource.nyaBad : ImageResource.nyaBadOff)
            case .good:
                SwiftUI.Image(isOn ? ImageResource.nyaGood : ImageResource.nyaGoodOff)
            case .normal:
                SwiftUI.Image(isOn ? ImageResource.nyaNormal : ImageResource.nyaNormalOff)
            case .veryBad:
                SwiftUI.Image(isOn ? ImageResource.nyaVeryBad : ImageResource.nyaVeryBadOff)
            case .veryGood:
                SwiftUI.Image(isOn ? ImageResource.nyaVeryGood : ImageResource.nyaVeryGoodOff)
            }
        }
    }
}
