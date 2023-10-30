import SwiftUI
import SwiftUIFlowLayout

struct RecordeView: View {
    enum AnswerStep: Int {
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
    @State private var isLoadingChat: Bool = false
    @State private var selectedMood: Mood?
    @State private var selectedMoodDetail: String?
    @State private var whatisHappening: String = ""
    @State private var isShowImagePicker: Bool = false
    @State private var selectedImage: Image?

    @State private var step: AnswerStep = .appear
    @State private var answerStep: AnswerStep = .appear

    private let loadingTime = 0.5
    private let moodDetailList: [String] = [
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

    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                VStack(spacing: 16) {
                    if step.rawValue >= 0 {
                        questionChat("안녕하세요~ 오늘은 어떤 하루였나요?", step: .mood)
                        
                        if answerStep.rawValue >= 0 {
                            selectMood()
                                .id(0)
                        }
                    }
                    
                    if step.rawValue > 0 {
                        questionChat("""
                                     그렇군요, 오늘 하루 수고 많으셨어요.
                                     (선택한 표정에 따른 메시지)
                                     어떤 감정을 느끼셨나요?
                                     """, step: .moodDetail)
                        
                        if answerStep.rawValue > 0 {
                            selectMoodDetail()
                                .id(1)
                        }
                    }
                    
                    if step.rawValue > 1 {
                        questionChat("""
                                 (선택한 감정에 따른 메시지)
                                 무슨 일이 있었는지 알려주세요.
                                 """, step: .happening)
                        
                        if answerStep.rawValue > 1 {
                            VStack(spacing: 8) {
                                inputWhatIsHappening()
                                
                                nextButton(
                                    isFill: !whatisHappening.isEmpty,
                                    step: .happening
                                )
                                .padding(.horizontal, 16)
                            }
                            .id(2)
                        }
                    }
                    
                    if step.rawValue > 2 {
                        questionChat("""
                                 (격려 메시지)
                                 기억에 남는 사진이 있나요?
                                 """, step: .memorableImage)
                        
                        if answerStep.rawValue > 2 {
                            VStack(spacing: 8) {
                                inputMemorableImage()
                                
                                nextButton(
                                    isFill: selectedImage != nil,
                                    step: .memorableImage
                                )
                                .padding(.horizontal, 16)
                            }
                            .id(3)
                        }
                    }
                    
                    if step.rawValue > 3 {
                        questionChat("다른 사람들과 감정을 공유해보실래요?", step: .share)
                        
                        if answerStep.rawValue > 3 {
                            HStack(spacing: 8) {
                                nextButton(
                                    isFill: false,
                                    step: .share
                                )
                                
                                Button {
                                    hideKeyboard()
                                } label: {
                                    Text("공유하기")
                                        .onuiFont(.body(.medium), color: .Primary.onPrimaryContainer)
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.Primary.primaryContainer)
                                        .cornerRadius(24)
                                }
                            }
                            .padding(.horizontal, 16)
                            .id(4)
                        }
                    }
                }
            }
            .onChange(of: step) { newValue in
                isLoadingChat = true
                delayAfter(loadingTime) {
                    deferDelayAfter(){
                        withAnimation {
                            value.scrollTo(newValue.rawValue, anchor: .bottom)
                        }
                    }
                    withAnimation {
                        isLoadingChat = false
                        answerStep.nextStep()
                    }
                }
            }
        }
        .onAppear {
            step.nextStep()
        }
        .hideKeyboardWhenTap()
        .background(Color.GrayScale.Background.background)
        .imagePicker(
            isShow: $isShowImagePicker,
            image: $selectedImage
        )
    }

    @ViewBuilder
    func questionChat(_ chatString: String, step: AnswerStep) -> some View {
        HStack(spacing: 8) {
            OnuiImage(.chatProfile)
                .frame(48)

            if step == self.step && self.isLoadingChat {
                HStack(spacing: 8) {
                    Circle().fill(Color.GrayScale.Surface.onSurfaceVariant)
                        .frame(8)
                    Circle().fill(Color.GrayScale.Surface.onSurface)
                        .frame(8)
                    Circle().fill(Color.GrayScale.Surface.onSurfaceVariant)
                        .frame(8)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.GrayScale.Surface.surface)
                .cornerRadius(16)
            } else {
                Text(chatString)
                    .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurface)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.GrayScale.Surface.surface)
                    .cornerRadius(16)
            }

            Spacer()
        }
        .padding(.horizontal, 8)
    }

    @ViewBuilder
    func nextButton(isFill: Bool, step: AnswerStep) -> some View {
        var foregroundColor: Color {
            isFill ?
                .Primary.onPrimaryContainer:
                .GrayScale.Background.onBackgroundVariant
        }
        Button {
            hideKeyboard()
            withAnimation {
                if step == self.step {
                    self.step.nextStep()
                }
            }
        } label: {
            Text(isFill ? "작성 완료": "건너뛰기")
                .onuiFont(.body(.medium), color: foregroundColor)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    if isFill {
                        Color.Primary.primaryContainer
                    } else {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.GrayScale.Background.onBackgroundVariant, lineWidth: 1)
                    }
                }
                .cornerRadius(24)
        }
    }

    @ViewBuilder
    func selectMood() -> some View {
        VStack(spacing: 8) {
            Text("오늘은 어떤 하루였나요?")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)

            HStack {
                ForEach(Mood.allCases, id: \.self) { mood in
                    Button {
                        if selectedMood == nil {
                            self.selectedMood = mood
                            withAnimation {
                                step.nextStep()
                            }
                        }
                    } label: {
                        mood.moodImage(isOn: selectedMood == mood)
                            .frame(48)
                    }
                    
                    if mood != .veryBad {
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func selectMoodDetail() -> some View {
        VStack(spacing: 8) {
            Text("오늘 어떤 감정을 느끼셨나요?")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)

            FlowLayout(
                mode: .scrollable,
                binding: $selectedMoodDetail,
                items: moodDetailList,
                itemSpacing: 4
            ) { moodDetail in
                var foregroundColor: Color {
                    moodDetail == selectedMoodDetail ?
                        .Primary.primary :
                        .GrayScale.Outline.outline
                }

                Button {
                    if selectedMoodDetail == nil {
                        selectedMoodDetail = moodDetail
                        withAnimation {
                            step.nextStep()
                        }
                    }
                } label: {
                    Text(moodDetail)
                        .onuiFont(.label, color: foregroundColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(foregroundColor, lineWidth: 1)
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func inputWhatIsHappening() -> some View {
        VStack(spacing: 8) {
            Text("무슨 일이 있었나요?")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
            
            TextField("", text: $whatisHappening)
                .onuiFont(.body(.medium), color: .black)
                .accentColor(.black)
                .frame(height: 34)
                .padding(.horizontal, 8)
                .background(Color.GrayScale.Outline.outlineVariant)
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func inputMemorableImage() -> some View {
        let screenWidthSize: CGFloat = UIScreen.main.bounds.size.width
        VStack(spacing: 8) {
            Text("사진을 선택해주세요")
                .onuiFont(.label, color: .GrayScale.Surface.onSurfaceVariant)
            
            if let selectedImage {
                selectedImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: (screenWidthSize - 64) / 2,
                        maxHeight: screenWidthSize - 64
                    )
                    .cornerRadius(16)
            } else {
                Button {
                    DispatchQueue.main.async {
                        isShowImagePicker.toggle()
                    }
                } label: {
                    Image(systemName: "photo")
                        .foregroundColor(.GrayScale.Surface.onSurfaceVariant)
                        .imageScale(.large)
                        .frame(
                            maxWidth: .infinity, 
                            minHeight: (screenWidthSize - 64) / 2
                        )
                        .background(Color.GrayScale.Outline.outlineVariant)
                        .cornerRadius(16)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }
}

#Preview {
    RecordeView()
}
