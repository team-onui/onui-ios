import Foundation
import UIKit

enum RecordStep: Int {
    case appear = -1
    case mood = 0
    case moodDetail
    case happening
    case memorableImage
    case share
    case finish

    mutating func nextStep() {
        switch self {
        case .appear:
            self = .mood
        case .mood:
            self = .moodDetail
        case .moodDetail:
            self = .happening
        case .happening:
            self = .memorableImage
        case .memorableImage:
            self = .share
        case .share:
            self = .finish
        case .finish:
            self = .finish
        }
    }
}

final class RecordViewModel: BaseViewModel {
    @Published var isLoadingChat: Bool = false
    @Published var selectedMood: Mood?
    @Published var selectedMoodDetail: String?
    @Published var whatisHappening: String = ""
    @Published var isShowImagePicker: Bool = false
    @Published var selectedImage: UIImage?

    @Published var questionStep: RecordStep = .appear
    @Published var answerStep: RecordStep = .appear

    let loadingTime = 0.5
    let moodDetailList: [String] = [
        "행복해요",
        "편안해요",
        "신나요",
        "자랑스러워요",
        "희망차요",
        "열정적이에요",
        "설레요",
        "새로워요",
        "우울해요",
        "외로워요",
        "불안해요",
        "슬퍼요",
        "화나요",
        "부담돼요",
        "짜증나요",
        "피곤해요"
    ]
}
