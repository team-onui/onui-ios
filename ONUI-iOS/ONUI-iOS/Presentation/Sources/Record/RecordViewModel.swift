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
    enum PostType {
        case skip
        case share
    }
    @Published var message: String? = nil
    @Published var isSuccessToPost: Bool = false
    @Published var isLoadingChat: Bool = false
    @Published var selectedMood: Mood?
    @Published var selectedMoodDetail: [String] = []
    @Published var whatisHappening: String = ""
    @Published var isShowImagePicker: Bool = false
    @Published var selectedImageUrl: String?

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

    private let writeDiaryUseCase: WriteDiaryUseCase
    private let uploadImageUseCase: UploadImageUseCase
    private let postTimelineUseCase: PostTimelineUseCase
    private let chatUseCase: ChatUseCase

    init(
        writeDiaryUseCase: WriteDiaryUseCase,
        uploadImageUseCase: UploadImageUseCase,
        postTimelineUseCase: PostTimelineUseCase,
        chatUseCase: ChatUseCase
    ) {
        self.writeDiaryUseCase = writeDiaryUseCase
        self.uploadImageUseCase = uploadImageUseCase
        self.postTimelineUseCase = postTimelineUseCase
        self.chatUseCase = chatUseCase
    }

    func selectMoodDetail() {
        questionStep.nextStep()
        chat()
    }

    private func chat() {
        addCancellable(chatUseCase.execute(moodDetail: selectedMoodDetail)) { message in
            self.message = message
        }
    }

    func fetchImageUrl(image: UIImage) {
        guard let data = image.pngData() else { return }
        addCancellable(
            uploadImageUseCase.execute(data: data, fileName: "toDidImage.png")
        ) { [weak self] url in
            self?.selectedImageUrl = url
        }
    }
    private func postTimeline(id: String) {
        addCancellable(postTimelineUseCase.execute(id: id)) { _ in }
    }

    func writeDiary(_ type: PostType) {
        var mood: MoodType {
            guard let selectedMood else { return .notBad }
            switch selectedMood {
            case .veryGood:
                return .good
            case .good:
                return .fine
            case .normal:
                return .notBad
            case .bad:
                return .bad
            case .veryBad:
                return .worst
            }
        }
        addCancellable(
            writeDiaryUseCase.execute(
                req: .init(
                    content: whatisHappening,
                    mood: mood,
                    tagList: selectedMoodDetail,
                    image: selectedImageUrl
                )
            )
        ) { [weak self] res in
            if type == .share {
                self?.postTimeline(id: res.id)
            }

            self?.isSuccessToPost.toggle()
        }
    }

    func redraw() {
        isSuccessToPost = false
        isLoadingChat = false
        selectedMood = nil
        selectedMoodDetail = []
        whatisHappening = ""
        isShowImagePicker = false
        selectedImageUrl = nil
        message = nil

        questionStep = .appear
        answerStep = .appear
    }
}
